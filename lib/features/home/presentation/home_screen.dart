import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/custom_colors.dart';
import 'package:music_app/comman/theme/theme_provider.dart';
import 'package:music_app/features/authentication/presentation/controller/authentication_provider.dart';
import 'package:music_app/features/home/presentation/home_tab_view_screen.dart';
import 'package:music_app/features/home/presentation/library_tab_view_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: const Text('Logout'),
                  onTap: () {
                    context.read<AuthenticationProvider>().signOut();
                  }),
              PopupMenuItem(
                  child: const Text('Toggle theme'),
                  onTap: () {
                    context.read<ThemeProvider>().toggleThemeMode();
                  })
            ];
          },
        )
      ]),
      body: Container(
        child: TabBarView(controller: _tabController, children: [
          const HomeTabViewScreen(),
          const LibararyTabViewScreen(),
        ]),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: CustomColors.PRIMARY_COLOR,
        ),
        child: TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              text: 'Home',
            ),
            Tab(
              text: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}
