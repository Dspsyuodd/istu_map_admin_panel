import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: double.infinity,
        width: 200,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(73, 83, 131, 1),
                    Colors.black,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 2),
                ],
                color: Colors.blue,
              ),
              child: ListView(
                children: [
                  const Gap(20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Маркер",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Gap(20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Ребро",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Gap(20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Удалить",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset('swmg.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
