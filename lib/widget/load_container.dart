import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  bool isLoading;
  Widget child;
  bool isCover;

  LoadingContainer({Key key,this.isLoading=false, this.child, this.isCover=false}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return !isCover
        ? !isLoading ? child : _loadingView
        : Stack(
      children: <Widget>[child, isLoading ? _loadingView : null],
    );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
