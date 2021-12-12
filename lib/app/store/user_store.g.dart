// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on UserStoreBase, Store {
  final _$productListAtom = Atom(name: 'UserStoreBase.productList');

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

  final _$basketListAtom = Atom(name: 'UserStoreBase.basketList');

  @override
  List<Product> get basketList {
    _$basketListAtom.reportRead();
    return super.basketList;
  }

  @override
  set basketList(List<Product> value) {
    _$basketListAtom.reportWrite(value, super.basketList, () {
      super.basketList = value;
    });
  }

  final _$purhaseHistoryListAtom =
      Atom(name: 'UserStoreBase.purhaseHistoryList');

  @override
  List<Product> get purhaseHistoryList {
    _$purhaseHistoryListAtom.reportRead();
    return super.purhaseHistoryList;
  }

  @override
  set purhaseHistoryList(List<Product> value) {
    _$purhaseHistoryListAtom.reportWrite(value, super.purhaseHistoryList, () {
      super.purhaseHistoryList = value;
    });
  }

  final _$currenyAtom = Atom(name: 'UserStoreBase.curreny');

  @override
  double? get curreny {
    _$currenyAtom.reportRead();
    return super.curreny;
  }

  @override
  set curreny(double? value) {
    _$currenyAtom.reportWrite(value, super.curreny, () {
      super.curreny = value;
    });
  }

  final _$priceStringAtom = Atom(name: 'UserStoreBase.priceString');

  @override
  String? get priceString {
    _$priceStringAtom.reportRead();
    return super.priceString;
  }

  @override
  set priceString(String? value) {
    _$priceStringAtom.reportWrite(value, super.priceString, () {
      super.priceString = value;
    });
  }

  final _$userStateAtom = Atom(name: 'UserStoreBase.userState');

  @override
  UserState get userState {
    _$userStateAtom.reportRead();
    return super.userState;
  }

  @override
  set userState(UserState value) {
    _$userStateAtom.reportWrite(value, super.userState, () {
      super.userState = value;
    });
  }

  final _$getAllProductAsyncAction = AsyncAction('UserStoreBase.getAllProduct');

  @override
  Future getAllProduct() {
    return _$getAllProductAsyncAction.run(() => super.getAllProduct());
  }

  final _$addBasketAsyncAction = AsyncAction('UserStoreBase.addBasket');

  @override
  Future addBasket(Product product) {
    return _$addBasketAsyncAction.run(() => super.addBasket(product));
  }

  final _$getMyItemsAsyncAction = AsyncAction('UserStoreBase.getMyItems');

  @override
  Future getMyItems() {
    return _$getMyItemsAsyncAction.run(() => super.getMyItems());
  }

  final _$removeFromBasketAsyncAction =
      AsyncAction('UserStoreBase.removeFromBasket');

  @override
  Future removeFromBasket(Product product) {
    return _$removeFromBasketAsyncAction
        .run(() => super.removeFromBasket(product));
  }

  final _$getLatestCurrenyAsyncAction =
      AsyncAction('UserStoreBase.getLatestCurreny');

  @override
  Future getLatestCurreny() {
    return _$getLatestCurrenyAsyncAction.run(() => super.getLatestCurreny());
  }

  final _$buyProductAsyncAction = AsyncAction('UserStoreBase.buyProduct');

  @override
  Future buyProduct() {
    return _$buyProductAsyncAction.run(() => super.buyProduct());
  }

  final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase');

  @override
  dynamic convertPrice(double price) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.convertPrice');
    try {
      return super.convertPrice(price);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getAllPrice() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.getAllPrice');
    try {
      return super.getAllPrice();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productList: ${productList},
basketList: ${basketList},
purhaseHistoryList: ${purhaseHistoryList},
curreny: ${curreny},
priceString: ${priceString},
userState: ${userState}
    ''';
  }
}
