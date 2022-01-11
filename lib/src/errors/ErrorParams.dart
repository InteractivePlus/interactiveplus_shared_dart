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
import 'package:interactiveplus_shared_dart/src/utils/serializable.dart';
import 'package:interactiveplus_shared_dart/src/errors/errors.dart';

class SingleItemRelatedParams extends Equatable implements Serializable<Map<String,dynamic>>{
  final String item;
  SingleItemRelatedParams({required this.item});
  @override
  Map<String,dynamic> serialize([String? locale]){
    Map<String, dynamic> rt = {
      "item": item
    };
    return rt;
  }
  factory SingleItemRelatedParams.fromMap(Map<String,dynamic> map){
    if(map['item'] != null && map['item'] is String){
      return SingleItemRelatedParams(item: map['item']);
    }else{
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
  }

  static SingleItemRelatedParams fromJson(Map<String,dynamic> json){
    return SingleItemRelatedParams.fromMap(json);
  }
  static SingleItemRelatedParams? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  List<Object?> get props => [item];

  @override
  Map<String, dynamic> toJson() {
    return serialize(null);
  }
}

class MultipleItemRelatedParams extends Equatable implements Serializable<Map<String,dynamic>>{
  final List<String> items;
  MultipleItemRelatedParams({required this.items});
  @override
  Map<String,dynamic> serialize([String? locale]){
    Map<String, dynamic> rt = {
      "items": items
    };
    return rt;
  }
  factory MultipleItemRelatedParams.fromMap(Map<String,dynamic> map){
    if(map['items'] != null && map['items'] is List<String>){
      return MultipleItemRelatedParams(items: map['items']);
    }else{
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
  }

  static MultipleItemRelatedParams fromJson(Map<String,dynamic> json){
    return MultipleItemRelatedParams.fromMap(json);
  }

  static MultipleItemRelatedParams? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  List<Object?> get props => [items];

  @override
  Map<String, dynamic> toJson() {
    return serialize(null);
  }
}

class StorageEngineFailureParams extends Equatable implements Serializable<Map<String,dynamic>>{
  final String storageEngineName;
  final int? storageStatusCode;
  final String? storageErrorMessage;
  StorageEngineFailureParams({required this.storageEngineName, this.storageStatusCode, this.storageErrorMessage});
  @override
  Map<String,dynamic> serialize([String? locale]){
    Map<String, dynamic> rt = {
      "storageEngineName": storageEngineName
    };
    if(storageStatusCode != null){
      rt["storageStatusCode"] = storageStatusCode as int;
    }
    if(storageErrorMessage != null){
      rt["storageErrorMessage"] = storageErrorMessage as String;
    }
    return rt;
  }
  factory StorageEngineFailureParams.fromMap(Map<String,dynamic> map){
    late final String storageEngineName;
    int? storageStatusCode;
    String? storageErrorMessage;
    if(map['storageEngineName'] != null && map['storageEngineName'] is String){
      storageEngineName = map['storageEngineName'];
    }else{
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
    if(map['storageStatusCode'] != null && map['storageStatusCode'] is int){
      storageStatusCode = map['storageStatusCode'];
    }
    if(map['storageErrorMessage'] != null && map['storageErrorMessage'] is String){
      storageErrorMessage = map['storageErrorMessage'];
    }
    return StorageEngineFailureParams(storageEngineName: storageEngineName, storageStatusCode: storageStatusCode, storageErrorMessage: storageErrorMessage);
  }
  static StorageEngineFailureParams fromJson(Map<String,dynamic> json){
    return StorageEngineFailureParams.fromMap(json);
  }
  static StorageEngineFailureParams? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
  @override
  List<Object?> get props => [storageEngineName, storageStatusCode, storageErrorMessage];

  @override
  Map<String, dynamic> toJson() {
    return serialize(null);
  }
}