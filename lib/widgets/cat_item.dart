import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import 'package:sikucing/theme/color.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/favorite_provider.dart';
import 'custom_image.dart';

class CatItem extends StatelessWidget {
  const CatItem({
    Key? key,
    required this.data,
    this.width = 350,
    this.height = 400,
    this.radius = 40,
    this.onTap,
    this.onFavoriteTap,
  }) : super(key: key);

  final data;
  final double width;
  final double height;
  final double radius;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: [
            _buildImage(),
            Positioned(
              bottom: 0,
              child: _buildInfoGlass(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoGlass() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(25),
      blur: 10,
      opacity: 0.15,
      child: Container(
        width: width,
        height: 140,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo(),
            SizedBox(
              height: 5,
            ),
            _buildLocation(),
            SizedBox(
              height: 15,
            ),
            _buildAttributes(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Text(
      data.city,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColor.glassLabelColor,
        fontSize: 13,
      ),
    );
  }

  Widget _buildInfo() {
    return Row(
      children: [
        Expanded(
          child: Text(
            data.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.glassTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: onFavoriteTap,
          child: Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
              return Icon(
                favoriteProvider.getFavoriteCats().contains(data.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
                size: 20,
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            sendWhatsApp(
                "6285156242860", "I want to adopt this cat ${data.name}");
          },
          icon: Image.asset(
            'assets/home/whatsapp-50.png',
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        CustomImage(
          data.avatar,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius),
            bottom: Radius.zero,
          ),
          isShadow: false,
          width: width,
          height: 350,
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Share.share('Check out this cat: ${data.name}');
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.shadowColor.withOpacity(0.4),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.share,
                color: AppColor.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttributes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getAttribute(
          Icons.transgender,
          data.genders,
        ),
        _getAttribute(
          Icons.color_lens_outlined,
          data.colors,
        ),
        _getAttribute(
          Icons.query_builder,
          data.age,
        ),
      ],
    );
  }

  Widget _getAttribute(IconData icon, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColor.textColor, fontSize: 13),
        ),
      ],
    );
  }
}

void sendWhatsApp(String phoneNumber, String text) {
  String encodedText = Uri.encodeComponent(text);
  String url = "whatsapp://send?phone=$phoneNumber&text=$encodedText";
  launchUrl(Uri.parse(url));
}
