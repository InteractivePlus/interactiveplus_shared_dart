import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';

class SearchResult<Type> implements Serializable<Map<String,dynamic>>{
  final int numFetched;
  final int numTotalAccordingToSearchParam;
  final Iterable<Type> collection;
  SearchResult(this.numFetched,this.numTotalAccordingToSearchParam,this.collection);
  factory SearchResult.fromMap(Map<String,dynamic> map, Type Function(Map<String,dynamic>) typeDeserializeConstructor){
    if(map['numFetched'] != null && map['numFetched'] is int
       && map['numTotalSearched'] != null && map['numTotalSearched'] is int
       && map['collection'] != null && (map['collection'] is List<Map<String,dynamic>> || map['collection'] is List<Type>)
    ){
      if(map['collection'] is List<Map<String,dynamic>>){
        List<Type> t = List.empty(growable: true);
        for(var i in (map['collection'] as List<Map<String,dynamic>>)){
          t.add(typeDeserializeConstructor(i));
        }
        return SearchResult(map['numFetched'], map['numTotalSearched'], t);
      }else{
        return SearchResult(map['numFetched'], map['numTotalSearched'], map['collection']);
      }
    }else{
      throw InteractivePlusSystemException.SERIALIZATION_EXCEPTION;
    }
  }

  static SearchResult<Type> fromJson<Type>(Map<String,dynamic> json, Type Function(Map<String,dynamic>) typeDeserializeConstructor){
    return SearchResult.fromMap(json, typeDeserializeConstructor);
  }

  @override
  Map<String, dynamic> serialize([String? locale]) {
    late Iterable finalAddList;
    if(collection.isNotEmpty && collection.first is Serializable){
      List<dynamic> finalList = List.empty(growable: true);
      for(var i in collection){
        finalList.add((i as Serializable).serialize(locale));
      }
      finalAddList = finalList;
    }else{
      finalAddList = collection;
    }
    return {
      'numFetched': numFetched,
      'numTotalSearched': numTotalAccordingToSearchParam,
      'collection': finalAddList
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return serialize(null);
  }
}

abstract class PersistantStorageCreatable<TypeToStore,CreateType>{
  Future<TypeToStore> createNew(CreateType createInfo);  
}

abstract class PersistantStorageSearchable<TypeToStore, FetchParameter, SearchParameter>{
  Future<TypeToStore?> fetchFromRepo(FetchParameter fetchParam);
  Future<bool> doesExist(FetchParameter fetchParam);
  Future<int> getTotalItemAccordingToSearchParameter(SearchParameter searchParam);
  Future<SearchResult<TypeToStore>> searchItems(SearchParameter searchParam, {int offset = 0, int limit = -1});
}

abstract class PersistantStorageModifiable<TypeToStore, UpdateFetchParameter, ClearSearchParameter>{
  Future<void> update(UpdateFetchParameter fetchParameter, TypeToStore updatedType);
  Future<void> delete(UpdateFetchParameter fetchParameter);
  Future<void> clear(ClearSearchParameter searchParameter);
}

abstract class PersistantStorageInstallable{
  Future<void> install();
}

abstract class PersistantStorageUninstallable{
  Future<void> uninstall();
}