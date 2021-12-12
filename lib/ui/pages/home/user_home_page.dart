import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/login_store.dart';
import 'package:sigma_assigment/app/store/user_store.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';
import 'package:sigma_assigment/core/enum/user_enum.dart';
import 'package:sigma_assigment/core/services/lazy_image.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';
import 'package:sigma_assigment/ui/widgets/custom_appbar.dart';
import 'package:sigma_assigment/ui/widgets/custom_flat_button.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';
import 'package:sigma_assigment/ui/widgets/no_data_screen.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final LoginStore _loginStore = locator<LoginStore>();

  final UserStore _userStore = locator<UserStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();
  }

  _init() async {
    await _userStore.getAllProduct();
    await _userStore.getMyItems();
    await _userStore.getLatestCurreny();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar.getAppBar(
            title: 'Home',
            automaticallyImplyLeading: false,
            centerTitle: true,
            actionButton: [_MyOrderButton(), _BasketWidget(), _ExitButton()]),
        body: _body());
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        
        children: [
          Observer(builder: (_) {


            if(_userStore.productList.isEmpty){

              return NoData(text: 'No products found at this time.');
            }
            return Expanded(
              child: ListView.separated(
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
                  itemCount: _userStore.productList.length,
                  itemBuilder: (context, index) =>
                      _ProductItem(product: _userStore.productList[index])),
            );
          }),
        ],
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  _ExitButton({
    Key? key,
  }) : super(key: key);

  final LoginStore _loginStore = locator<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: const Icon(
          Icons.exit_to_app_rounded,
          color: AppConfig.secondaryColor,
          size: 30,
        ),
        onTap: () {
          _loginStore.signOut();
        },
      ),
    );
  }
}

class _MyOrderButton extends StatelessWidget {
  _MyOrderButton({
    Key? key,
  }) : super(key: key);

  final LoginStore _loginStore = locator<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: const Icon(
          Icons.history_edu,
          color: AppConfig.secondaryColor,
          size: 30,
        ),
        onTap: () {
          locator<NavigationService>().navigateTo('/purchaseHistory');
        },
      ),
    );
  }
}

class _BasketWidget extends StatelessWidget {
  _BasketWidget({
    Key? key,
  }) : super(key: key);

  final UserStore _userStore = locator<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            locator<NavigationService>().navigateTo('/basket');
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
              color: AppConfig.secondaryColor,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 5.w,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Observer(builder: (_) {
                if (_userStore.userState == UserState.pending) {
                  return SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator());
                }
                return CustomContentText(
                  text: _userStore.basketList.length.toString(),
                  textSize: CustomTextSize.bodyText1,
                  color: AppConfig.primaryColor,
                );
              }),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppConfig.secondaryColor),
          ),
        )
      ],
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
            height: 120.w,
            width: 120.w,
            fit: BoxFit.cover),
        SizedBox(
          width: 10.w,
        ),
        Observer(builder: (_) {
          return Column(
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
              SizedBox(
                height: 10.h,
              ),
              CustomFlatButton(
                width: 200.w,
                text: 'Add to Basket',
                onPressed: () async {
                  await _userStore.addBasket(product);
                  await _userStore.getMyItems();
                },
                color: AppConfig.secondaryColor,
                isBoldText: false,
              )
            ],
          );
        }),
      ],
    );
  }
}
