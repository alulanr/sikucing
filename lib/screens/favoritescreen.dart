import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/m_cat.dart';
import '../provider/favorite_provider.dart';
import '../widgets/cat_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<CatModel> catData = [];

  FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteCats =
        Provider.of<FavoriteProvider>(context).getFavoriteCats();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: favoriteCats.length,
      itemBuilder: (context, index) {
        final catId = favoriteCats.elementAt(index);
        final cat = catData.firstWhere((cat) => cat.id == catId);
        return CatItem(
          data: cat,
          onFavoriteTap: () {
            Provider.of<FavoriteProvider>(context, listen: false)
                .toggleFavorite(catId);
          },
        );
      },
    );
  }
}
