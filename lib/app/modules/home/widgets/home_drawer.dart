import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/services/user/user_services.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('_value');
  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProviderTodo, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://www.seekpng.com/png/detail/514-5147412_default-avatar-icon.png';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(value),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProviderTodo, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.titleSmall,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Alterar nome'),
                      content: TextField(
                        onChanged: ((value) => nameVN.value = value),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final nameValue = nameVN.value;
                            if (nameValue.isEmpty) {
                              Messages.of(context)
                                  .showError('Nome obrigatório!');
                            } else {
                              Loader.show(context);
                              await context
                                  .read<UserServices>()
                                  .updateDisplayName(nameValue);
                              Loader.hide();
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    );
                  });
            },
            title: const Text('Alterar Nome'),
          ),
          ListTile(
            onTap: () {
              context.read<HomeController>().clearTableTodo();
              context.read<AuthProviderTodo>().logout();
            },
            title: const Text('Sair'),
          )
        ],
      ),
    );
  }
}
