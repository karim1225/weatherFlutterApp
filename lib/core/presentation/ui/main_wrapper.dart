import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/presentation/widgets/app_background.dart';
import 'package:weather_app/core/presentation/widgets/bottom_nav.dart';
import 'package:weather_app/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:weather_app/features/feature_weather/data/models/current_city_model.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/feature_weather/presentation/screens/weather_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const WeatherScreen(),
      const BookMarkScreen(),
    ];
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomNav(
        controller: pageController,
      ),
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AppBackground.getBackGroundImage(),
            fit: BoxFit.cover,
          ),
        ),
        height: height,
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<WeatherBloc>(context).add(LoadCwEvent('Tehran'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather App'),
//         backgroundColor: Colors.blue,
//       ),
//       body: BlocBuilder<WeatherBloc, WeatherState>(
//         builder: (context, state) {
//           if (state.cwStatus is CwLoading) {
//             return const Center(
//               child: Text('Loading...'),
//             );
//           }
//           if (state.cwStatus is CwCompleted) {
//             //cast
//             final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
//             final CurrentCityEntity currentCityEntity =
//                 cwCompleted.currentCityEntity;
//             return Center(
//               child: Text(
//                 currentCityEntity.name.toString(),
//               ),
//             );
//           }
//           if (state.cwStatus is CwError) {
//             return const Center(
//               child: Text('error'),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
