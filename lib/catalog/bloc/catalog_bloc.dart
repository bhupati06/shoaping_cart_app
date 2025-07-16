import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_card_app/catalog/bloc/catalog_event.dart';
import 'package:shopping_card_app/catalog/bloc/catalog_state.dart';
import 'package:shopping_card_app/catalog/models/catalog.dart';
import 'package:shopping_card_app/shoapping_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ShoppingRepository shoppingRepository;

  CatalogBloc(this.shoppingRepository) : super(CatalogLoading()) {
    on<LoadCatalog>(_onLoadCatalog);
  }

  Future<void> _onLoadCatalog(
      LoadCatalog event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    try {
      final items = await shoppingRepository.loadCatalog();
      emit(CatalogLoaded(Catalog(items)));
    } catch (_) {
      emit(CatalogError());
    }
  }
}
