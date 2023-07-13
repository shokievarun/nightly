import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/login_controller.dart';
import 'package:nightly/views/common_widgets/custom_search_field.dart';
import 'package:nightly/utils/constants/app_assets.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/country_codes.dart';
import 'package:nightly/utils/constants/dimensions.dart';

showCountryCodePicker(BuildContext context) {
  final _loginController = Get.find<LoginController>();
  return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            insetPadding: const EdgeInsets.only(left: 20, right: 20),
            child: Builder(builder: (context) {
              return SizedBox(
                //margin: EdgeInsets.all(8),
                height: Dimensions.height641,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width16,
                          right: Dimensions.width16,
                          top: Dimensions.height20),
                      child: titleWidget(() {
                        Get.back();
                        _loginController.countryCodeSearchController.clear();
                        _loginController.countryCodes =
                            CountryCodes.countryCodes['countries']!;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width16,
                        right: Dimensions.width16,
                      ),
                      child: CustomSearchField(
                          controller:
                              _loginController.countryCodeSearchController,
                          isPrefix: true,
                          hint: 'Search country',
                          onChanged: (value) {
                            _loginController.searchCountryCodes(value);
                          }),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const CountryList()
                  ],
                ),
              );
            }));
      });
}

Widget titleWidget(Function()? onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Select Your Country Code",
        style: AppTextStyles.kRoboto50016Black,
      ),
      InkWell(
        onTap: onTap,
        child: SizedBox(
            height: Dimensions.height16,
            width: Dimensions.width16,
            child: Image.asset(AppAssetUrls.kclose)),
      )
    ],
  );
}

class CountryList extends StatelessWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (countryCode) {
      return Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        height: Dimensions.screenHeight / 1.70,
        child: Scrollbar(
          radius: const Radius.circular(47),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemCount: countryCode.countryCodes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    countryCode.selectedCode.value =
                        countryCode.countryCodes[index]['code']!;
                    Get.back();
                    countryCode.countryCodeSearchController.clear();
                    countryCode.countryCodes =
                        CountryCodes.countryCodes['countries']!;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 16,
                          width: 20,
                          child: CachedNetworkImage(
                              width: 20,
                              height: 16,
                              imageUrl:
                                  "https://countryflagsapi.com/png/${countryCode.countryCodes[index]['name']!}",
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              colorBlendMode: BlendMode.dstATop,
                              errorWidget: (context, url, error) {
                                return const SizedBox(
                                  height: 20,
                                  width: 16,
                                );
                              }),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Text(countryCode.countryCodes[index]['code']!),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Flexible(
                            child: Text(
                          countryCode.countryCodes[index]['name']!,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
