import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/ui/widgets.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';

class ExampleList3Page extends StatefulWidget {
  const ExampleList3Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleList3Page> createState() => _ExampleList3PageState();
}

class Continent {
  String name;
  List<Country> countries;

  Continent({
    required this.name,
    required this.countries,
  });

  @override
  String toString() {
    return 'ทวีป{$name $countries}';
  }
}

class Country {
  String name;
  List<String> cities;

  Country({
    required this.name,
    required this.cities,
  });

  @override
  String toString() {
    return 'ประเทศ{$name $cities}';
  }
}

T fn<T>(T Function() builder) => builder();

class _ExampleList3PageState extends State<ExampleList3Page> {
  LiveData<List<Continent>> continentListLv = LiveData(
    <Continent>[],
    name: 'cnLiveData',
  ).apply(eachItemsInListAsLiveData(then: (LiveData<Continent> continentLv) {
    attach(
      continentLv,
      continentLv.value.countries,
    ).apply(eachItemsInListAsLiveData(then: (LiveData<Country> countryLv) {
      attach(
        countryLv,
        countryLv.value.cities,
      );
    }));
  }));

  LiveData<int> guideStep = LiveData(0);
  Timer? _timer1;
  Timer? _timer2;
  Timer? _timer3;
  Timer? _timer4;
  Timer? _timer5;
  Timer? _timer6;
  Timer? _timer7;
  Timer? _timer8;

  void clearTimer() {
    _timer1?.cancel();
    _timer2?.cancel();
    _timer3?.cancel();
    _timer4?.cancel();
    _timer5?.cancel();
    _timer6?.cancel();
    _timer7?.cancel();
    _timer8?.cancel();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    guideStep.value = 0;
    clearTimer();

    setState(() {
      var initData = <Continent>[
        Continent(name: 'Asia', countries: [
          Country(name: 'Thailand', cities: ['Bangkok', 'Chiangmai']),
          Country(name: 'Japan', cities: ['Tokyo', 'Osaka']),
        ]),
      ];

      continentListLv.close();
      continentListLv = LiveData(
        initData,
        name: 'continentsLiveData',
      ).apply(eachItemsInListAsLiveData(then: (LiveData<Continent> continentLv) {
        attach(
          continentLv,
          continentLv.value.countries,
        ).apply(eachItemsInListAsLiveData(then: (LiveData<Country> countryLv) {
          attach(
            countryLv,
            countryLv.value.cities,
          ).apply(eachItemsInListAsLiveData());
        }));
      }));
      // continentListLv.attachedItems.forEach((key, a) {
      //   print('1 -- continentListLv.attachedItem :: $key --> "${a.name}" $a');
      //   for (var i = 0; i < continentListLv.value.length; i++) {
      //     LiveData<Continent> continentLv = detach(continentListLv, continentListLv.value[i])!;
      //     continentLv.attachedItems.forEach((key, b) {
      //       print('2 -- continentLv.attachedItems :: $key --> "${b.name}" $b');
      //
      //       var ctListLv = detach(continentLv, continentLv.value.countries)!;
      //       ctListLv.attachedItems.forEach((key, c) {
      //         print('3 -- ctListLv.attachedItems :: $key --> "${c.name}" $c');
      //
      //         for (var j = 0; j < ctListLv.value.length; j++) {
      //           var ctLv = detach(ctListLv, ctListLv.value[j])!;
      //           ctLv.attachedItems.forEach((key, d) {
      //             print('4 -- ctLv.attachedItems :: $key --> "${d.name}" $d');
      //           });
      //         }
      //       });
      //     });
      //   }
      // });
      // print('===========================');
      _timer1 = Timer(const Duration(seconds: 2), () {
        guideStep.value = 1;
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[0]);
        countryLv?.mutate((country) {
          country.cities.add(
            'Khonkaen',
          );
        });
      });

      _timer2 = Timer(const Duration(seconds: 4), () {
        guideStep.value = 2;
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[1])!;
        var citiesLv = detach(countryLv, countryLv.value.cities);
        citiesLv?.mutate((cities) {
          cities.add(
            'Hiroshima',
          );
        });
      });

      _timer3 = Timer(const Duration(seconds: 6), () {
        guideStep.value = 3;
        continentListLv.mutate((continentList) {
          continentList.add(
            Continent(name: 'Europe', countries: [
              Country(name: 'England', cities: ['London', 'Bristol']),
              Country(name: 'Germany', cities: ['Berlin', 'Bavaria']),
            ]),
          );
        });
      });

      _timer4 = Timer(const Duration(seconds: 8), () {
        guideStep.value = 4;
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var ctListLv = detach(continentLv, continentLv.value.countries)!;
        ctListLv.mutate((countries) {
          countries.add(
            Country(name: 'China', cities: ['Beijing', 'Shanghai']),
          );
        });
      });

      _timer5 = Timer(const Duration(seconds: 10), () {
        guideStep.value = 5;
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[1]);
        countryLv?.mutate((country) {
          country.cities.add(
            'Hokkaido',
          );
        });
      });

      _timer6 = Timer(const Duration(seconds: 12), () {
        guideStep.value = 6;
        var continentLv = detach(continentListLv, continentListLv.value[1])!;
        var ctListLv = detach(continentLv, continentLv.value.countries)!;
        ctListLv.mutate((countries) {
          countries.add(
            Country(name: 'Russia', cities: ['Moscow']),
          );
        });
      });

      // Future.delayed(const Duration(seconds: 12), () {
      //   detach(continentListLv, continentListLv.value[1])?.mutate((continent) {
      //     continent.countries.add(
      //       Country(name: 'Russia', cities: ['Moscow']),
      //     );
      //   });
      // });

      _timer7 = Timer(const Duration(seconds: 14), () {
        guideStep.value = 7;
        var continentLv = detach(continentListLv, continentListLv.value[1])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[0])!;
        var citiesLv = detach(countryLv, countryLv.value.cities)!;
        citiesLv.mutate((cities) {
          cities.add(
            'Manchester',
          );
        });
      });

      _timer8 = Timer(const Duration(seconds: 16), () {
        guideStep.value = 8;
        var citiesLv = continentListLv
            .detachedBy((lv) => lv.value[1])!
            .detachedBy((lv) => lv.value.countries)!
            .detachedBy((lv) => lv.value[0])!
            .detachedBy((lv) => lv.value.cities)!;

        citiesLv.mutate((cities) {
          cities.add(
            'Liverpool',
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$for Example'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          $watch(guideStep, build: (_, int step) {
            TextStyle focusOn(bool con) {
              return TextStyle(fontWeight: con ? FontWeight.bold : FontWeight.normal);
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('1. add "Khonkaen" to Country "Thailand"', style: focusOn(step == 1)),
                  Text('2. add "Hiroshima" to Cities of Country "Japan"', style: focusOn(step == 2)),
                  Text('3. add "Europe" to Continents', style: focusOn(step == 3)),
                  Text('4. add "China" to Continent "Asia"', style: focusOn(step == 4)),
                  Text('5. add "Hokkaido" to Country "Japan"', style: focusOn(step == 5)),
                  Text('6. add "Russia" to Continent "Europe"', style: focusOn(step == 6)),
                  Text('7. add "Manchester" to Cities of Country "England"', style: focusOn(step == 7)),
                  Text('8. add "Liverpool" to Cities of Country "England"', style: focusOn(step == 8)),
                ],
              ),
            );
          }),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              'Continents',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          $for(
            continentListLv,
            buildList: (_, items) {
              return Expanded(
                child: Blink.on(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, int i) => items[i].widget,
                  ),
                ),
              );
            },
            buildItem: (_, Continent continent, index1) {
              LiveData<Continent> continentLv = detach(continentListLv, continent)!;
              var countriesLv = detach(continentLv, continentLv.value.countries)!;

              return Column(
                children: [
                  Text(
                    '${index1 + 1} ${continent.name}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  $for(
                    countriesLv,
                    buildList: (_, items2) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: items2.length,
                        itemBuilder: (_, int i) => items2[i].widget,
                      );
                    },
                    buildItem: (_, Country country, index2) {
                      var countriesLv = detach(continentLv, continentLv.value.countries)!;
                      var countryLv = detach(countriesLv, countriesLv.value[index2])!;
                      var citiesLv = detach(countryLv, countryLv.value.cities)!;
                      return Blink.on(
                        child: Row(
                          children: [
                            Text(
                              '${index1 + 1}.${index2 + 1} ${country.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(' has '),
                            $watch(citiesLv, build: (_, List<String> cities) {
                              return Blink.on(
                                child: Text(
                                  cities.join(', '),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                init();
              },
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    continentListLv.close();
    guideStep.close();
    super.dispose();
  }
}
