import 'package:flutix/cubit/pedagang/pedagang_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'services/services.dart';
import 'bloc/blocs.dart';
import 'cubit/cubit.dart';
import 'ui/pages/pages.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => PedagangCubit()),
          BlocProvider(create: (_) => PedagangUserCubit()),
          BlocProvider(create: (_) => RadarCubit()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: SplashScreen()),
      ),
    );
  }
}
