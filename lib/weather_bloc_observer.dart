import 'package:flutter_bloc/flutter_bloc.dart';

class BlocsObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
    // смотрю изменения по стейтам. Проще понять что сейчас происходит и ошибки отлавливать 
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Вывожу ошибки. Можно ловить ошибки блоков и логировать куда-нибудь в аналитику

    print(bloc);
    print(error);
  }
}