/*
MIT License

Copyright (c) 2021 interactiveplus.org and Yunhao Cao (Github @ ToiletCommander)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */


import 'package:equatable/equatable.dart';
import 'package:interactiveplus_shared_dart/src/errors/ErrorParams.dart';
import 'package:interactiveplus_shared_dart/src/utils/serializable.dart';
import 'package:intl/intl.dart';

/// Possible Types of Exceptions that stores errCode, errName and errPrompt and canExposeToClient
/// 
/// All properties are final and should not be changed.
class InteractivePlusSystemExceptionType extends Equatable implements Serializable<int>{
  final String errName;
  final int errCode;
  final String Function([String? locale]) errPrompt;
  final bool canExposeToClient;
  InteractivePlusSystemExceptionType._(this.errName, this.errCode, this.canExposeToClient, this.errPrompt);

  @override
  List<Object> get props => [errCode];

  @override
  int serialize([String? locale]){
    return errCode;
  }

  @override
  int toJson(){
    return serialize(null);
  }

  factory InteractivePlusSystemExceptionType.fromInt(int serialized){
    if(serialized == NO_ERROR.errCode){
        return NO_ERROR;
    }else if(serialized == UNKNOWN_INNER_ERROR.errCode){
      return UNKNOWN_INNER_ERROR;
    }else if(serialized == INNER_PARSE_EXCEPTION.errCode){
      return INNER_PARSE_EXCEPTION;
    }else if(serialized == STROAGE_ENGINE_FAILURE.errCode){
      return STROAGE_ENGINE_FAILURE;
    }else if(serialized == OUTER_SERVICE_CREDENTIAL_MISMATCH.errCode){
      return OUTER_SERVICE_CREDENTIAL_MISMATCH;
    }else if(serialized == OUTER_SERVICE_FAILURE.errCode){
      return OUTER_SERVICE_FAILURE;
    }else if(serialized == REQUEST_FORMAT_EXCEPTION.errCode){
      return REQUEST_FORMAT_EXCEPTION;
    }else if(serialized == ITEM_NOT_FOUND_EXCEPTION.errCode){
      return ITEM_NOT_FOUND_EXCEPTION;
    }else if(serialized == ITEM_ALREADY_EXIST_EXCEPTION.errCode){
      return ITEM_ALREADY_EXIST_EXCEPTION;
    }else if(serialized == ITEM_EXPIRED_EXCEPTION.errCode){
      return ITEM_EXPIRED_EXCEPTION;
    }else if(serialized == ITEM_USED_EXCEPTION.errCode){
      return ITEM_USED_EXCEPTION;
    }else if(serialized == CREDENTIAL_MISMATCH_EXCEPTION.errCode){
      return CREDENTIAL_MISMATCH_EXCEPTION;
    }else if(serialized == PERMISSION_DENIED_EXCEPTION.errCode){
      return PERMISSION_DENIED_EXCEPTION;
    }else if(serialized == TOO_MANY_REQUESTS_EXCEPTION.errCode){
      return TOO_MANY_REQUESTS_EXCEPTION;
    }else if(serialized == SYSTEM_BUSY_EXCEPTION.errCode){
      return SYSTEM_BUSY_EXCEPTION;
    }else{
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
  }

  static InteractivePlusSystemExceptionType fromJson(int json){
    return InteractivePlusSystemExceptionType.fromInt(json);
  }
  static InteractivePlusSystemExceptionType? fromJsonNullable(int? json) => json == null ? null : fromJson(json);

  static final NO_ERROR = InteractivePlusSystemExceptionType._(
    "NoErr", 
    0, 
    true,
    ([locale]) => Intl.message(
      'No error.',
      desc: 'Give prompt to user that no error has been found',
      locale: locale,
      name: 'NoErrPrompt'
    )
  );
  static final UNKNOWN_INNER_ERROR = InteractivePlusSystemExceptionType._(
    "UnknownInnerError", 
    -1, 
    true,
    ([locale]) => Intl.message(
      "An unknown inner error occurred.",
      name: "UnknownInnerErrorPrompt",
      desc: "Give prompt to user that an unknown inner error has occurred.",
      locale: locale
    )
  );
  static final INNER_PARSE_EXCEPTION = InteractivePlusSystemExceptionType._(
    "InnerParseException", 
    1, 
    true,
    ([locale]) => Intl.message(
      "An inner exception occurred while parsing data",
      name: "InnerParsePrompt",
      desc: "Give prompt to user that an inner parse exception has occurred.",
      locale: locale
    )
  );
  static final STROAGE_ENGINE_FAILURE = InteractivePlusSystemExceptionType._(
    "StorageEngineFailure", 
    2, 
    false,
    ([locale]) => Intl.message(
      "A storage engine failure occurred.",
      name: "StorageEngineFailurePrompt",
      desc: "Give prompt to user that a storage engine failure has occurred.",
      locale: locale
    )
  );
  static final OUTER_SERVICE_CREDENTIAL_MISMATCH = InteractivePlusSystemExceptionType._(
    "OuterServiceCredentialMismatch", 
    3, 
    false,
    ([locale]) => Intl.message(
      'Authentication failed for outer service.',
      name: "OuterServiceCredentialMismatchPrompt",
      desc:"Give prompt to user that an outer service failed to gain authentication from the service.",
      locale: locale
    )
  );
  static final OUTER_SERVICE_FAILURE = InteractivePlusSystemExceptionType._(
    "OuterServiceFailure",
    4, 
    true,
    ([locale]) => Intl.message(
      "An outer service experienced an failure, the system is unable to process your request.",
      name: "OuterServiceFailurePrompt",
      desc: "Give prompt to user that an outer service failed to perform an action.",
      locale: locale
    )
  );
  static final REQUEST_FORMAT_EXCEPTION = InteractivePlusSystemExceptionType._(
    "RequestFormatException", 
    10001, 
    true,
    ([locale]) => Intl.message(
      "The reqeust is not formatted correctly.",
      name: "RequestFormatExceptionPrompt",
      desc: "Give prompt to user that the request is not formatted correctly.",
      locale: locale
    )
  );
  static final ITEM_NOT_FOUND_EXCEPTION = InteractivePlusSystemExceptionType._(
    "ItemNotFoundException",
    20001, 
    true,
    ([locale]) => Intl.message(
      "Item not found.",
      name: "ItemNotFoundPrompt",
      desc: "Prompt the use that the requested item/object is not found.",
      locale: locale
    )
  );
  static final ITEM_ALREADY_EXIST_EXCEPTION = InteractivePlusSystemExceptionType._(
    "ItemAlreadyExistException", 
    20002, 
    true,
    ([locale]) => Intl.message(
      "Item already exist.",
      name: "ItemAlreadyExistPrompt",
      desc: "Give prompt to user that the item already exists.",
      locale: locale
    )
  );
  static final ITEM_EXPIRED_EXCEPTION = InteractivePlusSystemExceptionType._(
    "ItemExpiredException",
    20003, 
    true,
    ([locale]) => Intl.message(
      "Item expired.",
      name: "ItemExpiredPrompt",
      desc: "Give prompt to user that the requested item/object has expired.",
      locale: locale
    )
  );
  static final ITEM_USED_EXCEPTION = InteractivePlusSystemExceptionType._(
    "ItemUsedException", 
    20004, 
    true,
    ([locale]) => Intl.message(
      "Item used.",
      name: "ItemUsedPrompt",
      desc: "Give prompt to user that the requested item/object has been used.",
      locale: locale
    )
  );
  static final CREDENTIAL_MISMATCH_EXCEPTION = InteractivePlusSystemExceptionType._(
    "CredentialMismatchException", 
    30001, 
    true,
    ([locale]) => Intl.message(
      "Provided credential does not match with what we have on record.",
      name: "CredentialMismatchPrompt",
      desc: "Give prompt to user that the credential does not match what we have.",
      locale: locale
    )
  );
  static final PERMISSION_DENIED_EXCEPTION = InteractivePlusSystemExceptionType._(
    "PermissionDeniedException", 
    40001, 
    true,
    ([locale]) => Intl.message(
      "Permission denied.",
      name: "PermDeniedPrompt",
      desc: "Give prompt to user that the operation does not match the permission level of the identity.",
      locale: locale
    )
  );
  static final TOO_MANY_REQUESTS_EXCEPTION = InteractivePlusSystemExceptionType._(
    "TooManyRequestsException", 
    90001, 
    true,
    ([locale]) => Intl.message(
      "Too many requests submitted.",
      name: "TooManyReqPrompt",
      desc: "Give prompt to user that there have been too many requests submitted.",
      locale: locale
    )
  );
  static final SYSTEM_BUSY_EXCEPTION = InteractivePlusSystemExceptionType._(
    "SystemBusyException", 
    90002, 
    true,
    ([locale]) => Intl.message(
      "System is busy right now.",
      name: "SystemBusyPrompt",
      desc: "Give prompt to user that the system is too busy to handle requests.",
      locale: locale
    )
  );
}

class InteractivePlusSystemException<ParameterType> extends Equatable implements Exception, Serializable<Map<String,dynamic>>{
  static final InteractivePlusSystemException<void> NO_ERROR_EXCEPTION = InteractivePlusSystemException._(
    InteractivePlusSystemExceptionType.NO_ERROR, 
    null, 
    null
  );
  static final InnerParseException SERIALIZATION_EXCEPTION = InnerParseException(([locale]) => Intl.message(
    "An exception occurrred during serialization or deserialization process.",
    name: "SerializationExceptionPrompt",
    desc: "Prompt user that an error occured during serialization or deserialization.",
    locale: locale
  ));

  final InteractivePlusSystemExceptionType errType;
  final String Function([String? locale])? errMessage;
  final ParameterType? errParams;
  String get message{
    return errMessage == null ? errType.errPrompt(null) : errMessage!(null);
  }
  InteractivePlusSystemException._(this.errType, this.errMessage, this.errParams);

  @override
  List<Object?> get props => [errType, errMessage!(), errParams];

  static InteractivePlusSystemException<dynamic> fromMap(Map<String,dynamic> map){
    if(map['errCode'] == null || map['errCode'] is! int){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    int errCode = map['errCode'];
    if(errCode == InteractivePlusSystemExceptionType.NO_ERROR.errCode){
        return NO_ERROR_EXCEPTION;
    }else if(errCode == InteractivePlusSystemExceptionType.UNKNOWN_INNER_ERROR.errCode){
      return UnknownInnerError.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.INNER_PARSE_EXCEPTION.errCode){
      return InnerParseException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.STROAGE_ENGINE_FAILURE.errCode){
      return StorageEngineFailure.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.OUTER_SERVICE_CREDENTIAL_MISMATCH.errCode){
      return OuterServiceCredentialMismatchException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.OUTER_SERVICE_FAILURE.errCode){
      return OuterServiceFailedException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.REQUEST_FORMAT_EXCEPTION.errCode){
      return RequestFormatException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.ITEM_NOT_FOUND_EXCEPTION.errCode){
      return ItemNotFoundException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.ITEM_ALREADY_EXIST_EXCEPTION.errCode){
      return ItemAlreadyExistException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.ITEM_EXPIRED_EXCEPTION.errCode){
      return ItemExpiredException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.ITEM_USED_EXCEPTION.errCode){
      return ItemUsedException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.CREDENTIAL_MISMATCH_EXCEPTION.errCode){
      return CredentialMismatchException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.PERMISSION_DENIED_EXCEPTION.errCode){
      return PermissionDeniedException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.TOO_MANY_REQUESTS_EXCEPTION.errCode){
      return TooManyRequestsException.fromMap(map);
    }else if(errCode == InteractivePlusSystemExceptionType.SYSTEM_BUSY_EXCEPTION.errCode){
      return SystemBusyException.fromMap(map);
    }
    throw SERIALIZATION_EXCEPTION;
  }
  
  static InteractivePlusSystemException fromJson(Map<String, dynamic> json){
    return InteractivePlusSystemException.fromMap(json);
  }
  
  static InteractivePlusSystemException? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]){

    Map<String, dynamic> rt = {
      'errCode': errType.errCode
    };

    if(errParams != null){
      if(errParams is Serializable){
        rt['errParams'] = (errParams as Serializable).serialize(locale);
      }else{
        rt['errParams'] = errParams;
      }
    }
    
    if(errMessage != null){
      rt['errMessage'] = errMessage!(locale);
    }
    return rt;
  }

  @override
  Map<String, dynamic> toJson() {
    return serialize(null);
  }
}

class UnknownInnerError extends InteractivePlusSystemException<void>{
  UnknownInnerError([String Function([String? locale])? errMessage])
    : super._(InteractivePlusSystemExceptionType.UNKNOWN_INNER_ERROR,errMessage,null);
  factory UnknownInnerError.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.UNKNOWN_INNER_ERROR.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    return UnknownInnerError(errMessageDecoded);
  }
}

class InnerParseException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  InnerParseException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.INNER_PARSE_EXCEPTION,errMessage,parameter);
  factory InnerParseException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.INNER_PARSE_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return InnerParseException(errMessageDecoded,errParamDecoded);
  }
}


class StorageEngineFailure extends InteractivePlusSystemException<StorageEngineFailureParams>{
  StorageEngineFailure([String Function([String? locale])? errMessage, StorageEngineFailureParams? parameter])
    : super._(InteractivePlusSystemExceptionType.STROAGE_ENGINE_FAILURE,errMessage,parameter);
  factory StorageEngineFailure.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.STROAGE_ENGINE_FAILURE.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    StorageEngineFailureParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = StorageEngineFailureParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return StorageEngineFailure(errMessageDecoded,errParamDecoded);
  }
}

class OuterServiceCredentialMismatchException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  OuterServiceCredentialMismatchException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.OUTER_SERVICE_CREDENTIAL_MISMATCH,errMessage,parameter);
  factory OuterServiceCredentialMismatchException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.OUTER_SERVICE_CREDENTIAL_MISMATCH.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return OuterServiceCredentialMismatchException(errMessageDecoded,errParamDecoded);
  }
}

class OuterServiceFailedException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  OuterServiceFailedException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.OUTER_SERVICE_FAILURE,errMessage,parameter);
  factory OuterServiceFailedException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.OUTER_SERVICE_FAILURE.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return OuterServiceFailedException(errMessageDecoded,errParamDecoded);
  }
}

class RequestFormatException extends InteractivePlusSystemException<MultipleItemRelatedParams>{
  RequestFormatException([String Function([String? locale])? errMessage, MultipleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.REQUEST_FORMAT_EXCEPTION,errMessage,parameter);
  factory RequestFormatException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.REQUEST_FORMAT_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    MultipleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = MultipleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return RequestFormatException(errMessageDecoded,errParamDecoded);
  }
}

class ItemNotFoundException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  ItemNotFoundException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.ITEM_NOT_FOUND_EXCEPTION,errMessage,parameter);
  factory ItemNotFoundException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.ITEM_NOT_FOUND_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return ItemNotFoundException(errMessageDecoded,errParamDecoded);
  }
}

class ItemAlreadyExistException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  ItemAlreadyExistException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.ITEM_ALREADY_EXIST_EXCEPTION,errMessage,parameter);
  factory ItemAlreadyExistException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.ITEM_ALREADY_EXIST_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return ItemAlreadyExistException(errMessageDecoded,errParamDecoded);
  }
}

class ItemExpiredException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  ItemExpiredException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.ITEM_EXPIRED_EXCEPTION,errMessage,parameter);
  factory ItemExpiredException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.ITEM_EXPIRED_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return ItemExpiredException(errMessageDecoded,errParamDecoded);
  }
}

class ItemUsedException extends InteractivePlusSystemException<SingleItemRelatedParams>{
  ItemUsedException([String Function([String? locale])? errMessage, SingleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.ITEM_USED_EXCEPTION,errMessage,parameter);
  factory ItemUsedException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.ITEM_USED_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    SingleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = SingleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return ItemUsedException(errMessageDecoded,errParamDecoded);
  }
}

class CredentialMismatchException extends InteractivePlusSystemException<MultipleItemRelatedParams>{
  CredentialMismatchException([String Function([String? locale])? errMessage, MultipleItemRelatedParams? parameter])
    : super._(InteractivePlusSystemExceptionType.CREDENTIAL_MISMATCH_EXCEPTION,errMessage,parameter);
  factory CredentialMismatchException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.CREDENTIAL_MISMATCH_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    MultipleItemRelatedParams? errParamDecoded;
    if(map['errParams'] != null && map['errParams'] is Map<String,dynamic>){
      try{
        errParamDecoded = MultipleItemRelatedParams.fromMap(map['errParams']);
      }catch(e){
        errParamDecoded = null;
      }
    }
    return CredentialMismatchException(errMessageDecoded,errParamDecoded);
  }
}

class PermissionDeniedException extends InteractivePlusSystemException<void>{
  PermissionDeniedException([String Function([String? locale])? errMessage])
    : super._(InteractivePlusSystemExceptionType.PERMISSION_DENIED_EXCEPTION,errMessage,null);
  factory PermissionDeniedException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.PERMISSION_DENIED_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    return PermissionDeniedException(errMessageDecoded);
  }
}

class TooManyRequestsException extends InteractivePlusSystemException<void>{
  TooManyRequestsException([String Function([String? locale])? errMessage])
    : super._(InteractivePlusSystemExceptionType.TOO_MANY_REQUESTS_EXCEPTION,errMessage,null);
  factory TooManyRequestsException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.TOO_MANY_REQUESTS_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    return TooManyRequestsException(errMessageDecoded);
  }
}

class SystemBusyException extends InteractivePlusSystemException<void>{
  SystemBusyException([String Function([String? locale])? errMessage])
    : super._(InteractivePlusSystemExceptionType.SYSTEM_BUSY_EXCEPTION,errMessage,null);
  factory SystemBusyException.fromMap(Map<String, dynamic> map){
    if(map['errCode'] == null
       || map['errCode'] is! int
       || map['errCode'] != InteractivePlusSystemExceptionType.SYSTEM_BUSY_EXCEPTION.errCode
    ){
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    String Function([String? locale])? errMessageDecoded;
    if(map['errMessage'] != null && map['errMessage'] is String){
      errMessageDecoded = ([locale]) => map['errMessage'];
    }
    return SystemBusyException(errMessageDecoded);
  }
}
