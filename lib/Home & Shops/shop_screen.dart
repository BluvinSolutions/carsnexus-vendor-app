import 'package:carsnexus_owner/Home%20&%20Shops/Model/shop_response.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/Provider/shop_provider.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/create_shop_screen.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Widgets/app_bar_back_icon.dart';
import 'package:carsnexus_owner/Widgets/constant_widget.dart';
import 'package:carsnexus_owner/Widgets/shop_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late ShopProvider shopProvider;

  @override
  void initState() {
    super.initState();
    shopProvider = Provider.of<ShopProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      shopProvider.callGetShop();
    });
  }

  @override
  Widget build(BuildContext context) {
    shopProvider = Provider.of<ShopProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: shopProvider.shopLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: const AppBarBack(),
          title: Text(getTranslated(context, LangConst.shops).toString()),
        ),
        body: shopProvider.shops.isEmpty && shopProvider.shopLoader == false
            ? Center(
                child: Text(
                    getTranslated(context, LangConst.noDateFound).toString()),
              )
            : ListView.separated(
                itemCount: shopProvider.shops.length,
                padding: const EdgeInsets.all(Amount.screenMargin),
                separatorBuilder: (context, index) => const HeightBox(15),
                itemBuilder: (context, index) {
                  ShopData data = shopProvider.shops[index];
                  return ShopListTile(
                    data: data,
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateShopScreen(isEdit: false),
              ),
            );
          },
          shape:
              const RoundedRectangleBorder(borderRadius: AppBorderRadius.k16),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
