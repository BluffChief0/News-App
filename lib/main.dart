import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_bloc/news_bloc.dart';
import 'package:news_app/route_generator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSizer(
//       builder: (context, orientation, screenType) {
//         return MaterialApp(
//           home: HeroControllerScope(
//             controller: MaterialApp.createMaterialHeroController(),
//             child: const Navigator(
//               initialRoute: '/',
//               onGenerateRoute: RouteGenerator.generateRoute,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NewsBloc newsBloc;

  @override
  void initState() {
    newsBloc = NewsBloc();
    newsBloc.add(const NewsInitialize());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => newsBloc,
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            home: HeroControllerScope(
              controller: MaterialApp.createMaterialHeroController(),
              child: const Navigator(
                initialRoute: '/',
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            ),
          );
        },
      ),
    );
  }
}

