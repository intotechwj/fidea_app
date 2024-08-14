import 'package:fidea_app/views/utility/home_page_utility.dart';
import 'package:flutter/material.dart';
import 'package:fidea_app/views/widgets/appbar_widget.dart';
import 'package:fidea_app/views/widgets/drawer_widget.dart';
import 'package:fidea_app/views/widgets/floatingactionbutton_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Fidea'),
      drawer: const MyDrawer(),
      floatingActionButton: const CustomFloatingActionButtonWidget(),
      body: noteStreamBuilder(),
    );
  }


}
