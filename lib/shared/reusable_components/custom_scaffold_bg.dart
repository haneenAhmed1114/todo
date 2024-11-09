import 'package:flutter/material.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

class CustomScaffoldBg extends StatelessWidget {
  const CustomScaffoldBg({super.key, this.body,this.bottomNavigationBar , this.floatingActionButton,this.appBar,this.floatingActionButtonLocation});
  final Widget? body ;
  final Widget? bottomNavigationBar ;
  final Widget? floatingActionButton ;
  final PreferredSizeWidget? appBar ;
  final FloatingActionButtonLocation? floatingActionButtonLocation ;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor ,
          Theme.of(context).scaffoldBackgroundColor,],
          stops: const [
          0.2 ,
          0.2 ,],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
      backgroundColor: AppColors.transparentColor,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
