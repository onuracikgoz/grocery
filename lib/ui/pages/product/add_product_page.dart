import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/firebase/firebase_service.dart';
import 'package:sigma_assigment/app/store/grocer_store.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/enum/grocer_enum.dart';
import 'package:sigma_assigment/core/services/lazy_image.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/snack_bar_service.dart';
import 'package:sigma_assigment/ui/widgets/custom_appbar.dart';
import 'package:sigma_assigment/ui/widgets/custom_flat_button.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';
import 'package:sigma_assigment/ui/widgets/custom_text_field.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GrocerStore _grocerStore = locator<GrocerStore>();
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar.getAppBar(title: 'Add Product'),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                labelText: 'Product name',
                controller: _productNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextFormField(
                labelText: 'Product price',
                controller: _productPriceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  if (double.tryParse(value.replaceAll(',', '.')) is! double) {
                    return 'Please enter valid price';
                  }

                  return null;
                },
              ),

              SizedBox(
                height: 10.h,
              ),
              Observer(builder: (_) {
                if (_grocerStore.state == GrocerState.pending) {
                  return CircularProgressIndicator();
                }
                if (_grocerStore.imageUrl != null) {
                  return GestureDetector(
                    onTap: () {
                      _grocerStore.addImage();
                    },
                    child: LazyImage(
                        url: _grocerStore.imageUrl,
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover),
                  );
                } else {
                  return SizedBox(
                    child: GestureDetector(
                        onTap: () {
                          _grocerStore.addImage();
                        },
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 100.w,
                        )),
                  );
                }
              }),

              //LazyImage(width: 250, height: 250, fit: BoxFit.contain),
              SizedBox(
                height: 15.h,
              ),
              Observer(builder: (_) {
                return CustomFlatButton(
                  text: 'Add product',
                  onPressed: () async {
                    if (_grocerStore.imageUrl != null) {
                      if (_formKey.currentState!.validate()) {
                        Product product = Product(
                          docId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          state: 0,
                          productName: _productNameController.text,
                          productImage: _grocerStore.imageUrl!,
                          productOwnerId: _firebaseService.firebaseUser.uid,
                          price: double.tryParse(_productPriceController.text
                              .replaceAll(',', '.'))!,
                          salesState: false,
                        );

                        await _grocerStore.addProduct(product: product);
                      }
                    } else {
                      Snack.showSnackBar(message: 'Please add a picture');
                    }
                  },
                  isLoading: _grocerStore.state == GrocerState.pending,
                  color: AppConfig.secondaryColor,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
