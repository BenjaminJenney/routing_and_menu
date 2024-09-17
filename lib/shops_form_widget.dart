import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:routing_and_menu/menu_notifier.dart';
import 'package:routing_and_menu/router_notifier.dart';

class ShopsFormWidget extends StatelessWidget {
  const ShopsFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routerNotifier = Provider.of<RouterNotifier>(context);
    final menuNotifier = Provider.of<MenuNotifier>(context);
    return Center(
      child: ReactiveForm(
        formGroup: FormGroup(
          {
            'id': FormControl<int>(),
          },
        ),
        child: Column(
          children: [
            ReactiveTextField(
              formControlName: 'id',
              decoration: const InputDecoration(
                labelText: 'Id',
                hintText: 'Enter the id',
              ),
            ),
            const SizedBox(height: 20),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: form.valid
                      ? () {
                          routerNotifier.addBranch(
                            StatefulShellBranch(routes: [
                              GoRoute(
                                path: '/shops/${form.control('id').value}',
                                pageBuilder: (context, state) =>
                                    NoTransitionPage(
                                        child: Center(
                                  child:
                                      Text('Shops ${form.control('id').value}'),
                                )),
                              )
                            ]),
                          );

                          routerNotifier.goLatestBranch();

                          Future.delayed(
                            const Duration(milliseconds: 100),
                            () {
                              menuNotifier.addNodeToParent(
                                'Shops ${form.control('id').value}',
                                'Shops',
                                routerNotifier.branches.length - 1,
                              );
                            },
                          );
                        }
                      : null,
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
