import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../shared/scroll/refress_scroll.dart';
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
                      itemBuilder: (context, index) {
                        var item = state[index];
                        return ListTile(
                          title: Text('$index => ${item.title}'),
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
