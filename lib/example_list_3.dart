import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart';
import 'package:pubdev_playground/flutter_live_data/core.dart';

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
    return 'ทวีป{name: $name, countries: $countries}';
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
    return 'ประเทศ{name: $name, cities: $cities}';
  }
}

T fn<T>(T Function() builder) => builder();

class _ExampleList3PageState extends State<ExampleList3Page> {
  LiveData<List<Continent>> continents = LiveData(<Continent>[
    Continent(name: 'Asia', countries: [
      Country(name: 'Thailand', cities: ['Bangkok', 'Chiangmai']),
      Country(name: 'Japan', cities: ['Tokyo', 'Osaka']),
    ]),
    Continent(name: 'Europe', countries: [
      Country(name: 'England', cities: ['London', 'Manchester']),
      Country(name: 'Germany', cities: ['Berlin', 'Bavaria']),
    ]),
  ]).apply(eachItemsInListAsLiveData(then: (LiveData<Continent> continentLv) {
    attach(
      continentLv,
      continentLv.value.countries,
    ).apply(eachItemsInListAsLiveData());
  }));

  @override
  Widget build(BuildContext context) {
    List<Widget> x = continents.value[0].countries
        .asMap()
        .map((index, value) => MapEntry(
        index,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$value'),
        )))
        .values
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('\$for Example'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
            continents,
            buildList: (_, widgets) {
              return Expanded(
                child: ListView.builder(
                  itemCount: widgets.length,
                  itemBuilder: (_, int i) => widgets[i],
                ),
              );
            },
            buildItem: (_, Continent continent, index1) {
              return Column(
                children: [
                  Text(
                    '${index1 + 1} ${continent.name}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: continent.countries
                        .asMap()
                        .map((index2, country) => MapEntry(
                        index2,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${index1 + 1}.${index2 + 1} ${country.name} has ${country.cities}'),
                        )))
                        .values
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
