import 'package:mosafer1/model/all-request-services.dart';

abstract class SearchStates{}
class InitialSearchState extends SearchStates{}
class LoadingSearchState extends SearchStates{}
class LoadedSearchState extends SearchStates{
  List<RequestServices> requestServices;
  LoadedSearchState(this.requestServices);
}
//
abstract class SearchCategoriesStates{}
class LoadingSearchCategoriesState extends SearchCategoriesStates{}
class LoadedSearchCategoriesState extends SearchCategoriesStates{
  List<SearchCategoriesModel> categories;
  LoadedSearchCategoriesState(this.categories);
}