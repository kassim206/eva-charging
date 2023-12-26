import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  State<Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coupons',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/nofile.json',height: 300),
            Text(
              'no offer coupons found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue[900],
            ),),
          ],
        ),
      ),
    );
  }
}
