import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Services/Model/services_response.dart';
import 'package:voyzo_vendor/Services/Provider/service_provider.dart';
import 'package:voyzo_vendor/Services/create_service_screen.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServiceProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      serviceProvider.callgetCategory();
      serviceProvider.callgetServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    serviceProvider = Provider.of<ServiceProvider>(context);
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
          leading: const AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.services).toString(),
          ),
        ),
        body: serviceProvider.services.isEmpty &&
                serviceProvider.serviceLoader == false
            ? Center(
                child: Text(
                    getTranslated(context, LangConst.noDateFound).toString()),
              )
            : ListView.separated(
                itemCount: serviceProvider.services.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(Amount.screenMargin),
                separatorBuilder: (context, index) => const HeightBox(12),
                itemBuilder: (context, index) {
                  ServiceData data = serviceProvider.services[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateServiceScreen(
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
                builder: (context) => const CreateServiceScreen(isEdit: false),
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
