import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/user_store.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/services/lazy_image.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/ui/widgets/custom_appbar.dart';
import 'package:sigma_assigment/ui/widgets/custom_flat_button.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';
import 'package:sigma_assigment/ui/widgets/no_data_screen.dart';

class BasketPage extends StatelessWidget {
  BasketPage({Key? key}) : super(key: key);

  final UserStore _userStore = locator<UserStore>();

  @override
  Widget build(BuildContext context) {
    _userStore.getAllPrice();
    return Scaffold(
      appBar: BasicAppBar.getAppBar(title: 'Basket'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Observer(builder: (_) {
              if (_userStore.basketList.isEmpty) {
                return NoData(text: 'Add a product to your basket.');
              }
              return Expanded(
                child: ListView.separated(
                    itemCount: _userStore.basketList.length,
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Divider(
                            color: AppConfig.secondaryColor,
                          ),
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      return _ProductItem(
                        product: _userStore.basketList[index],
                      );
                    }),
              );
            }),
            if (_userStore.basketList.isNotEmpty)
              Observer(builder: (_) {
                return CustomFlatButton(
                  text: 'Buy Products ' + _userStore.priceString!,
                  onPressed: () async {
                    await _userStore.buyProduct();
                    //locator<NavigationService>().navigateTo('/addProduct');
                  },
                  color: AppConfig.secondaryColor,
                );
              })
          ],
        ),
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  _ProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;
  final UserStore _userStore = locator<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LazyImage(
            url: product.productImage,
            width: 100.w,
            height: 100.w,
            fit: BoxFit.cover),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContentText(
              text: product.productName,
            ),
            CustomContentText(
              text: 'Price(₺): ${product.price.toString()}',
            ),
            if (_userStore.curreny != null)
              CustomContentText(
                text: 'Price(\$): ${_userStore.convertPrice(product.price)}',
              ),
            CustomFlatButton(
              width: 200.w,
              text: 'Remove from Basket',
              onPressed: () async {
                await _userStore.removeFromBasket(product);
              },
              color: AppConfig.secondaryColor,
              isBoldText: false,
            )
          ],
        ),
      ],
    );
  }
}
