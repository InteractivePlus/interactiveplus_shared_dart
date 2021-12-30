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

void main(){
    throw UnknownInnerError(([locale]) => "Just an example! Haha!");
}

// Example class that implements a Serializable interface.
class ABC implements Serializable{
    final String name;
    final String job;
    ABC({required this.name, required this.job});
    factory ABC.fromMap(Map<String,dynamic> map){
        if(map['name'] != null && map['name'] is String && map['job'] != null && map['job'] is String){
            return ABC(name: map['name'], job: map['job']);
        }else{
            throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
        }
    }

    ///Created to add more interpolation possibility for other libraries that requires a "static" parsing method
    static ABC fromJson(Map<String,dynamic> json){
      return ABC.fromMap(json);
    }

    @override
    Map<String,dynamic> serialize([String? locale]){
        return {
            "name": name,
            "job": job
        };
    }

  @override
  Map<String, dynamic> toJson() {
    return serialize(null);
  }
}