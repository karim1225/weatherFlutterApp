import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/presentation/widgets/app_background.dart';
import 'package:weather_app/core/presentation/widgets/dot_loading_widget.dart';
import 'package:weather_app/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/feature_weather/presentation/widgets/day_weather_view.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(LoadCwEvent('Tehran'));
  }

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
              buildWhen: (previous, current) {
            if (previous.cwStatus == current.cwStatus) {
              return false;
            }
            return true;
          }, builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return const Expanded(
                child: DotLoadingWidget(),
              );
            }
            if (state.cwStatus is CwCompleted) {
              //cast
              final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
              final CurrentCityEntity currentCityEntity =
                  cwCompleted.currentCityEntity;

              final ForecastParams forecastParams = ForecastParams(
                  currentCityEntity.coord!.lat!, currentCityEntity.coord!.lon!);
              BlocProvider.of<WeatherBloc>(context)
                  .add(LoadFwEvent(forecastParams));

              return Expanded(
                child: Center(
                    child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: hieght * 0.02),
                      child: SizedBox(
                        width: width,
                        height: 430,
                        child: PageView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          allowImplicitScrolling: true,
                          controller: _pageController,
                          itemCount: 2,
                          itemBuilder: (context, position) {
                            if (position == 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Text(
                                      currentCityEntity.name!,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      currentCityEntity
                                          .weather![0].description!,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: AppBackground.setIconForMain(
                                        currentCityEntity
                                            .weather![0].description!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      "${currentCityEntity.main!.temp!.round()}\u00B0",
                                      style: const TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'max',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          color: Colors.grey,
                                          width: 2,
                                          height: 40,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'min',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              );
                            } else {
                              return Container(
                                color: Colors.amber,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// pageView Indicator
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        // PageController
                        count: 2,
                        effect: const ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          spacing: 5,
                          activeDotColor: Colors.white,
                        ),
                        // your preferred effect
                        onDotClicked: (index) => _pageController.animateToPage(
                          index,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.bounceOut,
                        ),
                      ),
                    ),

                    /// divider
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        color: Colors.white24,
                        height: 2,
                        width: double.infinity,
                      ),
                    ),

                    /// forecast weather 7 days
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Center(
                            child: BlocBuilder<WeatherBloc, WeatherState>(
                              builder: (BuildContext context, state) {
                                /// show Loading State for Fw
                                if (state.fwStatus is FwLoading) {
                                  return const DotLoadingWidget();
                                }

                                /// show Completed State for Fw
                                if (state.fwStatus is FwCompleted) {
                                  /// casting
                                  final FwCompleted fwCompleted =
                                      state.fwStatus as FwCompleted;
                                  final ForecastDaysEntity forecastDaysEntity =
                                      fwCompleted.forecastDaysEntity;
                                  final List<Daily> mainDaily =
                                      forecastDaysEntity.daily!;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return DaysWeatherView(
                                        daily: mainDaily[index],
                                      );
                                    },
                                  );
                                }

                                /// show Error State for Fw
                                if (state.fwStatus is FwError) {
                                  final FwError fwError =
                                      state.fwStatus as FwError;
                                  return Center(
                                    child: Text(fwError.message!),
                                  );
                                }

                                /// show Default State for Fw
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// divider
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        color: Colors.white24,
                        height: 2,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )),
              );
            }
            if (state.cwStatus is CwError) {
              return const Center(
                child: Text(
                  'error',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return Container();
          }),
        ],
      ),
    );
  }
}
