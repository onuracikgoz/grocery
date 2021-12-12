import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigma_assigment/app/models/product.dart';

import 'package:sigma_assigment/app/store/login_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sigma_assigment/core/services/snack_bar_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _firebaseService = FirebaseService._internal();

  factory FirebaseService() {
    return _firebaseService;
  }
  FirebaseService._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  late User firebaseUser;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  CollectionReference grocers = FirebaseFirestore.instance.collection('Grocer');

  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');

  Future<UserCredential?> signUpService(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        firebaseUser = userCredential.user!;

        await firebaseUser.updateDisplayName(firebaseUser.email!.split('@')[0]);

        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Snack.showSnackBar(message: e.message!);
      } else if (e.code == 'email-already-in-use') {
        Snack.showSnackBar(message: e.message!);
      } else if (e.code == 'invalid-email') {
        Snack.showSnackBar(message: e.message!);
      }
    } catch (e) {
      Snack.showSnackBar(message: 'Error');
      rethrow;
    }
  }

  Future<UserCredential?> signInService(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Snack.showSnackBar(message: e.message!);
      } else if (e.code == 'wrong-password') {
        Snack.showSnackBar(message: e.message!);
      } else if (e.code == 'invalid-email') {
        Snack.showSnackBar(message: e.message!);
      }
    }
  }

  Future<void> addUser(User user) async {
    DocumentReference documentReferencer = users.doc(user.uid);

    await documentReferencer.set({
      'userName': user.displayName,
      'basketItems':[]
    });
  }

  Future<void> addGrocer(User user) async {
    DocumentReference documentReferencer = grocers.doc(user.uid);

    await documentReferencer.set({
      'userName': user.displayName,
    });
  }

  Future<void> addItemProduct({required String productId}) async {
    firebaseUser = auth.currentUser!;

    DocumentReference documentReferanceUser = grocers.doc(firebaseUser.uid);

    products.add({});
  }

  Future<void> addItemBasket({required String productId}) async {
    firebaseUser = auth.currentUser!;

    DocumentReference documentReferanceUser = users.doc(firebaseUser.uid);

    DocumentReference documentReference = products.doc(productId);

    var list = [documentReference];

    await documentReferanceUser
        .update({"basketItems": FieldValue.arrayUnion(list)});
  }

  Future<void> signOutService() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<dynamic> getGrocersProducts() async {
    var grocerProducts = await products
        .where('productOwnerId', isEqualTo: firebaseUser.uid)
        .get();

    List<QueryDocumentSnapshot> docs = grocerProducts.docs;

    List<Product> product = [];

    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;

        product.add(Product.fromJson(data));
      }
    }

    return product;
  }

  Future<dynamic> getAllProduct() async {
    try {
      var allProducts =
          await products.where('salesState', isEqualTo: false).get();
      List<QueryDocumentSnapshot> docs = allProducts.docs;

      List<Product> product = [];

      for (var doc in docs) {
        if (doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;

          product.add(Product.fromJson(data));
        }
      }

      return product;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addGrocersProduct({required Product product}) async {
    try {
      DocumentReference rf = products.doc(product.docId);

      rf.set(product.toJson());

      var list = [rf];

      grocers
          .doc(product.productOwnerId)
          .update({'items': FieldValue.arrayUnion(list)});
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addBasket(Product product) async {
    try {
      var list = [product.docId];

      users.doc(firebaseUser.uid).update({
        'basketItems': FieldValue.arrayUnion(list),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getBasketItems() async {
    List<Product> basketItems = [];
    DocumentReference rf = users.doc(firebaseUser.uid);

    DocumentSnapshot q = await rf.get();
    var data = q.data() as Map<String, dynamic>;

    if(data != null && data['basketItems'].isNotEmpty){

    (data['basketItems'] as List<dynamic>).forEach((element) async {
      DocumentReference productRf = products.doc(element);
      DocumentSnapshot productQs = await productRf.get();
      var dataPr = productQs.data() as Map<String, dynamic>;

      basketItems.add(Product.fromJson(dataPr));
    });   }



    await Future.delayed(Duration(milliseconds: 1000));

    return basketItems;
  }

  Future<dynamic> removeFromBasket(Product product) async {
    try {
      DocumentReference rf = users.doc(firebaseUser.uid);

      rf.update({
        'basketItems': FieldValue.arrayRemove([product.docId])
      });
    } catch (e) {
      Snack.showSnackBar(message: 'Error');
    }
  }

  Future<dynamic> buyProducts(List<Product> basketList) async {
    List<Product> allProducts = [];

    basketList.forEach((element) {
      DocumentReference rf = products.doc(element.docId);

      rf.update({'state': 1, 'salesState': true});
    });
  }

  Future<dynamic> changeOrderStatus(int status, String productId) async {
    DocumentReference rf = products.doc(productId);

    rf.update({'state': status});
  }
}
