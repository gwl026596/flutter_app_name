import 'package:flutter/material.dart';
import 'package:flutter_app_name/pages/Search.dart';
import 'package:flutter_app_name/plugin/arm_manager.dart';

const double SPEAK_SIZE = 80;

class Speak extends StatefulWidget {
  @override
  _SpeakState createState() => _SpeakState();
}

class _SpeakState extends State<Speak> with TickerProviderStateMixin {
  CurvedAnimation animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn)
          ..addListener(() {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (animationController.status ==
                AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             _topItem(),
            _bottomItem(),
          ],
        ),
      ),
    );
  }

  _topItem() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Text(
              '你可以这样说',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Text(
            '故宫门票',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            '北京一日游',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            '迪士尼乐园',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  _bottomItem() {
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '长安说话',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: SPEAK_SIZE,
                    height: SPEAK_SIZE,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(40)),
                    child: null,
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      animationController.forward();
                      ArmManager.start().then((result){
                       if(result!=null&&result.length>0){
                         print('语音结果 $result');
                         Navigator.pop(context,result);
                         //Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(keyWordStr:result)));
                       }
                      }).catchError((e){
                        
                      });
                    },
                    onTapUp: (details) {
                      animationController.reset();
                      animationController.stop();
                      ArmManager.stop();
                    },
                    onTapCancel: () {
                      animationController.reset();
                      animationController.stop();
                      ArmManager.cancle();
                    },
                    child: SpeakAnimation(
                      animation: animation,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: (){
                       Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.grey,
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpeakAnimation extends AnimatedWidget {
 final Tween sizeTween = Tween(begin: 80.0, end: 60.0);
 final Tween opacityTween = Tween(begin: 1.0, end: 0.5);
  SpeakAnimation({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: opacityTween.evaluate(animation),
      child: Container(
        width: sizeTween.evaluate(animation),
        height: sizeTween.evaluate(animation),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(40)),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
