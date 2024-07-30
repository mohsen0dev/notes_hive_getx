import 'package:flutter/material.dart';

/// ویجت نمایش اطلاعاتی یافت نشد
Widget emptyView() {
  return ListView(
    padding: const EdgeInsets.all(18),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text('اطلاعاتی یافت نشد ...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/img/empty.png',
            height: 100,
          )

          // Lottie.asset(
          //   'assets/lottie/not found.json',
          //   height: 300,
          // ),
        ],
      ),
    ],
  );
}
