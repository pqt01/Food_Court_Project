import 'package:flutter/material.dart';

/// Flutter code sample for [AppBar].

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

// void main() => runApp(const AppBarApp());

// class MenuManagerment extends StatelessWidget {
//   const AppBarApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
//       home: const AppBarExample(),
//     );
//   }
// }

class MenuManagermentScreen extends StatelessWidget {
  const MenuManagermentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar Sample'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.cloud_outlined),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.beach_access_sharp),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.brightness_5_sharp),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[0]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[2]} $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
