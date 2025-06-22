// app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routing/app_router.dart';
import 'logic/blocs/auth/auth_bloc.dart';

class WanderOromiaApp extends StatelessWidget {
  const WanderOromiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        // Add other Blocs here...
      ],
      child: MaterialApp.router(
        title: 'Wander Oromia',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: const Color(0xFFF0FFF0),
        ),
        routerConfig: AppRouter().router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
