import 'package:equatable/equatable.dart';
import 'package:weather_application_2/features/data/models/weather_model.dart';

abstract class WeatherDetailState extends Equatable {
  const WeatherDetailState();
  
  @override
  List<Object> get props => [];
}

class WeatherDetailLoadingState extends WeatherDetailState { //описываю отдаваемые стейты

  @override
  List<Object> get props => [];
}

class WeatherDetailLoadedState extends WeatherDetailState {
  final WeatherModel weatherModel;

  const WeatherDetailLoadedState(this.weatherModel);

  @override
  List<Object> get props => [weatherModel];
}

class WeatherDetailErrorState extends WeatherDetailState {
  final String message;
  
  const WeatherDetailErrorState(this.message);

   @override
  List<Object> get props => [message];
}
