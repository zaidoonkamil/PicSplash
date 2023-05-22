import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/cubit/states.dart';
import 'package:unsplash/models/imagemodel.dart';
import 'package:unsplash/providers/get_images.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  List<ImageModel> myImageSearch = [];
  List<ImageModel> myImageHome = [];

  void getMyImages(String value) async {
    emit(SplashSearchLoadingDataState());
    await GetImages().searchImage(query: value).then((value) {
      myImageSearch = value;
      emit(SplashSearchGetDataState());
    }).catchError((onError) {
      emit(SplashSearchErrorDataState(onError.toString()));
    });
  }

  void getAwesomeStart() async {
    emit( SplashAwesomeStartLoadingState());
    await GetImages().getCollectionImages('PzbQpFC55ic', 1, 20).then((value) =>{
        myImageHome=value,
       emit(SplashHomeGetDataState()),
        getMyImagesHome(),
     }).catchError((onError){
       emit(SplashAwesomeStartErrorState(onError.toString()));
     });
  }

  void getMyImagesHome() async {
   emit( SplashHomeLoadingDataState());
     await GetImages().getRandomImages().then((value) =>{
     for (var image in value) {
         myImageHome.add(image)
  },
       emit(SplashAwesomeStartState()),
     }).catchError((onError){
       emit(SplashHomeErrorDataState(onError.toString()));
     });
  }

}
