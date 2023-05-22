import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/cubit/cuibit.dart';
import 'package:unsplash/cubit/states.dart';
import 'package:unsplash/utils/constant_colore.dart';
import 'package:unsplash/widgets/photosgrid.dart';
import 'package:unsplash/widgets/text_form_field.dart';

class SearchPag extends StatefulWidget {
  SearchPag({Key? key}) : super(key: key);

  @override
  State<SearchPag> createState() => _SearchPagState();
}

class _SearchPagState extends State<SearchPag>
  with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit()..getMyImages('moon'),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: CustomFormTextField(
                          onChanged: (String? value) {
                        CounterCubit.get(context).getMyImages(value!);
                        },
                        )),
                      ],
                    ),
                    state is SplashSearchLoadingDataState?
                    Expanded(
                        child: Center(
                        child: CircularProgressIndicator(color: primaryColor,))) :
                    Expanded(
                      child: PhotosView(
                              images: CounterCubit.get(context).myImageSearch,
                          isNormalGrid: true
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
