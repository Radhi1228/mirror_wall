import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void setBookmark({required List<String> bookMark})
async{
  SharedPreferences shr =await SharedPreferences.getInstance();
  shr.setStringList("Url", bookMark);
}
Future <List<String>?> getBookmark()
async {
  SharedPreferences shr =await SharedPreferences.getInstance();
  return shr.getStringList("Url");

}