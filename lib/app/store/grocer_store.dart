import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/firebase/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;

import 'package:sigma_assigment/core/enum/grocer_enum.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';
import 'package:sigma_assigment/core/services/snack_bar_service.dart';

part 'grocer_store.g.dart';

class GrocerStore = GrocerStoreBase with _$GrocerStore;

abstract class GrocerStoreBase with Store {
  FirebaseService _firebaseService = FirebaseService();

  @observable
  GrocerState state = GrocerState.done;
  @observable
  List<Product> productList = [];

  @observable
  List<Product> informationList = [];

  @observable
  String? imageUrl;

  final ImagePicker _picker = ImagePicker();

  @action
  addProduct({required Product product}) async {
    try {
      await _firebaseService.addGrocersProduct(product: product);

      locator<NavigationService>().pop();

      await getProducts();

      imageUrl = null;
    } catch (e) {
      Snack.showSnackBar(message: 'Error, please try again');
    }
  }

  @action
  getProducts() async {
    List<Product> list = await _firebaseService.getGrocersProducts();
    productList = list;
    informationList =
        list.where((element) => element.salesState == true).toList();
  }

  @action
  addImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        state = GrocerState.pending;
        Reference ref = _firebaseService.storage
            .ref()
            .child('products')
            .child('/${DateTime.now().millisecond}');

        UploadTask uploadTask = ref.putFile(io.File(pickedFile.path));

        await Future.value(uploadTask);

        imageUrl = await ref.getDownloadURL();

        state = GrocerState.done;

        // Waits till the file is uploaded then stores the download url

      }
    } catch (e) {
      state = GrocerState.done;
    }
  }

  changeOrderStatus(int status, String productId) async {
    try {
      await _firebaseService.changeOrderStatus(status, productId);

      await getProducts();
    } catch (e) {
      Snack.showSnackBar(message: 'Error');
    }
  }
}
