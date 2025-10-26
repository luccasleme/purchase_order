import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchase_order/features/auth/presentation/providers/auth_notifier.dart';
import 'package:purchase_order/features/orders/presentation/providers/orders_notifier.dart';
import 'package:purchase_order/core/utils/size.dart';
import 'package:purchase_order/core/utils/text_formatter.dart';
import 'package:purchase_order/routes/app_routes.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final ordersState = ref.watch(ordersProvider);

    final userName = authState.user?.name ?? 'User';
    final isLoading = ordersState.isLoading || ordersState.ordersByStatus.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            'Welcome, $userName!',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () async {
              await authNotifier.signOut();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Color.fromRGBO(204, 0, 51, 1),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(0, 54, 114, 1),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Screen.width(context) / 50,
                mainAxisSpacing: Screen.width(context) / 50,
              ),
              shrinkWrap: true,
              itemCount: ordersState.ordersByStatus.keys.length,
              itemBuilder: (context, index) {
                final title = ordersState.ordersByStatus.keys.toList();
                title.sort((a, b) => a.length.compareTo(b.length));
                final badges =
                    (ordersState.ordersByStatus[title[index]] ?? [])
                        .length
                        .toString();
                final iconList = <IconData>[
                  Icons.mark_email_unread,
                  Icons.close,
                  Icons.error,
                  Icons.done,
                  Icons.wallet,
                  Icons.receipt,
                  Icons.payments,
                  Icons.receipt_long,
                ];

                return InkWell(
                  onTap: () {
                    context.push(
                      AppRoutes.taskList,
                      extra: {'title': title[index], 'index': index},
                    );
                  },
                  child: GridTile(
                    header: Align(
                      alignment: Alignment.topRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          badges,
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: Screen.width(context) / 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          iconList[index],
                          size: Screen.width(context) / 5,
                          color: const Color.fromRGBO(0, 0, 100, 1),
                        ),
                        FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            textFormater(title[index]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
