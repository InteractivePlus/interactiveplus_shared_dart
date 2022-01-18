import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interactiveplus_exchangeformat/interactiveplus_exchangeformat.dart';
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';

const List<int> codesThatDoesntHaveBody = [204, 304];

class ExchangeFormatClient<SettingType>{
  late String _serverBaseUrl;
  String get serverBaseUrl => _serverBaseUrl;
  set serverBaseUrl(String value){
    if(value.endsWith('/')){
      _serverBaseUrl = value;
    }else{
      _serverBaseUrl = value + '/';
    }
  }

  SettingType settings;

  ExchangeFormatClient(String serverBaseUrl, this.settings){
    this.serverBaseUrl = serverBaseUrl;
  }

  ///Exchange request for info
  ///Possiblely can throw anything that [http.get], [http.put], [http.post], [http.patch], [http.delete] throws
  ///Other than those that throws, a valid [ExchangeResponse] will always be returned, even if there's an error on the server side.
  ///Note that if using the 'get' http method, only one level of parameters will be supported.
  Future<ExchangeResponse<ResponseDataSuccess,ResponseDataFailed>> exchangeForInfoWithRequestSerializableToMap<Request, ResponseDataSuccess, ResponseDataFailed, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<Request, ResponseDataSuccess, ResponseDataFailed, Map<String,dynamic>, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    Request requestParameter
  ) => exchangeForInfo(exchangeFormat, requestParameter, requestSerializedToMap: (Map<String,dynamic> reqSerialized) => reqSerialized);

  ///Exchange request for info
  ///Possiblely can throw anything that [http.get], [http.put], [http.post], [http.patch], [http.delete] throws
  ///Other than those that throws, a valid [ExchangeResponse] will always be returned, even if there's an error on the server side.
  ///Note that if using the 'get' http method, only one level of parameters will be supported.
  Future<ExchangeResponse<ResponseDataSuccess,ResponseDataFailed>> exchangeForInfo<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    Request requestParameter,
    {
      required Map<String,dynamic>? Function(RequestSerialized reqSerialized) requestSerializedToMap,
    }
  ) async {
    //Before sending or serializing request, let's validate this first
    if(exchangeFormat.validateRequest != null){
      Set<String>? validateReqRst = exchangeFormat.validateRequest!(requestParameter,settings);
      if(validateReqRst != null){
        throw RequestFormatException(null,MultipleItemRelatedParams(items: List.from(validateReqRst)));
      }
    }
    Map<String,dynamic>? serializedReqMap = requestSerializedToMap(exchangeFormat.serializeRequest(requestParameter, settings));
    
    String reqRealUrl = exchangeFormat.httpMetaData.relativePathWithoutSlashBeforeStart;
    if(serializedReqMap != null){
      serializedReqMap.removeWhere((key, value){
        String tmpReqRealUrl = reqRealUrl.replaceAll('<$key>',value);
        if(tmpReqRealUrl != reqRealUrl){
          reqRealUrl = tmpReqRealUrl;
          return true;
        }else{
          return false;
        }
      });
    }

    switch(exchangeFormat.httpMetaData.method){
      case ExchangeHTTPMethod.GET:
        return await _exchangeForInfoGetHelper(exchangeFormat, serializedReqMap, reqRealUrl);
      default:
        return await _exchangeForInfoOtherThanGetHelper(exchangeFormat.httpMetaData.method,exchangeFormat, serializedReqMap, reqRealUrl);
    }
  }

  Future<ExchangeResponse<ResponseDataSuccess,ResponseDataFailed>> _exchangeForInfoGetHelper<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    Map<String,dynamic>? serializedRequest,
    String relativePath
  ) async {
    Uri requestUri = Uri.parse(serverBaseUrl + relativePath);
    if(serializedRequest != null){
      requestUri = requestUri.replace(
        queryParameters: Map.from(
          requestUri.queryParameters
          )
          ..addAll(serializedRequest));
    }
    http.Response response = await http.get(requestUri);
    return _decodeBody(exchangeFormat, response);
  }

  Future<ExchangeResponse<ResponseDataSuccess,ResponseDataFailed>> _exchangeForInfoOtherThanGetHelper<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeHTTPMethod method,
    ExchangeFormat<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    Map<String,dynamic>? serializedRequest,
    String relativePath
  ) async {
    Uri requestUri = Uri.parse(serverBaseUrl + relativePath);
    
    Future<http.Response> Function(
      Uri url, {
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding,
    }) httpFireFunc;

    switch(method){
      case ExchangeHTTPMethod.DELETE:
        httpFireFunc = http.delete;
        break;
      case ExchangeHTTPMethod.PATCH:
        httpFireFunc = http.patch;
        break;
      case ExchangeHTTPMethod.PUT:
        httpFireFunc = http.put;
        break;
      default:
      //Code below should be used but since GET is not considered here, use default
      //case ExchangeHTTPMethod.POST:
        httpFireFunc = http.post;
        break;
    }

    http.Response response = await httpFireFunc(requestUri, headers: {'Content-Type': 'application/json'}, body: json.encode(serializedRequest));
    return _decodeBody(exchangeFormat, response);
  }
  
  ExchangeResponse<ResponseDataSuccess,ResponseDataFailed> _decodeBody<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    http.Response response
  ) {
    late ExchangeResponse<ResponseDataSuccess, ResponseDataFailed> exchangeResponse;
    
    if(codesThatDoesntHaveBody.contains(response.statusCode)){
      if(exchangeFormat.httpMetaData.successfulHTTPCode == response.statusCode){
        return ExchangeResponse(exception: null);
      }else{
        return ExchangeResponse(exception: UnknownInnerError());
      }
    }

    try{
      exchangeResponse = exchangeFormat.parseAndValidateResponse(json.decode(response.body) as Map<String,dynamic>, settings);
    }catch(e){
      return ExchangeResponse(exception: UnknownInnerError());
    }
    return exchangeResponse;
  }
}