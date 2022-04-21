import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/internet_cubit.dart';
import 'logic/bloc/internet_tate.dart';
import 'navigations/tabbar.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  const MyApp({Key? key, required this.connectivity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                selectedLabelStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.black,
                type: BottomNavigationBarType.fixed)),
        home: Tabbar(),
      ),
    );
  }
}
