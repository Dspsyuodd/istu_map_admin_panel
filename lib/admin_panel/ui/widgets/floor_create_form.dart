import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/building.dart';

class FloorCreateForm extends StatelessWidget {
  const FloorCreateForm({Key? key}) : super(key: key);

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
              decoration: const InputDecoration(
                labelText: 'Image link',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
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
                    onDrop: (value) {},
                  ),
                  const Center(child: Text('Drop files here')),
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
                    const FloorInfo(floorNumber: 0, imageLink: 'imageLink'),
                  );
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
