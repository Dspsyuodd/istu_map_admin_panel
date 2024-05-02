import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:istu_map_admin_panel/admin_panel/injection_container.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/bloc/admin_panel_bloc_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/app_bar.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/builing_map.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/error_alert_dialog.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/left_panel.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AdminPanelBloc>(),
      child: Scaffold(
        appBar: const AdminAppBar(),
        body: BlocListener<AdminPanelBloc, AdminPanelState>(
          listener: (context, state) {
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
