


import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  final bool isLoading;
  final bool isCover;
  final Widget child;

  const LoadingWidget({Key key, this.isLoading, this.isCover=false, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Center(
     child:!isCover? !isLoading?child:_addLoading():_addCover(),
   );
  }

  Widget _addLoading() {
    return Center(child: CircularProgressIndicator());
  }

  _addCover() {
    return Stack(
      children: [
        child,
        !isLoading?_addLoading():null
      ],
    );
  }

}