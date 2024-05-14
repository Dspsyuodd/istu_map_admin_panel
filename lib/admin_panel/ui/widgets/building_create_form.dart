import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/building.dart';

class BuildingCreateForm extends StatelessWidget {
  const BuildingCreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = '';
    var address = '';
    var description = '';
    String? keywords;
    double? latitude;
    double? longtitude;
    return AlertDialog(
      title: const Text('Создание здания'),
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
                labelText: 'Название',
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
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) {
                      latitude = double.tryParse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Широта',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Gap(20),
                Flexible(
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) {
                      longtitude = double.tryParse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Долгота',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            TextField(
              onChanged: (value) {
                address = value;
              },
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Адрес',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            TextField(
              onChanged: (value) {
                keywords = value;
              },
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Ключевые слова (через пробел без запятых)',
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
                  if (latitude != null && longtitude != null) {
                    Navigator.of(context).pop(
                      Building(
                        id: '',
                        title: title,
                        floors: const [],
                        description: description,
                        address: address,
                        latitude: latitude!,
                        longitude: longtitude!,
                        keywords: keywords,
                      ),
                    );
                  }
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
