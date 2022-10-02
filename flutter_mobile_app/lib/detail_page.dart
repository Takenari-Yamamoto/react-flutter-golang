import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Navigator.of(context).pop()},
          color: const Color.fromARGB(255, 96, 96, 96),
        ),
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ラーメン食べる', style: TextStyle(fontSize: 24)),
              const SizedBox(
                height: 12,
              ),
              Row(children: const [
                Icon(Icons.calendar_month_outlined),
                Text('2022/10/02', style: TextStyle(fontSize: 16)),
              ]),
              const SizedBox(
                height: 12,
              ),
              Row(children: const [
                Icon(Icons.details_outlined),
                Text('今日は美味しいラーメンを食べますよ~', style: TextStyle(fontSize: 16)),
              ])
            ],
          )),
    );
  }
}
