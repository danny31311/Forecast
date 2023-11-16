import 'package:bloc/bloc.dart';
import 'package:weather_application_2/features/data/repository/weather_repository.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc/weather_event.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherLoadingState()) {
    on<WeatherEvent>((event, emit) async { // асинхронная функция
      if (event is WeatherLoadEvent) { // старт с ивента загрузки
        emit(WeatherLoadingState()); // говорю об изменении стейта
    
      await weatherRepository.fetchWeather(event.cityName).then((weather) { // жду ответа от апи, и затем выполняю then 
        emit(WeatherLoadedState(weather)); // меняю состояние 
      }).catchError((error) {
        emit(WeatherErrorState(error.toString()));
      }); 
      }
    });
  }
}