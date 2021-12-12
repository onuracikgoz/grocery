import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/app/models/product.dart';
import 'package:sigma_assigment/app/store/grocer_store.dart';
import 'package:sigma_assigment/app/store/login_store.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';
import 'package:sigma_assigment/core/enum/login_state_enum.dart';
import 'package:sigma_assigment/core/services/lazy_image.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';
import 'package:sigma_assigment/ui/pages/product/grocer_information_page.dart';
import 'package:sigma_assigment/ui/widgets/custom_flat_button.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';
import 'package:sigma_assigment/ui/widgets/no_data_screen.dart';

class GrocerHomePage extends StatefulWidget {
  GrocerHomePage({Key? key}) : super(key: key);

  @override
  State<GrocerHomePage> createState() => _GrocerHomePageState();
}

class _GrocerHomePageState extends State<GrocerHomePage> {
  final LoginStore _loginStore = locator<LoginStore>();
  final GrocerStore _grocerStore = locator<GrocerStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _grocerStore.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppConfig.primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorColor: AppConfig.secondaryColor,
            tabs: [
              Tab(
                child: CustomContentText(
                    text: 'My Products', color: AppConfig.secondaryColor),
              ),
              Tab(
                child: CustomContentText(
                    text: 'My Notifications', color: AppConfig.secondaryColor),
              )
            ],
          ),
          title: const CustomContentText(
            text: 'Grocer',
            color: AppConfig.secondaryColor,
            textSize: CustomTextSize.headline1,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Icon(
                  Icons.exit_to_app_rounded,
                  color: AppConfig.secondaryColor,
                  size: 30,
                ),
                onTap: () {
                  _loginStore.signOut();
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: TabBarView(
            children: [_MyProducts(), GrocerInformationPage()],
          ),
        ),
      ),
    );
  }
}

class _MyProducts extends StatelessWidget {
  _MyProducts({Key? key}) : super(key: key);

  final GrocerStore _grocerStore = locator<GrocerStore>();
  final LoginStore _loginStore = locator<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          if (_grocerStore.productList.isEmpty) {
            return NoData(text: 'Add products');
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
                itemCount: _grocerStore.productList.length,
                itemBuilder: (context, index) =>
                    _MyProductItem(product: _grocerStore.productList[index])),
          );
        }),
        CustomFlatButton(
          text: 'Add product',
          onPressed: () {
            locator<NavigationService>().navigateTo('/addProduct');
          },
          color: AppConfig.secondaryColor,
        )
      ],
    );
  }
}

class _MyProductItem extends StatelessWidget {
  const _MyProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;

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
              text: 'price: ${product.price.toString()}',
            ),
            CustomContentText(
              text:
                  'sales state: ${product.salesState == true ? 'sold' : 'active'} ',
            )
          ],
        ),
      ],
    );
  }
}
