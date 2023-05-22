import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:unsplash/cubit/blocobserver.dart';
import 'package:unsplash/screens/explorepage.dart';
import 'package:unsplash/screens/favoritepage.dart';
import 'package:unsplash/screens/homepage.dart';
import 'package:unsplash/screens/searchpag.dart';
import 'package:unsplash/screens/splashpage.dart';
import 'package:unsplash/utils/constant_colore.dart';
import 'package:unsplash/utils/my_state.dart';
import 'package:unsplash/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> pages = [
    const HomePage(),
     SearchPag(),
    const ExplorePage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageState())
      ],
      builder: (context, _) {
        final pageState = Provider.of<PageState>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            cardColor: containerLight,
            scaffoldBackgroundColor: ScafoldLight,
            backgroundColor: ScafoldDark,
                primaryColor: primaryColor,
                bottomAppBarColor:textLight ,
            buttonColor:buttonColorLight ,
            appBarTheme:AppBarTheme(
              backgroundColor: ScafoldLight,
            ),
          ),
          darkTheme: ThemeData(
            cardColor: containerDark,
            scaffoldBackgroundColor: ScafoldDark,
              backgroundColor: ScafoldLight,
            bottomAppBarColor:Colors.black87,
            appBarTheme:AppBarTheme(
              backgroundColor: ScafoldDark,
            ),
          ),
          themeMode: ThemeMode.system,
          home: AnimatedSplashScreen(
            splash: const SplashScreen(),
            centered: true,
            splashIconSize: 900,
            nextScreen:  WillPopScope(
              onWillPop: () async {
                if (pageState.currentPage != 0) {
                  pageState.changePage(0);
                  controller.jumpTo(0);
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                body: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  children: pages,
                  onPageChanged: (index) {
                    pageState.changePage(index);
                  },
                ),
                bottomNavigationBar:
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal:10 ),
                    child: BottomNavBar(pageController: controller),
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}
