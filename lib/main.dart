import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application_2/features/data/repository/weather_repository.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc/weather_bloc.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc_three/weather_deatil_bloc.dart';
import 'package:weather_application_2/weather_bloc_observer.dart';
import 'package:weather_application_2/features/presentation/pages/home_page.dart';
import 'package:weather_application_2/features/presentation/pages/second_page.dart';
import 'package:weather_application_2/features/presentation/pages/third_page.dart';
import 'package:weather_application_2/features/presentation/theme/colors/colors.dart';

void main() async { 
  BlocOverrides.runZoned( 
    () => runApp(const MyApp()),
    blocObserver: BlocsObserver(), //блокОбсервер инициализируется в мейне. Использую для отлова ошибок и показа текущего стейта
  ); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider( //регистрирую репозиторий
      create: (context) => WeatherRepo(),
      child: MultiBlocProvider( //МультиПровайдерБлок, чтоб прокинуть два своих блока
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(context.read<WeatherRepo>()), 
          ),
          BlocProvider<WeatherDetailBloc>(
            create: (context) => WeatherDetailBloc(context.read<WeatherRepo>()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: AppColor.primaryColor,
          ),
          debugShowCheckedModeBanner: false, //снимаю Debug mode в правом верхнем углу экрана
          home: const HomePage(),
          
          initialRoute: '/home', //именованные роуты по доке для навигации между экранами
          routes: {
            '/home': (context) => const HomePage(),
            '/second': (context) => const SecondPage(),
            '/third': (context) => const ThirdPage(),
          },
        ),
      )
    );
  }
}

