import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/grocer_store.dart';
import 'package:sigma_assigment/app/store/user_store.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/services/lazy_image.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/ui/widgets/custom_appbar.dart';
import 'package:sigma_assigment/ui/widgets/custom_flat_button.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';
import 'package:sigma_assigment/ui/widgets/no_data_screen.dart';

class GrocerInformationPage extends StatelessWidget {
  GrocerInformationPage({Key? key}) : super(key: key);

  final GrocerStore _grocerStore = locator<GrocerStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Observer(builder: (_) {
              if (_grocerStore.informationList.isEmpty) {
                return NoData(text: 'No orders found');
              }
              return Expanded(
                child: ListView.separated(
                    itemCount: _grocerStore.informationList.length,
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
                        product: _grocerStore.informationList[index],
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  _ProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;
  GrocerStore _grocerStore = locator<GrocerStore>();

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
            Container(
              child: CustomContentText(
                text: getInfo(product.state),
                hasUnderline: product.state < 3,
                onTap: () {
                  if (product.state < 3) {
                    _grocerStore.changeOrderStatus(
                        product.state + 1, product.docId);
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  String getInfo(int state) {
    switch (state) {
      case 1:
        return 'Confirm order';
      case 2:
        return 'Mark item as shipped';

      case 3:
        return 'Awaiting approval';

      default:
        return 'Order is completed';
    }
  }
}
