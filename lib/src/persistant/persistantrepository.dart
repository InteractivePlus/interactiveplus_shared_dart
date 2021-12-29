import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';

class SearchResult<Type> implements Serializable{
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
  @override
  Map<String, dynamic> toMap([String? locale]) {
    late Iterable finalAddList;
    if(collection.isNotEmpty && collection.first is Serializable){
      List<Map<String,dynamic>> finalList = List.empty(growable: true);
      for(var i in collection){
        finalList.add((i as Serializable).toMap(locale));
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
}

abstract class PersistantStorageCreatable<TypeToStore,CreateType>{
  TypeToStore createNew(CreateType createInfo);  
}

abstract class PersistantStorageSearchable<TypeToStore, FetchParameter, SearchParameter>{
  TypeToStore? fetchFromRepo(FetchParameter fetchParam);
  bool doesExist(FetchParameter fetchParam);
  int getTotalItemAccordingToSearchParameter(SearchParameter searchParam);
  SearchResult<TypeToStore> searchItems(SearchParameter searchParam, {int offset = 0, int limit = -1});
}

abstract class PersistantStorageModifiable<TypeToStore, UpdateFetchParameter, ClearSearchParameter>{
  void update(UpdateFetchParameter fetchParameter, TypeToStore updatedType);
  void delete(UpdateFetchParameter fetchParameter);
  void clear(ClearSearchParameter searchParameter);
}