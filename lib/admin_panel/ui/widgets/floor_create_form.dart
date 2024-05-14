import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/building.dart';

class FloorCreateForm extends StatefulWidget {
  const FloorCreateForm({Key? key}) : super(key: key);

  @override
  State<FloorCreateForm> createState() => _FloorCreateFormState();
}

class _FloorCreateFormState extends State<FloorCreateForm> {
  var dropMessage = 'Drop files here';
  File? image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Создание этажа'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {},
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Floor number',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              width: 400,
              height: 200,
              child: Stack(
                children: [
                  DropzoneView(
                    operation: DragOperation.copy,
                    cursor: CursorType.grab,
                    onDrop: (value) {
                      image = value as File;
                      setState(() {
                        dropMessage = image!.name;
                      });
                    },
                  ),
                  Center(child: Text(dropMessage)),
                ],
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 99, 197, 103),
                ),
                onPressed: () {
                  Navigator.of(context).pop(
                      (const FloorInfo(floorNumber: 0, floorId: ''), image));
                },
                child: const Text(
                  "Готово",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
