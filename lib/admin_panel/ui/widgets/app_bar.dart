import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/building.dart';
import '../admin_panel_bloc/admin_panel_bloc_bloc.dart';
import 'building_create_form.dart';
import 'floor_create_form.dart';

class AdminAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AdminAppBar({Key? key}) : super(key: key);

  @override
  State<AdminAppBar> createState() => _AdminAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}

class _AdminAppBarState extends State<AdminAppBar> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminPanelBloc>(context).add(GetBuildings());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(73, 83, 131, 1),
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              spreadRadius: 2),
        ],
      ),
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            left: 20,
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AdminPanelBloc, AdminPanelState>(
                builder: (context, state) {
                  if (state is Loaded) {
                    return DropdownMenu(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      initialSelection: state.selectedBuildingIndex,
                      onSelected: (value) {
                        if (value == null) return;
                        BlocProvider.of<AdminPanelBloc>(context).add(
                          SelectBuilding(value),
                        );
                      },
                      dropdownMenuEntries: state.buildings
                          .mapIndexed(
                            (index, element) => DropdownMenuEntry(
                                value: index, label: element.title),
                          )
                          .toList(),
                    );
                  }
                  return const DropdownMenu(
                    dropdownMenuEntries: [],
                  );
                },
              ),
              const Gap(20),
              BlocBuilder<AdminPanelBloc, AdminPanelState>(
                builder: (context, state) {
                  if (state is Loaded) {
                    return Visibility(
                      visible: state.selectedBuildingIndex != null,
                      child: ElevatedButton(
                        onPressed: () async {
                          var floor = await showDialog<FloorInfo>(
                            context: context,
                            builder: (context) => const FloorCreateForm(),
                          );
                          if (!mounted || floor == null) return;
                          BlocProvider.of<AdminPanelBloc>(context).add(
                            AddFloor(
                              floor,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 99, 197, 103),
                        ),
                        child: const Text(
                          "Добавить этаж",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
          Positioned(
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 99, 197, 103),
              ),
              onPressed: () async {
                var building = await showDialog<Building>(
                  context: context,
                  builder: (context) => const BuildingCreateForm(),
                );
                if (!mounted) return;
                if (building != null) {
                  BlocProvider.of<AdminPanelBloc>(context).add(
                    AddBuilding(building),
                  );
                }
              },
              child: const Text(
                "Добавить здание",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
