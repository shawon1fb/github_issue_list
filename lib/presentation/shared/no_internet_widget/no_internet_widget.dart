import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'no_internet_controller.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key? key,
    required this.child,
    this.connectionCallback,
  }) : super(key: key);

  final Widget child;
  final Function()? connectionCallback;

  final Color greyColor = const Color(0xFFA7A7A7);

  @override
  Widget build(BuildContext context) {
    return GetX<NoInternetController>(
      builder: (c) {
        if (c.connected.value == true) {
          Future.delayed(const Duration(milliseconds: 40))
              .then((value) => connectionCallback?.call());
          return child;
        } else {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Can’t connect with Mail',
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(21),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: greyColor,
                          width: 3,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Try again',
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Maybe it helps to turn your wifi off and on again. Or restart the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
