import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/app_widget.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list/app/repositories/user/user_repository.dart';
import 'package:todo_list/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list/app/services/user/user_service_impl.dart';
import 'package:todo_list/app/services/user/user_services.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          // lazy inicia logo quando abre a aplicação
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
        Provider<UserServices>(
          create: (context) => UserServiceImpl(
            userRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProviderTodo(
            firebaseAuth: context.read(),
            userServices: context.read(),
          )..loadListener(),
        )
      ],
      child: const AppWidget(),
    );
  }
}
