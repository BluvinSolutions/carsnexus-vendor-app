import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Package/Model/packages_response.dart';
import 'package:voyzo_vendor/Package/Provider/package_provider.dart';
import 'package:voyzo_vendor/Package/create_package_screen.dart';
import 'package:voyzo_vendor/Services/Provider/service_provider.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  late PackageProvider packageProvider;
  late ServiceProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    packageProvider = Provider.of<PackageProvider>(context, listen: false);
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      packageProvider.callgetPackages();
      serviceProvider.callgetServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    packageProvider = Provider.of<PackageProvider>(context);
    serviceProvider = Provider.of<ServiceProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: serviceProvider.serviceLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: const AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.package).toString(),
          ),
        ),
        body: packageProvider.packages.isEmpty &&
                serviceProvider.serviceLoader == false
            ? Center(
                child: Text(
                    getTranslated(context, LangConst.noDateFound).toString()),
              )
            : ListView.separated(
                itemCount: packageProvider.packages.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(Amount.screenMargin),
                separatorBuilder: (context, index) => const HeightBox(12),
                itemBuilder: (context, index) {
                  PackageData data = packageProvider.packages[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreatePackageScreen(
                              isEdit: true, id: data.id!.toInt()),
                        ),
                      );
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.k06,
                        side: BorderSide(color: AppColors.stroke)),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: 0),
                    title: Text(
                      data.name!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyText),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreatePackageScreen(isEdit: false),
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
