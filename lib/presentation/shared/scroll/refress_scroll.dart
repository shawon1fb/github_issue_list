import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshScroll extends StatefulWidget {
  const RefreshScroll({
    Key? key,
    required this.child,
    required this.scrollController,
    this.onLoading,
    this.onRefresh,
    this.enablePullUp = false,
    this.header,
    this.scrollDirection,
  }) : super(key: key);

  final Widget child;
  final ScrollController scrollController;
  final Function()? onLoading;
  final Function()? onRefresh;
  final bool enablePullUp; // false,
  final Widget? header;
  final Axis? scrollDirection;

  @override
  _RefreshScrollState createState() => _RefreshScrollState();
}

class _RefreshScrollState extends State<RefreshScroll> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      scrollController: widget.scrollController,
      scrollDirection: widget.scrollDirection,
      onRefresh: () async {
        // print(' onRefresh');
        //  await Future.delayed(const Duration(milliseconds: 1000));
        // if failed,use refreshFailed()
        await widget.onRefresh?.call();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        // print(' onLoading');
        // await Future.delayed(const Duration(milliseconds: 1000));

        await widget.onLoading?.call();
        _refreshController.loadComplete();
      },
      header: widget.header ??
          const WaterDropHeader(
            waterDropColor: Colors.transparent,
            idleIcon: SizedBox(
              height: 25.0,
              width: 25.0,
              child: CupertinoActivityIndicator(),
            ),
            refresh: SizedBox(
              height: 25.0,
              width: 25.0,
              child: CupertinoActivityIndicator(),
            ),
            complete: Icon(
              Icons.check,
              color: Colors.grey,
            ),
          ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget? body;
          if (mode == LoadStatus.idle) {
            // body = const Text('pull up load');
            body = const Text('');
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text('Load Failed!Click retry!');
          } else if (mode == LoadStatus.canLoading) {
            body = const Text('release to load more');
          } else {
            body = const Text('No more Data');
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      enablePullDown: true,
      enablePullUp: widget.enablePullUp,
      child: widget.child,
    );
  }
}
