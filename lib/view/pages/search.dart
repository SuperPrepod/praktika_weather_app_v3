import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:weather_app_v3/Models/Weather_Model.dart';
import 'package:weather_app_v3/Utils/StaticFile.dart';

class Search extends StatefulWidget {
  List<WeatherModel> weatherModel = [];

  Search({required this.weatherModel});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF11135A),
        body: Container(
            height: myHeight,
            width: myWidth,
            child: Column(
              children: [
                SizedBox(
                  height: myHeight * 0.02,
                ),
                Text(
                  'Выберите город',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: myHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                  child: Column(
                    children: [
                      Text(
                        'Введите город или область',
                        style: TextStyle(
                            fontSize: 18, color: Colors.white.withOpacity(0.5)),
                      ),
                      Text(
                        'для просмотра детального прогноза', 
                        style: TextStyle(
                            fontSize: 18, color: Colors.white.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: myHeight * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.05)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.05),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Image.asset(
                                    'assets/icons/2.2.png',
                                    height: myHeight * 0.025,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  hintText: 'поиск...',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.03,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.05)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: myHeight * 0.013),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/6.png',
                                  height: myHeight * 0.03,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: myHeight * 0.02,
                ),
                Expanded(
                    child: GridView.custom(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.02),
                        gridDelegate: SliverStairedGridDelegate(
                            mainAxisSpacing: 13,
                            startCrossAxisDirectionReversed: false,
                            pattern: [
                              StairedGridTile(0.5, 3 / 2.2),
                              StairedGridTile(0.5, 3 / 2.2),
                            ]),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: widget.weatherModel.length,
                          (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: myWidth * 0.03,),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: StaticFile.myLocation ==
                                            widget.weatherModel[index].name
                                                .toString()
                                        ? null
                                        : Colors.white.withOpacity(0.05),
                                    gradient: StaticFile.myLocation ==
                                            widget.weatherModel[index].name
                                                .toString()
                                        ? LinearGradient(colors: [
                                            Color.fromARGB(255, 21, 85, 169),
                                            Color.fromARGB(255, 44, 162, 246),
                                          ])
                                        : null,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget
                                                    .weatherModel[index]
                                                    .weeklyWeather![index]!
                                                    .mainTemp
                                                    .toString()
                                                    .replaceAll('C', ''),
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: myHeight * 0.01,
                                              ),
                                              Text(
                                                weather_state[index].toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white
                                                        .withOpacity(0.5)),
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            widget.weatherModel[index]
                                                .weeklyWeather![index]!.mainImg
                                                .toString(),
                                            height: myHeight * 0.07,
                                            width: myWidth * 0.15,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget.weatherModel[index].name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )))
              ],
            )),
      ),
    );
  }

  List<String> weather_state = [
    "Rainny",
    "Rainny",
    "Rainny",
    "Cloudy",
    "Sunny",
    "Sunny",
  ];
}