// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GrocerStore on GrocerStoreBase, Store {
  final _$stateAtom = Atom(name: 'GrocerStoreBase.state');

  @override
  GrocerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(GrocerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$productListAtom = Atom(name: 'GrocerStoreBase.productList');

  @override
  List<Product> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(List<Product> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  final _$informationListAtom = Atom(name: 'GrocerStoreBase.informationList');

  @override
  List<Product> get informationList {
    _$informationListAtom.reportRead();
    return super.informationList;
  }

  @override
  set informationList(List<Product> value) {
    _$informationListAtom.reportWrite(value, super.informationList, () {
      super.informationList = value;
    });
  }

  final _$imageUrlAtom = Atom(name: 'GrocerStoreBase.imageUrl');

  @override
  String? get imageUrl {
    _$imageUrlAtom.reportRead();
    return super.imageUrl;
  }

  @override
  set imageUrl(String? value) {
    _$imageUrlAtom.reportWrite(value, super.imageUrl, () {
      super.imageUrl = value;
    });
  }

  final _$addProductAsyncAction = AsyncAction('GrocerStoreBase.addProduct');

  @override
  Future addProduct({required Product product}) {
    return _$addProductAsyncAction
        .run(() => super.addProduct(product: product));
  }

  final _$getProductsAsyncAction = AsyncAction('GrocerStoreBase.getProducts');

  @override
  Future getProducts() {
    return _$getProductsAsyncAction.run(() => super.getProducts());
  }

  final _$addImageAsyncAction = AsyncAction('GrocerStoreBase.addImage');

  @override
  Future addImage() {
    return _$addImageAsyncAction.run(() => super.addImage());
  }

  @override
  String toString() {
    return '''
state: ${state},
productList: ${productList},
informationList: ${informationList},
imageUrl: ${imageUrl}
    ''';
  }
}
