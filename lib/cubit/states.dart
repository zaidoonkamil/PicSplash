abstract class CounterStates{}

class CounterInitialState extends CounterStates {}

class SplashSearchGetDataState  extends CounterStates {}

class SplashSearchLoadingDataState  extends CounterStates {}

class SplashSearchErrorDataState  extends CounterStates {
  SplashSearchErrorDataState(String counter);
}

class SplashHomeGetDataState  extends CounterStates {}

class SplashHomeLoadingDataState  extends CounterStates {}

class SplashHomeErrorDataState  extends CounterStates {
  SplashHomeErrorDataState(String counter);
}

class SplashAwesomeStartState  extends CounterStates {}

class SplashAwesomeStartLoadingState  extends CounterStates {}

class SplashAwesomeStartErrorState  extends CounterStates {
  SplashAwesomeStartErrorState(String counter);
}

