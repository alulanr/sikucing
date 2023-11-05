import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:sikucing/models/m_cat.dart';
import 'package:sikucing/services/cat_service.dart';
import 'package:sikucing/theme/color.dart';
import 'package:sikucing/widgets/category_item.dart';
import 'package:sikucing/widgets/cat_item.dart';
import '../../utils/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCity;

  Stream<List<CatModel>> getList(String? city) async* {
    List<CatModel> data = await CatService().listData();

    if (city != null && city.isNotEmpty) {
      data = data.where((cat) => cat.city == city).toList();
    }

    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: _buildAppBar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              DropdownSearch<String>(
                items: cities.map((city) => city["city"].toString()).toList(),
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(color: AppColor.primary),
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(
                      Icons.place_outlined,
                      color: AppColor.primary,
                      size: 20,
                    ),
                    labelStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
                onChanged: (city) {
                  setState(() {
                    if (city == "All") {
                      selectedCity = null;
                    } else {
                      selectedCity = city;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 25,
          ),
          _buildCategories(),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text(
              "Choice Your Adopt",
              style: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          _buildCats(),
        ]),
      ),
    );
  }

  int _selectedCategory = 0;

  _buildCategories() {
    List<Widget> lists = List.generate(
      categories.length,
      (index) => CategoryItem(
        data: categories[index],
        selected: index == _selectedCategory,
        onTap: () {
          setState(() {
            _selectedCategory = index;
          });
        },
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  Widget _buildCats() {
    return StreamBuilder<List<CatModel>>(
      stream: getList(selectedCity),
      builder: (context, AsyncSnapshot<List<CatModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final catsData = snapshot.data;

          if (catsData!.isEmpty) {
            return Center(child: Text('No cats available.'));
          }

          List<CatModel> filteredCats;

          if (_selectedCategory == 0) {
            filteredCats = catsData;
          } else {
            final selectedCategory =
                categories[_selectedCategory - 0]["name"].toLowerCase();
            filteredCats = catsData
                .where((cat) =>
                    cat.categories.toLowerCase().contains(selectedCategory))
                .toList();
          }

          if (filteredCats.isEmpty) {
            return Center(child: Text('No cats available in this category.'));
          }

          double cardHeight = 400;
          return CarouselSlider.builder(
            options: CarouselOptions(
              height: cardHeight,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: 1,
            ),
            itemCount: filteredCats.length,
            itemBuilder: (context, index, realIndex) {
              return CatItem(data: filteredCats[index]);
            },
          );
        } else {
          return Text('No data available.');
        }
      },
    );
  }
}
