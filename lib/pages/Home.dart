import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_name/model/common_model.dart';
import 'package:flutter_app_name/model/gridNav_model.dart';
import 'package:flutter_app_name/model/home_model.dart';
import 'package:flutter_app_name/model/salesBox_model.dart';
import 'package:flutter_app_name/net/home_net.dart';
import 'package:flutter_app_name/widget/grid_nav.dart';
import 'package:flutter_app_name/widget/loading_widget.dart';
import 'package:flutter_app_name/widget/local_nav.dart';
import 'package:flutter_app_name/widget/sales_nav.dart';
import 'package:flutter_app_name/widget/sub_nav.dart';
import 'package:flutter_app_name/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SwiperController _swiperController;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  GridNavModel gridNav;
  bool isLoading=true;
  final PageController pageController = PageController(initialPage: 0);
  double opacityValue = 0;
  static const double ALL_VALUES = 100;
  final list = [
    "https://y2bossfilegroup.blob.core.windows.net/fileserver01-test/3f3b66e9dac05e44c11a579282f992b8.jpg",
    "https://y2bossfilegroup.blob.core.windows.net/fileserver01-test/cab5edab2463b3b58c76eaef6c301bd0.jpg",
    "https://y2bossfilegroup.blob.core.windows.net/fileserver01-test/726939e376e5c61a6c81715a069b51ec.jpg"
  ];

  void _setScrollOffset(double pixels) {
    double alph = pixels / ALL_VALUES;
    if (alph < 0) {
      alph = 0;
    } else if (alph > 1) {
      alph = 1;
    }
    setState(() {
      opacityValue = alph;
    });
    print('还得+$alph' + "===pixels==$pixels");
  }

  @override
  void initState() {
    super.initState();
    _swiperController = new SwiperController();
    _swiperController.startAutoplay();
    loadHomeData();
  }

  void loadHomeData() {
    print('哈哈哈222 ');
    HomeNet.getHomeData()
        .then((value) => setData(value))
        .catchError((onError) => setError(onError));
  }

  setData(HomeModel homeModel) {
    setState(() {
      bannerList = homeModel.bannerList;
      localNavList = homeModel.localNavList;
      gridNav = homeModel.gridNav;
      salesBox = homeModel.salesBox;
      subNavList = homeModel.subNavList;
      isLoading=false;
    });

  }
  setError(onError) {
    setState(() {
      isLoading=false;
    });
  }
  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark); //不存在APPBar设置状态栏上文字颜色黑色
    return Scaffold(
      body:LoadingWidget(
        isLoading: isLoading,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            decoration: BoxDecoration(color: Color(int.parse('0xFFfafafc'))),
            child: NotificationListener(
              onNotification: (Notification notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  _setScrollOffset(notification.metrics.pixels);
                }
                return true;
              },
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        height: 200,
                        child: new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.network(
                              bannerList.elementAt(index).icon,
                              fit: BoxFit.fill,
                            );
                          },
                          onTap: (index){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WebView(
                              url: bannerList.elementAt(index).url,
                              title: bannerList.elementAt(index).title,
                              statusBarColor: bannerList.elementAt(index).statusBarColor,
                              hideAppBar: bannerList.elementAt(index).hideAppBar,
                            )));
                          },
                          autoplay: true,
                          itemCount: bannerList.length,
                          //controller: _swiperController,
                          pagination: new SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: LocalNav(localNavList: localNavList),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, top: 0, right: 10, bottom: 10),
                        child: GridNav(gridNav: gridNav),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, top: 0, right: 10, bottom: 10),
                        child: SubNav(subNavList: subNavList),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, top: 0, right: 10, bottom: 10),
                        child: SalesNav(salesBox: salesBox),
                      )
                    ],
                  ),
                  Opacity(
                    opacity: opacityValue,
                    child: Container(
                      height: MediaQuery.of(context).padding.top+45,
                      padding: EdgeInsets.only(top: (MediaQuery.of(context).padding.top)),
                      decoration: BoxDecoration(color: Colors.white),
                      width: double.infinity,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Center(
                          child: Text(
                            '首页',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ) ,
      )
    );
  }


}
