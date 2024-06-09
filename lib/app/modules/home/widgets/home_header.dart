import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Selector<AuthProviderTodo, String>(
        selector: (context, authProvider) =>
            authProvider.user?.displayName ?? 'Não informado',
        builder: (_, value, __) {
          return Text(
            value,
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
