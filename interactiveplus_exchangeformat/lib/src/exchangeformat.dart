import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchangeformat.g.dart';

class ExchangeResponse<SuccessData, FailData>{
  InteractivePlusSystemException? exception;
  SuccessData? data;
  FailData? failData;
  ExchangeResponse({
    this.exception,
    this.data,
    this.failData
  });
  static ExchangeResponse<SuccessData, FailedData> deserializeStatic<SuccessData, FailedData, SuccessDataSerialized, FailedDataSerialized>(
    Map<String,dynamic> map,
    SuccessData Function(SuccessDataSerialized data) successDataDeserializer,
    FailedData Function(FailedDataSerialized data) failedDataDeserializer
  ){
    return ExchangeResponse<SuccessData, FailedData>(
      exception: InteractivePlusSystemException.fromJsonNullable(map['exception']),
      data: map['data'] == null ? null : successDataDeserializer(map['data'] as SuccessDataSerialized),
      failData: map['failed_data'] == null ? null : failedDataDeserializer(map['failed_data'] as FailedDataSerialized)
    );
  }
  static Map<String,dynamic> serializeStatic<SuccessData, FailedData, SuccessDataSerialized, FailedDataSerialized>(
    ExchangeResponse<SuccessData, FailedData> response, 
    SuccessDataSerialized Function(SuccessData data) successDataSerializer,
    FailedDataSerialized Function(FailedData data) failedDataSerializer
  ){
    Map<String,dynamic> returnMap = {};
    if(response.exception != null){
      returnMap['exception'] = response.exception!.toJson();
    }
    if(response.data != null){
      returnMap['data'] = successDataSerializer(response.data!);
    }
    if(response.failData != null){
      returnMap['failed_data'] = failedDataSerializer(response.failData!);
    }
    return returnMap;
  }
}

@JsonEnum()
enum ExchangeHTTPMethod{
  @JsonValue('GET')
  GET,
  @JsonValue('POST')
  POST,
  @JsonValue('PUT')
  PUT,
  @JsonValue('DELETE')
  DELETE,
  @JsonValue('PATCH')
  PATCH
}

@JsonSerializable()
class ExchangeHTTPMetaData implements Serializable<Map<String,dynamic>>{
  final int successfulHTTPCode;
  final List<int> possibleHTTPCodes;
  final String relativePathWithParameterMarkedWithLtAndGtSymbols;
  final ExchangeHTTPMethod method;

  const ExchangeHTTPMetaData({
    required this.method,
    required this.successfulHTTPCode,
    required this.possibleHTTPCodes,
    required this.relativePathWithParameterMarkedWithLtAndGtSymbols
  });
  factory ExchangeHTTPMetaData.fromMap(Map<String,dynamic> map) => _$ExchangeHTTPMetaDataFromJson(map);
  static ExchangeHTTPMetaData fromJson(Map<String,dynamic> json) => ExchangeHTTPMetaData.fromMap(json);
  static ExchangeHTTPMetaData? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
  
  @override
  Map<String, dynamic> serialize([String? locale]) => _$ExchangeHTTPMetaDataToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

@JsonSerializable()
class ExchangeRateLimitMetaData implements Serializable<Map<String,dynamic>>{
  final int? numRequestPerIPPerMin;
  final int? numRequestPerUserPerMin;
  final int? numRequestPerAPPPerMin;
  final int? numRequestPerOAuthTokenPerMin;

  const ExchangeRateLimitMetaData({
    this.numRequestPerIPPerMin,
    this.numRequestPerAPPPerMin,
    this.numRequestPerUserPerMin,
    this.numRequestPerOAuthTokenPerMin
  });
  factory ExchangeRateLimitMetaData.fromMap(Map<String,dynamic> map) => _$ExchangeRateLimitMetaDataFromJson(map);
  static ExchangeRateLimitMetaData fromJson(Map<String,dynamic> json) => ExchangeRateLimitMetaData.fromMap(json);
  static ExchangeRateLimitMetaData? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
  
  @override
  Map<String, dynamic> serialize([String? locale]) => _$ExchangeRateLimitMetaDataToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

void exchangeVoidToVoidFunction<SettingType>(
  void serialized, 
  SettingType settings
) {
  return;
}

ReturnType Function<SettingType>(FirstVarType i, SettingType sharedSettings) convertToExchangeFormatApplicableFunc<ReturnType, FirstVarType>(ReturnType Function(FirstVarType firstVar) func){
  return <SettingType>(
    FirstVarType i, 
    SettingType sharedSettings
  ) => func(i);
}

class ExchangeFormat<Request, ResponseDataSuccess, ResponseDataFailed, RequestSerialized, ResponseDataSuccessSerialized, ResponseDataFailedSerialized, SettingType>{
  final String exchangeProtocolName;
  final ExchangeHTTPMetaData httpMetaData;
  final ExchangeRateLimitMetaData rateLimitMetaData;
  final bool requireVerificationCode;
  final String? requiredVerificationCodeScope;
  
  final Request Function<FineSettingType extends SettingType>(RequestSerialized serialized, FineSettingType sharedSettings) parseRequest;
  final RequestSerialized Function<FineSettingType extends SettingType>(Request req, FineSettingType sharedSettings) serializeRequest;
  
  ///Validate Requests should return map key in the serialized request data structure that triggered the error
  ///If null is returned, it means the Request Object has passed the test.
  final List<String>? Function<FineSettingType extends SettingType>(Request req, SettingType sharedSettings)? validateRequest;
  
  final ResponseDataSuccess Function<FineSettingType extends SettingType>(ResponseDataSuccessSerialized serialized, FineSettingType sharedSettings) parseSuccessResponseData;
  final ResponseDataFailed Function<FineSettingType extends SettingType>(ResponseDataFailedSerialized serialized, FineSettingType sharedSettings) parseFailedResponseData;
  final ResponseDataSuccessSerialized Function<FineSettingType extends SettingType>(ResponseDataSuccess data, FineSettingType sharedSettings) serializeSuccessResponseData;
  final ResponseDataFailedSerialized Function<FineSettingType extends SettingType>(ResponseDataFailed data, FineSettingType sharedSettings) serializeFailedResponseData;
  final bool Function<FineSettingType extends SettingType>(ResponseDataSuccess resDataSuccess, FineSettingType sharedSettings)? validateResponseDataSuccess;
  final bool Function<FineSettingType extends SettingType>(ResponseDataFailed reqDataFailed, FineSettingType sharedSettings)? validateResponseDataFailed;

  ExchangeFormat({
    required this.exchangeProtocolName,
    required this.httpMetaData,
    required this.rateLimitMetaData,
    required this.parseRequest,
    required this.serializeRequest,
    this.validateRequest,
    required this.parseSuccessResponseData,
    required this.parseFailedResponseData,
    required this.serializeSuccessResponseData,
    required this.serializeFailedResponseData,
    required this.requireVerificationCode,
    this.requiredVerificationCodeScope,
    this.validateResponseDataSuccess,
    this.validateResponseDataFailed
  });

  ExchangeResponse<ResponseDataSuccess, ResponseDataFailed> parseResponse<FineSettingType extends SettingType>(
    Map<String,dynamic> map,
    FineSettingType sharedSettings 
  ) => ExchangeResponse.deserializeStatic(
    map, 
    (ResponseDataSuccessSerialized serializedSucc) => parseSuccessResponseData(serializedSucc,sharedSettings), 
    (ResponseDataFailedSerialized serializedFail) => parseFailedResponseData(serializedFail,sharedSettings)
  );
  ExchangeResponse<ResponseDataSuccess, ResponseDataFailed> parseAndValidateResponse<FineSettingType extends SettingType>
  (
    Map<String,dynamic> map,
    FineSettingType sharedSettings
  ){
    var parsed = parseResponse(map, sharedSettings);
    if(validateResponseDataSuccess != null && parsed.data != null && !validateResponseDataSuccess!(parsed.data!, sharedSettings)){
      throw InnerParseException();
    }
    if(validateResponseDataFailed != null && parsed.failData != null && !validateResponseDataFailed!(parsed.failData!, sharedSettings)){
      throw InnerParseException();
    }
    return parsed;
  }
  
}