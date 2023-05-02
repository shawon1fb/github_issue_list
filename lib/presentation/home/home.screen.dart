import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../shared/scroll/refress_scroll.dart';
import 'components/issue-item.widget.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Issues',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            20.verticalSpace,
            Expanded(
              child: controller.obx(
                (state) {
                  return RefreshScroll(
                    scrollController: scrollController,

                    enablePullUp: true,
                    onLoading: () async {
                      await controller.getIssueList();
                    },
                    onRefresh: () async {
                      await controller.onRefresh();
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state!.length,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        var item = state[index];
                        return IssueItemWidget(
                          model: item,
                        );
                      },
                    ),
                  );
                },
                onLoading: const Center(
                  child: CircularProgressIndicator(),
                ),
                onEmpty: const Center(
                  child: Text('No data'),
                ),
                onError: (error) => Center(
                  child: Text(error.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
