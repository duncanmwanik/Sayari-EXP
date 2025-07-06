import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_helpers/common/background_ops.dart';
import '../../_services/hive/boxes.dart';
import '../../_variables/constants.dart';
import '../../_variables/navigation.dart';
import '_helpers/init.dart';
import 'drawer/drawer.dart';
import 'fab.dart';
import 'layout.dart';
import 'navbars/horizontal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onResumedAppState(state);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeHome();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    unInitializeHome();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: [appReset]),
        builder: (context, box, widget) {
          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              body: AppLayout(),
              drawer: AppDrawer(),
              floatingActionButton: HomeFab(),
              bottomNavigationBar: HorizontalNavigation(),
              key: scaffoldState,
            );
          });
        });
  }
}
