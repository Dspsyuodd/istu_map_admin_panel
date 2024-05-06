import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../injection_container.dart';
import '../admin_panel_bloc/admin_panel_bloc_bloc.dart';
import '../map_edit_bloc/map_edit_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/builing_map.dart';
import '../widgets/error_alert_dialog.dart';
import '../widgets/left_panel.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminPanelBloc>(create: (_) => sl<AdminPanelBloc>()),
        BlocProvider<MapEditBloc>(create: (_) => sl<MapEditBloc>()),
      ],
      child: Scaffold(
        appBar: const AdminAppBar(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<MapEditBloc, MapEditState>(
              listener: (context, state) {
                if (state is MapUnknownError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (_) => ErrorAlertDialog(
                        message: state.message,
                        stackTrace: state.stackTrace,
                      ),
                    );
                  });
                }
                if (state is MapServerError) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 5),
                          content: Column(
                            children: [
                              SelectableText(
                                "ERROR: ${state.code}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const Gap(20),
                              SelectableText(state.message,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            BlocListener<AdminPanelBloc, AdminPanelState>(
              listener: (context, state) {
                if (state is Loaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    BlocProvider.of<MapEditBloc>(context).add(
                      InitFloors(
                        state.floors,
                      ),
                    );
                  });
                }
                if (state is UnknownError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (_) => ErrorAlertDialog(
                        message: state.message,
                        stackTrace: state.stackTrace,
                      ),
                    );
                  });
                }
                if (state is ServerError) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 5),
                          content: Column(
                            children: [
                              SelectableText(
                                "ERROR: ${state.code}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const Gap(20),
                              SelectableText(state.message,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
          child: const Stack(
            children: [
              BuildingMap(),
              LeftPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
