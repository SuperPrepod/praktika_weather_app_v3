import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather_app_v3/Models/Weather_Model.dart';
import 'package:weather_app_v3/Utils/StaticFile.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  List<WeatherModel> weatherModel = [];

  Home({required this.weatherModel});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await scrollToindex();
    });
    find_my_location();
    super.initState();
  }

  find_my_location() {
    // ignore: dead_code
    for (var i = 0; i < widget.weatherModel.length; i++) {
      if (widget.weatherModel[i].name == StaticFile.myLocation) {
        setState(() {
          StaticFile.myLocationIndex = i;
          complete1 = true;
        });
      }
      break;
    }
    find_hour_index();
  }

  DateTime time = DateTime.now();
  int hour_index = 0;
  bool complete1 = false;
  bool complete2 = false;

  find_hour_index() {
    String my_time;
    my_time = time.hour.toString();
    if (my_time.length == 1) {
      my_time = "0" + my_time;
    }
    for (var i = 0;
        i <
            widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
                .allTime!.hour!.length;
        i++) {
      if (widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
              .allTime!.hour![i]!
              .substring(0, 2)
              .toString() ==
          my_time) {
        setState(() {
          hour_index = i;
          complete2 = true;
        });
        break;
      }
    }
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  scrollToindex() async {
    itemScrollController.scrollTo(
        index: hour_index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF11135A),
      body: Container(
          height: myheight,
          width: mywidth,
          child: Column(
            children: [
              SizedBox(
                height: myheight * 0.02,
              ),
              Text(
                widget.weatherModel[StaticFile.myLocationIndex].name.toString(),
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              SizedBox(
                height: myheight * 0.01,
              ),
              Text(
                "17 июня 2024г.".toString(),
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.5)),
              ),
              SizedBox(
                height: myheight * 0.05,
              ),
              Container(
                height: myheight * 0.05,
                width: mywidth * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 21, 85, 169),
                                Color.fromARGB(255, 44, 162, 246)
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Прогноз',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                          child: Text(
                            'Т. воздуха',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: myheight * 0.08,
              ),
              Image.asset(
                widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
                    .mainImg
                    .toString(),
                height: myheight * 0.23,
                width: mywidth * 0.60,
              ),
              SizedBox(
                height: myheight * 0.12,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              'Темп.',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20),
                            ),
                            Text(
                              widget.weatherModel[StaticFile.myLocationIndex]
                                  .weeklyWeather![0]!.mainTemp
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              'Воздух',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20),
                            ),
                            Text(
                              widget.weatherModel[StaticFile.myLocationIndex]
                                  .weeklyWeather![0]!.mainWind
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              'Влажность',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20),
                            ),
                            Text(
                              widget.weatherModel[StaticFile.myLocationIndex]
                                  .weeklyWeather![0]!.mainHumidity
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: myheight * 0.008,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mywidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сегодня',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Полностью',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: mywidth*0.03),
                  child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.weatherModel[StaticFile.myLocationIndex]
                          .weeklyWeather![0]!.allTime!.hour!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mywidth * 0.02,
                                vertical: myheight * 0.04),
                            child: Container(
                                width: mywidth * 0.33,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: hour_index == index
                                        ? null
                                        : Colors.white.withOpacity(0.05),
                                    gradient: hour_index == index
                                        ? LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 21, 85, 169),
                                              Color.fromARGB(255, 44, 162, 246),
                                            ],
                                          )
                                        : null),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        widget
                                            .weatherModel[
                                                StaticFile.myLocationIndex]
                                            .weeklyWeather![0]!
                                            .allTime!
                                            .img![index]
                                            .toString(),
                                        height: myheight * 0.04,
                                      ),
                                      SizedBox(
                                        width: mywidth * 0.0001,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget
                                                .weatherModel[
                                                    StaticFile.myLocationIndex]
                                                .weeklyWeather![0]!
                                                .allTime!
                                                .hour![index]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            widget
                                                .weatherModel[
                                                    StaticFile.myLocationIndex]
                                                .weeklyWeather![0]!
                                                .allTime!
                                                .temps![index]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )));
                      }))
                )  
            ],
          )),
    ));
  }
}
