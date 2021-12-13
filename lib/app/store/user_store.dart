import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/firebase/firebase_service.dart';
import 'package:sigma_assigment/core/config/api_config.dart';
import 'package:sigma_assigment/core/enum/user_enum.dart';
import 'package:sigma_assigment/core/services/http_service.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/snack_bar_service.dart';
import 'package:sigma_assigment/ui/pages/product/purchase_history_page.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  FirebaseService _firebaseService = FirebaseService();

  @observable
  List<Product> productList = [];

  @observable
  List<Product> basketList = [];

  @observable
  List<Product> purhaseHistoryList = [];

  @observable
  double? curreny;

  @observable
  String? priceString;

  @observable
  UserState userState = UserState.done;

  @action
  getAllProduct() async {
    try {
      List<Product> tempList = await _firebaseService.getAllProduct();
      productList = tempList.where((element) => element.state == 0).toList();
    } catch (e) {
      rethrow;
    }
  }

  @action
  addBasket(Product product) async {
    try {
      await _firebaseService.addBasket(product);
    } catch (e) {}
  }

  @action
  getMyItems() async {
    userState = UserState.pending;
    List<Product> tempList = await _firebaseService.getBasketItems();

    basketList = tempList.where((element) => element.state == 0).toList();
    purhaseHistoryList =
        tempList.where((element) => element.state != 0).toList();

    userState = UserState.done;
  }

  @action
  removeFromBasket(Product product) async {
    try {
      await _firebaseService.removeFromBasket(product);

      basketList.removeWhere((element) => element.docId == product.docId);
      basketList = basketList;

      getAllPrice();

      //await getBasketItems();
    } catch (e) {}
  }

  @action
  getLatestCurreny() async {
    try {
      Response response =
          await locator<HttpService>().httpGet(url: 'latest', data: {
        'access_key': Api.convertApiKey,
      });

      if (response.data['success'] == true) {
        Map<String, dynamic> rates = response.data['rates'];

        double usdCurrency = rates['USD'];
        double tryCurreny = rates['TRY'];

        curreny = tryCurreny / usdCurrency;
      }
    } catch (e) {
      rethrow;
    }
  }

  @action
  convertPrice(double price) {
    String usd = (price / curreny!).toStringAsFixed(2);
    return usd;
  }

  @action
  buyProduct() async {
    try {
      await _firebaseService.buyProducts(basketList);

      await getMyItems();
      basketList.clear();
      await getAllProduct();
      Snack.showSnackBar(
          message:
              'The payment is complete. Please check your order history page');
    } catch (e) {
      Snack.showSnackBar(message: 'Error');
    }
  }

  @action
  getAllPrice() {
    double price = 0;

    basketList.forEach((element) {
      price = price + element.price;
    });

    priceString = price.toStringAsFixed(2) + '₺';
  }

  changeOrderStatus(int status, String productId) async {
    try {
      await _firebaseService.changeOrderStatus(status, productId);

      await getMyItems();
    } catch (e) {
      Snack.showSnackBar(message: 'Error');
    }
  }
}
