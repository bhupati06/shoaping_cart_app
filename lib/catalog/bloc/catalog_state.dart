import 'package:shopping_card_app/catalog/models/catalog.dart';

abstract class CatalogState{}

class CatalogLoading extends CatalogState{}

class CatalogLoaded extends CatalogState{
  CatalogLoaded(this.catalog);
  Catalog catalog;
}

class CatalogError extends CatalogState{}