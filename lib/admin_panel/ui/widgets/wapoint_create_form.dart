import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../core/building_object_type.dart';
import '../../domain/entities/waypoint.dart';

class WaypointCreateForm extends StatelessWidget {
  const WaypointCreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = '';
    var description = '';
    var type = BuildingObjectType.node;
    String? keywords;
    return AlertDialog(
      title: const Text('Создание объекта'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                title = value;
              },
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            TextField(
              onChanged: (value) {
                description = value;
              },
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            DropdownMenu(
              initialSelection: 0,
              width: 400,
              onSelected: (value) {
                if (value != null) {
                  type = BuildingObjectType.values[value];
                }
              },
              dropdownMenuEntries: BuildingObjectType.values
                  .map(
                    (e) => DropdownMenuEntry(
                      label: e.name,
                      value: e.index,
                    ),
                  )
                  .toList(),
            ),
            const Gap(20),
            TextField(
              onChanged: (value) {
                keywords = value;
              },
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Ключевые слова (через пробед без запятых)',
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
                    Waypoint(
                      id: 'id',
                      buildingId: 'buildingId',
                      title: title,
                      description: description,
                      floor: 0,
                      type: type,
                      x: 0,
                      y: 0,
                      keywords: keywords,
                    ),
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
