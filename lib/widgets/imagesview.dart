import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unsplash/models/imagemodel.dart';
import 'package:unsplash/utils/pref_manager.dart';

class ImagesView extends StatefulWidget {
  const ImagesView({Key? key, required this.images}) : super(key: key);

  final ImageModel images;

  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  bool isLiked = false;

  @override
  void initState() {
    print('------------------------------');

    check();
    FlutterDownloader.registerCallback(DownloadCallback.callback);
    super.initState();
  }

  PrefManager prefs = PrefManager();

  check() async {
    bool checkLike = await prefs.isFavorite(widget.images.urls.regular);
    setState(() {
      isLiked = checkLike;
    });
  }

  downloadImage() async {
    final status = await Permission.storage.request();
    var dir = Directory("/sdcard/UnSplash");
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    if (status.isGranted) {
      await FlutterDownloader.enqueue(
        url: widget.images.urls.full,
        savedDir: dir.path,
        fileName: 'image_${widget.images.id}.jpg',
      );
    } else {
      await Permission.storage.request();
    }
  }

  void setWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Set wallpaper',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onTap: () {
                  setWallpaper(1);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Setting Wallpaper')));
                },
              ),
              ListTile(
                title: const Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onTap: () {
                  setWallpaper(2);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Setting Wallpaper')));
                },
              ),
              ListTile(
                title: const Text(
                  'Both',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                onTap: () {
                  setWallpaper(3);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Setting Wallpaper'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static const platform = MethodChannel('dev.ayushd70.unsplash/wallpaper');

  Future<void> setWallpaper(int type) async {
    var file =
        await DefaultCacheManager().getSingleFile(widget.images.urls.full);
    try {
      await platform.invokeMethod('setWallpaper', [file.path, type]);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallpaper set successfully')));
  }

  double angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Hero(
            tag: widget.images.id,
            transitionOnUserGestures: true,
            child: Stack(children: [
              Container(
                  constraints: const BoxConstraints.expand(),
                  child: InteractiveViewer(
                    onInteractionUpdate: (ScaleUpdateDetails details) {
                      setState(() {
                        angle = details.rotation;
                      });
                    },
                    onInteractionEnd: (ScaleEndDetails details) {
                      setState(() {
                        angle = 0.0;
                      });
                    },
                    child: Transform.rotate(
                      angle: angle,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: widget.images.urls.regular,
                        placeholder: (context, url) => Scaffold(
                            body: Center(
                                child: Text(
                          'Loading Image...',
                          style:
                              TextStyle(color: Theme.of(context).buttonColor),
                        ))),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/iconsbackgrundd.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    height: 60,
                    width: 200,
                    child: Material(
                      color: Theme.of(context).cardColor,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(35),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                tooltip: "Download",
                                onPressed: downloadImage,
                                icon: Icon(
                                  Icons.download_sharp,
                                  color: Theme.of(context).buttonColor,
                                )),
                            IconButton(
                                tooltip: "Set as Wallpaper",
                                onPressed: setWallpaperDialog,
                                icon: Icon(
                                  Icons.wallpaper,
                                  color: Theme.of(context).buttonColor,
                                )),
                            IconButton(
                                tooltip: "Favorite",
                                onPressed: () {
                                  prefs.toggleFavorite(
                                      widget.images.urls.regular);
                                  check();
                                },
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked
                                      ? Colors.red
                                      : Theme.of(context).buttonColor,
                                )),
                          ]),
                    ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}

class DownloadCallback {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    if (kDebugMode) {
      print(progress);
    }
  }
}
