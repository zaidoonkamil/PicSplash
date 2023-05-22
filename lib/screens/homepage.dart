import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/cubit/cuibit.dart';
import 'package:unsplash/cubit/states.dart';
import 'package:unsplash/widgets/photosgrid.dart';

import '../utils/constant_colore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/iconsbackgrundd.png",
              width: 40,height: 40,
            ),
             SizedBox(width: 5,),
             Text(
              "Pic",
              style: TextStyle(
                color:  Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,

              ),
            ),
            Text(
              "Splash",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) => CounterCubit()
          ..getAwesomeStart(),
        child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return PhotosView(
              images: CounterCubit.get(context).myImageHome,
            );
          },
        ),
      ),
    );
  }
}
