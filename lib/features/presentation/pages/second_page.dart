import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc/weather_bloc.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc/weather_state.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc_three/weather_deatil_bloc.dart';
import 'package:weather_application_2/features/presentation/blocs/bloc_three/weather_deatil_event.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final cityName = ModalRoute.of(context)?.settings.arguments.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondPage'),
        centerTitle: true,
        leading: IconButton( //показываю иконку слева AppBar
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, '/home'),
        ),
        actions: <Widget>[ //показываю иконку справа AppBar
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              context.read<WeatherDetailBloc>().add(WeatherDetailLoadEvent(cityName: cityName));
              // context.select((WeatherBloc bloc) => bloc.state.weatherModel);
              Navigator.pushNamed(context, '/third');
            },
          )
        ],
      ),
      body: BlocListener<WeatherBloc, WeatherState>( // вешаю слушателя, который вызывается только на изменение state
        listener: ((context, state) {
           if (state is WeatherErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar( // снакбар по доке через блокЛисенер. В билдер блока его нельзя выводить, да и он там кидает ошибку.
                content: const Text('Ошибка получения данных'),
                backgroundColor: Colors.grey,
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction( // дает позможность взаимодействия с пользователем
                  label: 'Назад',
                  disabledTextColor: Colors.white,
                  textColor: Colors.orange,
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              )
            );
          }
        }),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) { // вывожу стейт загружаемых данных (индикатор в центре)
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoadedState) { // вывожу главный стейт - данные получены
              return Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [ // все чилдрены показываю колонкой
                  Text(
                    state.weatherModel.city?.name.toString() ?? '', // наллПоинтер ошибки - большая проблема с красным экраном и падением всего приложения, если ставить бэнг оператор. Потому кидаю проверку везде
                    style:  const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 50), // отступы
                  Row( // вывожу строкой иконка-данные
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/temp.png',
                        height: 80,
                        width: 80,
                        ),
                      Text(
                        state.weatherModel.list?[0].main?.temp.toString() ?? '', //конкатинация не срабатывает, требует бэнг оператор. Но тогда без обработки могут быть ошибки с null
                        style: const TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/humidity.png",
                        height: 80,
                        width: 80,
                        ),
                      Text(
                        state.weatherModel.list?[0].main?.humidity.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/wind.png", //картинки показываю просто через asset
                        height: 80,
                        width: 80,
                      ),
                      Text(
                        state.weatherModel.list?[0].wind?.speed.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is WeatherErrorState) { // вывожу стейт ошибки (ошибка в центре экрана)
                return const Center(
                  child: Text('Ошибка получения данных')
              );
            } return const CircularProgressIndicator(); 
          }
        ),
      )
    );
  }
}



