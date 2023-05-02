import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import 'cache_image_view_controller.dart';

class CacheImageView extends StatelessWidget {
  CacheImageView({
    Key? key,
    required this.child,
    this.errorChild,
    this.placeHolderChild,
    required this.image,
    this.borderRadius,
    this.border,
    this.fadeInDuration = 30,
    this.fadeOutDuration = 30,
    this.placeholderFadeInDuration = 30,
    this.backGroundColor = const Color(0xff315362), // const Color(0xffE72360),
    this.boxShape = BoxShape.rectangle,
    this.fit = BoxFit.cover,
    List<int> errorStatusCodes = const <int>[403],
  }) : super(key: key) {
    for (int i in errorStatusCodes) {
      errorStatusCodesMap.addAll({
        i: false,
      });
    }
  }

  final int fadeInDuration;
  final int fadeOutDuration;
  final int placeholderFadeInDuration;
  final Widget child;
  final Widget? errorChild;
  final Widget? placeHolderChild;
  final String image;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color backGroundColor;
  final BoxShape boxShape;
  final BoxFit fit;

  final RxMap<int, bool> errorStatusCodesMap = <int, bool>{}.obs;

  bool isURL() {
    try {
      Uri u = Uri.parse(image);
      return u.host.isEmpty == false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CacheImageViewController>(
      builder: (c) {
        if ((isURL() == false) || c.errorImageUrlMap[image] == false) {
          return errorChild ??
              placeHolderChild ??
              Container(
                decoration: BoxDecoration(
                  //  color: const Color(0xffE72360),
                  color: backGroundColor,
                  borderRadius: borderRadius,
                  border: border,
                  shape: boxShape,
                ),
                child: child,
              );
        }

        return CachedNetworkImage(
          imageUrl: image,
          cacheManager: DefaultCacheManager(),
          cacheKey: image,
          fadeOutCurve: Curves.decelerate,
          fadeOutDuration: Duration(milliseconds: fadeOutDuration),
          fadeInDuration: Duration(milliseconds: fadeInDuration),
          placeholderFadeInDuration:
              Duration(milliseconds: placeholderFadeInDuration),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: border,
              shape: boxShape,
              image: DecorationImage(
                image: imageProvider,
                fit: fit,

                //  colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
              ),
            ),
            child: child,
          ),
          placeholder: (context, url) =>
              placeHolderChild ??
              Container(
                decoration: BoxDecoration(
                  // color: const Color(0xff000000),
                  borderRadius: borderRadius,
                  color: Colors.white,
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff4B1D29),
                  //     Color(0xff111a21),
                  //   ],
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  // ),
                  border: border,
                  shape: boxShape,
                ),
                child: child,
              ),
          errorWidget: (context, url, error) {
            debugPrint('errorWidget  url=> : $url ');
            debugPrint('errorWidget  error=> : $error ');
            debugPrint('errorWidget  error=> : ${error.runtimeType} ');
            if (error is HttpExceptionWithStatus) {
              if (errorStatusCodesMap[error.statusCode] == false) {
                c.addErrorImageUrl(url);
              }
            }

            return errorChild ??
                Container(
                  decoration: BoxDecoration(
                    // color: const Color(0xffE72360),
                    color: backGroundColor,
                    borderRadius: borderRadius,
                    border: border,
                    shape: boxShape,
                  ),
                  child: child,
                );
          },
        );
      },
    );
  }
}
