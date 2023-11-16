import 'package:bloc/bloc.dart';
import 'package:weather_application_2/features/data/models/weather_model.dart';
import 'package:weather_application_2/features/data/repository/weather_repository.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc_three/weather_deatil_event.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc_three/weather_deatil_state.dart';

// на новый экран новый блок
class WeatherDetailBloc extends Bloc<WeatherDetailEvent, WeatherDetailState>{
  final WeatherRepository weatherRepository;

  WeatherDetailBloc(this.weatherRepository) : super(WeatherDetailLoadingState()) {
    on<WeatherDetailEvent>((event, emit) async { // асинхронная функция
      if (event is WeatherDetailLoadEvent) { // старт с ивента загрузки
        emit(WeatherDetailLoadingState()); // говорю об изменении стейта
    
      await weatherRepository.fetchWeather(event.cityName).then((weather) { // жду ответа от апи, и затем выполняю then 
        
         //меняю расположение объектов в листе
        _sortWeather(weather);

        emit(WeatherDetailLoadedState(weather)); // меняю состояние 
      }).catchError((error) {
        emit(WeatherDetailErrorState(error.toString()));
      }); 
      }
    });
  }

  // main -> temp
  void _sortWeather(WeatherModel weatherModel) {
    weatherModel.list!.sort((a, b) => a.main!.temp!.compareTo(b.main!.temp!));
  }
}

