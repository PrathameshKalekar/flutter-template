import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/core/theme/app_theme.dart';
import 'package:flutter_template/core/utils/constants.dart';
import 'package:flutter_template/core/utils/helpers.dart';
import 'package:flutter_template/generated/assets.dart';

showImagePickerSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: white,
    isScrollControlled: true,
    builder: (context) => ImagePickerSheet(),
  );
}

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ImagePickerItems> items = [
      ImagePickerItems(
        title: "Camera",
        image: Assets.svgsCamera,
        onTap: () {},
      ),
      ImagePickerItems(
        title: "Gallery",
        image: Assets.svgsGallery,
        onTap: () {},
      ),
    ];
    return Container(
      width: Helper(context).size.width,
      padding: Constants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Text(
            "Select Image",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 90,
            ),
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: item.onTap,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          item.image,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.title,
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class ImagePickerItems {
  final String title;
  final String image;
  final Function() onTap;

  ImagePickerItems({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
