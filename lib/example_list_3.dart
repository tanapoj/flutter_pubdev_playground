import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart';
import 'package:pubdev_playground/flutter_live_data/core.dart';
import 'package:pubdev_playground/ui/components.dart';

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

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    setState(() {
      var initData = <Continent>[
        Continent(name: 'Asia', countries: [
          Country(name: 'Thailand', cities: ['Bangkok', 'Chiangmai']),
          Country(name: 'Japan', cities: ['Tokyo', 'Osaka']),
        ]),
      ];

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

      Future.delayed(const Duration(seconds: 2), () {
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[0]);
        countryLv?.mutate((country) {
          country.cities.add(
            'Khonkaen',
          );
        });
      });

      Future.delayed(const Duration(seconds: 4), () {
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

      Future.delayed(const Duration(seconds: 6), () {
        continentListLv.mutate((continentList) {
          continentList.add(
            Continent(name: 'Europe', countries: [
              Country(name: 'England', cities: ['London', 'Manchester']),
              Country(name: 'Germany', cities: ['Berlin', 'Bavaria']),
            ]),
          );
        });
      });

      Future.delayed(const Duration(seconds: 8), () {
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var ctListLv = detach(continentLv, continentLv.value.countries)!;
        ctListLv.mutate((countries) {
          countries.add(
            Country(name: 'China', cities: ['Beijing', 'Shanghai']),
          );
        });
      });

      Future.delayed(const Duration(seconds: 10), () {
        var continentLv = detach(continentListLv, continentListLv.value[0])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[1]);
        countryLv?.mutate((country) {
          country.cities.add(
            'Hokkaido',
          );
        });
      });

      Future.delayed(const Duration(seconds: 12), () {
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

      Future.delayed(const Duration(seconds: 14), () {
        var continentLv = detach(continentListLv, continentListLv.value[1])!;
        var countryListLv = detach(continentLv, continentLv.value.countries)!;
        var countryLv = detach(countryListLv, countryListLv.value[0])!;
        var citiesLv = detach(countryLv, countryLv.value.cities);
        citiesLv?.mutate((cities) {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Text('1. add "Khonkaen" to Country "Thailand"'),
                Text('2. add "Hiroshima" to Cities of Country "Japan"'),
                Text('3. add "Europe" to Continents'),
                Text('4. add "China" to Continent "Asia"'),
                Text('5. add "Hokkaido" to Country "Japan"'),
                Text('6. add "Russia" to Continent "Europe"'),
                Text('7. add "Liverpool" to Cities of Country "England"'),
              ],
            ),
          ),
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
            buildList: (_, widgets) {
              return Expanded(
                child: Blink.on(
                  child: ListView.builder(
                    itemCount: widgets.length,
                    itemBuilder: (_, int i) => widgets[i],
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
                    buildList: (_, widgets2) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: widgets2.length,
                        itemBuilder: (_, int i) => widgets2[i],
                      );
                    },
                    buildItem: (_, Country country, index2) {
                      var countriesLv = detach(continentLv, continentLv.value.countries)!;
                      var countryLv = detach(countriesLv, countriesLv.value[index2])!;
                      var citiesLv = detach(countryLv, countryLv.value.cities);
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
                            if (citiesLv != null)
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
}
