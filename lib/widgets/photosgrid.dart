import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash/models/imagemodel.dart';
import 'package:unsplash/widgets/imagesview.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosView extends StatelessWidget {
  const PhotosView({
    Key? key,
    required this.images,
     this.scrollController,
    this.isNormalGrid = false,
  }) : super(key: key);

  final List<ImageModel> images;
  final ScrollController? scrollController;
  final bool isNormalGrid;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
        controller: scrollController,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: images.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImagesView(
                          images: images[index]))
              );
            },
            child: Hero(
              tag: images[index].id,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: isNormalGrid
                        ? images[index].urls.regular
                        : images[index].urls.small,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          if (isNormalGrid) {
            return const StaggeredTile.count(1, 1.8);
          } else {
            return StaggeredTile.count(1, index.isEven ? 1.0 : 1.8);
          }
        });
  }
}
