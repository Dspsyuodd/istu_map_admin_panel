import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/map_edit_bloc/map_edit_bloc.dart';

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
              child: const Column(
                children: [
                  EditModeToggle(),
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

class EditModeToggle extends StatefulWidget {
  const EditModeToggle({Key? key}) : super(key: key);

  @override
  _EditModeToggleState createState() => _EditModeToggleState();
}

class _EditModeToggleState extends State<EditModeToggle> {
  var isSelected = List.filled(MapEditMode.values.length, false);
  void _select(int index) {
    setState(() {
      isSelected = List.filled(MapEditMode.values.length, false);
      isSelected[index] = true;
    });
    BlocProvider.of<MapEditBloc>(context)
        .add(ChangeEditMode(MapEditMode.values[index]));
  }

  @override
  void initState() {
    super.initState();
    _select(0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ToggleButtons(
        selectedColor: Colors.white,
        selectedBorderColor: Colors.white,
        isSelected: isSelected,
        onPressed: _select,
        direction: Axis.vertical,
        children: MapEditMode.values
            .map(
              (e) => Text(
                e.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
