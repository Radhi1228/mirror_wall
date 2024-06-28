import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../utils/shared_helper.dart';
class HomeProvider with ChangeNotifier
{
  double checkProgress=0;
  bool text=false;
  String isChoice="Google";
  bool isOnline=true;
  Connectivity connectivity =Connectivity();
  List<String> bookMark=[];


  void  onProgress()
  {
      Connectivity().onConnectivityChanged.listen(
            (event) {
          if (event.contains(ConnectivityResult.none)) {
            isOnline = false;
            //no internet
          } else {
            isOnline = true;
            // internet on
          }
          notifyListeners();
        },
      );

  }

  void checkLinearPrograss(double p1)
  {
    checkProgress=p1;
    notifyListeners();
  }
  void chaneText()
  {
    text!=text;
    notifyListeners();
  }
  void checkUi( check)
  {
    isChoice=check;
    notifyListeners();
  }
  void getBookmarkData() async{
    if(await getBookmark()==null)
      {
        bookMark=[];
      }
      else
      {
        bookMark=(await getBookmark())!;
      }
      notifyListeners();
    }
  void setBookmarkData(String url){
    getBookmark();
    bookMark.add(url);
    setBookmark(bookMark: bookMark);
    getBookmark();
    notifyListeners();

  }




}