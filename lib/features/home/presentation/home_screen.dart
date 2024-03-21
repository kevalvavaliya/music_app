import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/custom_colors.dart';
import 'package:music_app/comman/theme/theme_provider.dart';
import 'package:music_app/comman/util/constants.dart';
import 'package:music_app/comman/util/custom_snackbar.dart';
import 'package:music_app/features/authentication/presentation/controller/authentication_provider.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
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
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          Switch.adaptive(
            value:
                ThemeMode.dark == context.watch<ThemeProvider>().getthemeMode(),
            activeThumbImage: const AssetImage(Constants.DARK_THEME_ICON),
            inactiveThumbImage: const AssetImage(Constants.LIGHT_THEME_ICON),
            onChanged: (value) {
              context.read<ThemeProvider>().toggleThemeMode().then((value) {
                if (!value) {
                  CustomSnackBar.showSnackbar(
                      context, 'Failed to change theme');
                }
              });
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: const Text('Logout'),
                    onTap: () async {
                      // dispose audio player on logout
                      await context.read<SongsProvider>().softDispose();
                      if (context.mounted) {
                        await context.read<AuthenticationProvider>().signOut();
                      }
                    }),
              ];
            },
          )
        ]),
        body: TabBarView(controller: _tabController, children: const [
          HomeTabViewScreen(),
          LibararyTabViewScreen(),
        ]),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: CustomColors.PRIMARY_COLOR,
          ),
          child: TabBar(
            controller: _tabController,
            indicatorWeight: 5,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black,
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
      ),
    );
  }
}
