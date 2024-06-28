import 'package:flutter/material.dart';
class NetworkWidget extends StatelessWidget {
  const NetworkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_find_outlined,size: 100,),
          SizedBox(height: 10,),
          Text("No connection InterNet",style: TextStyle(fontSize: 20,color: Colors.grey),)
        ],
      ),
    );
  }
}
