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

import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Test Serialization of SystemExceptions', () {

    setUp(() {
      // Additional setup goes here.
    });

    test('UnknownInnerError', () {
      UnknownInnerError e = UnknownInnerError(([locale]) => "So that's something, huh?");
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('InnerParseException', () {
      InnerParseException e = InnerParseException(([locale]) => "So that's something, huh?");
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);expect(deserialized, e);
    });
    test('StorageEngineFailure', () {
      StorageEngineFailure e = StorageEngineFailure(([locale]) => "So that's something, huh?",StorageEngineFailureParams(storageEngineName: "MySQL",storageErrorMessage: "Msg"));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('OuterServiceCredentialMismatch', () {
      OuterServiceCredentialMismatchException e = OuterServiceCredentialMismatchException(([locale]) => "So that's something, huh?",SingleItemRelatedParams(item: '123'));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('OuterServiceFailure', () {
      OuterServiceFailedException e = OuterServiceFailedException(([locale]) => "So that's something, huh?",SingleItemRelatedParams(item: "123"));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('RequestFormatException', () {
      RequestFormatException e = RequestFormatException(([locale]) => "So that's something, huh?",MultipleItemRelatedParams(items:["123","456"]));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('ItemNotFound', () {
      ItemNotFoundException e = ItemNotFoundException(([locale]) => "So that's something, huh?",SingleItemRelatedParams(item: "123"));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('ItemAlreadyExists', () {
      ItemAlreadyExistException e = ItemAlreadyExistException(([locale]) => "So that's something, huh?",SingleItemRelatedParams(item: "123"));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('ItemExpired', () {
      ItemExpiredException e = ItemExpiredException(([locale]) => "So that's something, huh?",SingleItemRelatedParams(item: "123"));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('ItemUsed', () {
      ItemUsedException e = ItemUsedException(([locale]) => "So that's something, huh?",SingleItemRelatedParams(item: "123"));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('CredentialMismatch', () {
      CredentialMismatchException e = CredentialMismatchException(([locale]) => "So that's something, huh?",MultipleItemRelatedParams(items:["123","456"]));
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('PermissionDenied', () {
      PermissionDeniedException e = PermissionDeniedException(([locale]) => "So that's something, huh?");
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('TooManyRequests', () {
      TooManyRequestsException e = TooManyRequestsException(([locale]) => "So that's something, huh?");
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
    test('SystemBusyException', () {
      SystemBusyException e = SystemBusyException(([locale]) => "So that's something, huh?");
      Map<String,dynamic> serialized = e.serialize();
      InteractivePlusSystemException<dynamic> deserialized = InteractivePlusSystemException.fromMap(serialized);
      expect(deserialized, e);
    });
  });
}
