# InteractivePlus-Shared-Dart

Dart Package shared by potentially all Dart projects written inside InteractivePlus

## Features

Provides a Serializable interface that transforms `Objects` from and to `Map<String,dynamic>`
as well as common `Error` classes that can be thrown as well as transmitted over any IO(they are serializable).

## Getting started

```shell
pub add interactiveplus_shared_dart
```

## Usage

```dart
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
            throw InteractivePlusSystemException.SerializationException;
        }
    }

    @override
    Map<String,dynamic> toMap([String? locale]){
        return {
            "name": name,
            "job": job
        };
    }
}
```

## Additional information

Original Author is [Yunhao Cao](https://github.com/ToiletCommander), Copyright [InteractivePlus](https://www.interactiveplus.org/) &copy; 2021-2022
