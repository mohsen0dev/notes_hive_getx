import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_hive_getx/screen/abute/widget/animated_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          // backgroundColor: listColor[5].backColor,
          body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 250),
                  //! عنوان
                  const Text(
                    'یادداشت ها',
                    style: TextStyle(
                        // color: ConstColor.logoColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Container(
                      padding: const EdgeInsets.all(16),
                      // height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          color:
                              Colors.deepPurpleAccent.shade100.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Column(
                        children: [
                          SizedBox(height: 8),
                          TextCustom(title: 'محسن فرجی'),
                          SizedBox(height: 12),
                          TextCustom(title: '@m0h3nFrji'),
                          SizedBox(height: 12),

                          TextCustom(title: 'mohsen.faraji.dev@gmail.com'),
                          SizedBox(height: 8),
                          //! دکمه ثبت نام
                        ],
                      )),
                  const SizedBox(height: 12),
                  Container(
                      padding: const EdgeInsets.all(16),
                      // height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          color:
                              Colors.deepPurpleAccent.shade100.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          InkWell(
                              onTap: () async {
                                final mayket = Uri.parse(
                                    'myket://developer/com.mehmani.software.faraji.mohsen');
                                // final bazar = Uri.parse(
                                //     ' https://cafebazaar.ir/app/com.gmail.farajiMohsen.service_car');
                                if (await canLaunchUrl(mayket)) {
                                  await launchUrl(mayket,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  Get.snackbar(
                                    borderWidth: 1,
                                    borderColor: Colors.red,
                                    icon: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                    '',
                                    '',
                                    titleText: const Text('خطا',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center),
                                    messageText: const Text('مایکت نصب نیست',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right),
                                  );
                                }
                              },
                              child: const TextCustom(
                                  size: 16,
                                  color: Colors.indigo,
                                  title: 'مشاهده برنامه های دیگر من')),

                          // const SizedBox(height: 12),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                            height: 30,
                          ),

                          InkWell(
                            onTap: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => AnimatedAlertDialog(
                                    title: 'امتیاز به برنامه',
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 8,
                                            // backgroundColor:
                                            //     ConstColor.btnColor,
                                            foregroundColor: Colors.white),
                                        onPressed: () async {
                                          final mayket = Uri.parse(
                                              'https://myket.ir/app/com.gmail.farajiMohsen.service_car');
                                          // final bazar = Uri.parse(
                                          //     ' https://cafebazaar.ir/app/com.gmail.farajiMohsen.service_car');
                                          if (await canLaunchUrl(mayket)) {
                                            await launchUrl(mayket,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          } else {
                                            Get.snackbar(
                                              borderWidth: 1,
                                              borderColor: Colors.red,
                                              icon: const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 35,
                                              ),
                                              '',
                                              '',
                                              titleText: const Text('خطا',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                  textAlign: TextAlign.center),
                                              messageText: const Text(
                                                  'مایکت نصب نیست',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.right),
                                            );
                                          }
                                        },
                                        child: const Text('ثبت نظر'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // backgroundColor: ConstColor.bg2Color,
                                          elevation: 8,
                                        ),
                                        onPressed: () {
                                          // controllerUp.dispose();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('انصراف'),
                                      ),
                                    ],
                                    content: const Text(
                                        'با انتخاب گزینه تایید به برنامه مایکت منتقل میشوید')),
                              );
                            },
                            child: const TextCustom(
                                title: 'امتیاز به برنامه',
                                size: 16,
                                color: Colors.indigo),
                          ),
                          const SizedBox(height: 8),
                          //! دکمه ثبت نام
                        ],
                      )),
                ],
              ),
            ),
            Positioned(
                top: -300,
                child: Container(
                  width: MediaQuery.sizeOf(context).width + 80,
                  height: MediaQuery.sizeOf(context).width + 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurpleAccent.shade100.withOpacity(0.3),
                  ),
                )),
            Positioned(
                top: 110,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/empty.png',
                  height: 120,
                )

                //  Assets.images.logo.image(height: 120),
                ),
            Positioned(
                right: 10,
                top: 40,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                  // color: Colors.black87,
                  iconSize: 28,
                ))
          ],
        ),
      )),
    );
  }
}

class TextCustom extends StatelessWidget {
  const TextCustom(
      {super.key, required this.title, this.size = 17, this.color});
  final String title;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size, color: color),
      ),
    );
  }
}
