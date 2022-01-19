import 'dart:convert';

import 'package:interactiveplus_exchangeformat/interactiveplus_exchangeformat.dart';
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

final _pdkErrCodeToHttpCode = {
  InteractivePlusSystemExceptionType.CREDENTIAL_MISMATCH_EXCEPTION.errCode: 401,
  InteractivePlusSystemExceptionType.INNER_PARSE_EXCEPTION.errCode: 500,
  InteractivePlusSystemExceptionType.ITEM_ALREADY_EXIST_EXCEPTION.errCode: 409,
  InteractivePlusSystemExceptionType.ITEM_EXPIRED_EXCEPTION.errCode: 409,
  InteractivePlusSystemExceptionType.ITEM_NOT_FOUND_EXCEPTION.errCode: 409,
  InteractivePlusSystemExceptionType.ITEM_USED_EXCEPTION.errCode: 409,
  InteractivePlusSystemExceptionType.OUTER_SERVICE_CREDENTIAL_MISMATCH.errCode: 500,
  InteractivePlusSystemExceptionType.OUTER_SERVICE_FAILURE.errCode: 500,
  InteractivePlusSystemExceptionType.PERMISSION_DENIED_EXCEPTION.errCode: 403,
  InteractivePlusSystemExceptionType.REQUEST_FORMAT_EXCEPTION.errCode: 400,
  InteractivePlusSystemExceptionType.STROAGE_ENGINE_FAILURE.errCode: 500,
  InteractivePlusSystemExceptionType.SYSTEM_BUSY_EXCEPTION.errCode: 503,
  InteractivePlusSystemExceptionType.TOO_MANY_REQUESTS_EXCEPTION.errCode: 429,
  InteractivePlusSystemExceptionType.UNKNOWN_INNER_ERROR.errCode: 500
};

class ExchangeFormatRouter<SettingType>{
  Router router;
  SettingType sharedSettings;
  ExchangeFormatRouter(this.router, this.sharedSettings);
  void add<RequestType, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<RequestType, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    Future<ExchangeResponse<ResponseDataSuccess, ResponseDataFailed>> Function(RequestType req) exchangeFormatHandler,
    {
      required RequestSerialized Function(Map<String,dynamic> map) deserializeRequestFromMap
    }
  ){
    Future<Response> shelfRequestHandler(Request shelfReq) async {
      String body = await shelfReq.readAsString();
      Map<String,dynamic>? bodyMap;
      try{
        bodyMap = json.decode(body);
      }catch(e){
        bodyMap = null;
      }
      Map<String,dynamic> requestMap = bodyMap == null ? Map.from(shelfReq.params) : Map.from(bodyMap)..addAll(shelfReq.params);
      
      late RequestType req;
      try{
        RequestSerialized reqSerialized = deserializeRequestFromMap(requestMap);
        req = exchangeFormat.parseRequest(reqSerialized,sharedSettings);
      }catch(e){
        return _transferExceptionToResponse(exchangeFormat, RequestFormatException());
      }

      if(exchangeFormat.validateRequest != null){
        Set<String>? validateRst = exchangeFormat.validateRequest!(req, sharedSettings);
        if(validateRst != null){
          return _transferExceptionToResponse(exchangeFormat, RequestFormatException(null,MultipleItemRelatedParams(items: List<String>.from(validateRst))));
        }
      }

      late ExchangeResponse<ResponseDataSuccess, ResponseDataFailed> response;
      try{
        response = await exchangeFormatHandler(req);
      }catch(e){
        _transferExceptionToResponse(exchangeFormat, e);
      }

      Response returnHttpResponse = _transferExchangeFormatResponseToHttpResponse(exchangeFormat, response);
      return returnHttpResponse;
    }
    
    late void Function(String route, Function handler) routerAdder;
    switch(exchangeFormat.httpMetaData.method){
      case ExchangeHTTPMethod.GET:
        routerAdder = router.get;
        break;
      case ExchangeHTTPMethod.DELETE:
        routerAdder = router.delete;
        break;
      case ExchangeHTTPMethod.PATCH:
        routerAdder = router.patch;
        break;
      case ExchangeHTTPMethod.POST:
        routerAdder = router.post;
        break;
      default:
      //case ExchangeHTTPMethod.PUT:
        routerAdder = router.put;
    }
    routerAdder('/' + exchangeFormat.httpMetaData.relativePathWithoutSlashBeforeStart,shelfRequestHandler);
  }
  Response _transferExchangeFormatResponseToHttpResponse<RequestType, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<RequestType, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    ExchangeResponse<ResponseDataSuccess, ResponseDataFailed> response
  ){
    int httpStatus = 500;
    if(response.exception == null || response.exception!.errType.errCode == InteractivePlusSystemExceptionType.NO_ERROR.errCode){
      httpStatus = exchangeFormat.httpMetaData.successfulHTTPCode;
    }else{
      httpStatus = _pdkErrCodeToHttpCode[response.exception!.errType.errCode] ?? 500;
    }
    
    Map<String,dynamic> responseMap = ExchangeResponse.serializeStatic<ResponseDataSuccess,ResponseDataFailed,ResponseDataSuccessSerialized,ResponseDataFailedSerialized>(
      response, 
      (data) => exchangeFormat.serializeSuccessResponseData<SettingType>(
        data,
        sharedSettings
      ), 
      (data) => exchangeFormat.serializeFailedResponseData<SettingType>(
        data,
        sharedSettings
      )
    );
    late Response httpResponse;
    try{
      httpResponse = Response(
        httpStatus,
        body: json.encode(responseMap),
        headers: {
          'Content-Type': 'application/json'
        }
      );
    }catch(e){
      void Function(void data) transferData = (data){return;};
      ExchangeResponse<void,void> res = ExchangeResponse(
        exception: UnknownInnerError(
          ([locale]) => 'Could not serialize error to JSON, error is not trnasmitted'
        ),
        data: null,
        failData: null
      );
      httpResponse = Response(
        500,
        body: json.encode(ExchangeResponse.serializeStatic(res, transferData, transferData)),
        headers: {
          'Content-Type': 'application/json'
        }
      );
    }
    return httpResponse;
  }
  Response _transferExceptionToResponse<RequestType, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized>(
    ExchangeFormat<RequestType, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType> exchangeFormat,
    dynamic exception
  ){
    if(exception is InteractivePlusSystemException){
      return _transferExchangeFormatResponseToHttpResponse(exchangeFormat, ExchangeResponse<ResponseDataSuccess,ResponseDataFailed>(exception: exception, data: null, failData: null));
    }else{
      return _transferExchangeFormatResponseToHttpResponse(exchangeFormat, ExchangeResponse<ResponseDataSuccess,ResponseDataFailed>(exception: UnknownInnerError(),data: null, failData: null));
    }
  }
}