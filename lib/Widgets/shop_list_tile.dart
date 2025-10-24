import 'package:voyzo_vendor/Home%20&%20Shops/Model/shop_response.dart';
import 'package:voyzo_vendor/Home%20&%20Shops/create_shop_screen.dart';
import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ShopListTile extends StatelessWidget {
  final ShopData data;

  const ShopListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateShopScreen(
                  isEdit: true,
                  id: data.id!.toInt(),
                )));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data.imageUri == null
              ? ExtendedImage.asset(
                  "assets/app/no_image.png",
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  height: 80,
                  width: 80,
                  borderRadius: AppBorderRadius.k08,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return const SizedBox(
                          height: 0,
                          width: 0,
                        );
                      case LoadState.completed:
                        return ExtendedImage.asset(
                          "assets/app/no_image.png",
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.cover,
                          shape: BoxShape.rectangle,
                          borderRadius: AppBorderRadius.k08,
                        );
                      case LoadState.failed:
                        return Image.asset("assets/app/profile.png");
                    }
                  },
                )
              : ExtendedImage.network(
                  data.imageUri!,
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  height: 80,
                  width: 80,
                  borderRadius: AppBorderRadius.k08,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return const SizedBox(
                          height: 0,
                          width: 0,
                        );
                      case LoadState.completed:
                        return ExtendedImage.network(
                          data.imageUri!,
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.cover,
                          shape: BoxShape.rectangle,
                          borderRadius: AppBorderRadius.k08,
                        );
                      case LoadState.failed:
                        return Image.asset("assets/app/profile.png");
                    }
                  },
                ),
          const WidthBox(12),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${data.name}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyText,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 3,
                      bottom: 3,
                      right: 8,
                      left: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: data.status == 1
                            ? const Color(0xFF95DE64)
                            : const Color(0xFFFF7875),
                      ),
                      color: data.status == 1
                          ? const Color(0xFFF6FFED)
                          : const Color(0xFFFFF1F0),
                      borderRadius: AppBorderRadius.k04,
                    ),
                    child: Text(
                      data.status == 1
                          ? getTranslated(context, LangConst.active).toString()
                          : getTranslated(context, LangConst.deActivate)
                              .toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: data.status == 1
                                ? const Color(0xFF389E0D)
                                : const Color(0xFFCF1322),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  )
                ],
              ),
              Text(
                "${data.address}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.subText, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.warningMedium,
                    size: 20,
                  ),
                  const WidthBox(4),
                  Text(
                    "${data.avgRating}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.subText, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
