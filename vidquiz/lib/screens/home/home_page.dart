import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidquiz/screens/components/AppBarPainter.dart';
import 'package:get/get.dart';
import './home_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xFFCA5C),
      appBar: AppBar(
        // backgroundColor: Color(0xffF57752),
        // brightness: Brightness.dark,
        elevation: 0,
        title: Text('title'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'settings'.tr,
            enableFeedback: true,
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.snackbar('title'.tr, 'settings'.tr,
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimationLimiter(
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: controller.reposControler.courseList.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildListItem(context, controller, _w, index),
                    ),
                  ),
                );
              },
            ),
          ),
          CustomPaint(
            painter: AppBarPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
    );
  }
}

_buildListItem(
    BuildContext context, HomeController controller, double _w, int index) {
  return Opacity(
    opacity: 0.8, //_animation.value,
    child: Transform.translate(
      offset: Offset(0, 30), //_animation2.value),
      child: InkWell(
        enableFeedback: true,
        onTap: () {
          Get.toNamed('/videoPlayer');
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
          padding: EdgeInsets.all(_w / 20),
          height: _w / 4.4,
          width: _w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffEDECEA),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(.1),
                radius: _w / 15,
                child: FlutterLogo(size: 30),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: _w / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.reposControler.courseList[index]['title'],
                      textScaleFactor: 1.6,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                    Text(
                      controller.reposControler.courseList[index]['subtitle'],
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(.8),
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.navigate_next_outlined)
            ],
          ),
        ),
      ),
    ),
  );
}
