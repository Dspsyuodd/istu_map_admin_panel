import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/building.dart';

class FloorCreateForm extends StatelessWidget {
  const FloorCreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Создание здания'),
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
