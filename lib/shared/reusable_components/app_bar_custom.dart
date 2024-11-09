import 'package:flutter/material.dart';

AppBar buildAppBar(
{
  String text ='To Do List'
}
)
{
  return AppBar(
    title: Text(
      text ,
    ),
  );
}