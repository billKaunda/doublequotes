import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'settings_menu_state.dart';
part 'settings_menu_event.dart';

class SettingsMenuBloc extends Bloc<SettingsMenuEvent, SettingsMenuState> {
  SettingsMenuBloc({
    required this.userRepository,
    required this.quoteRepository,
  }) : super(
          const SettingsMenuInProgress(),
        ) {
    _registerEventHandler();
    
  }

  final UserRepository userRepository;
  final QuoteRepository quoteRepository;

  void _registerEventHandler() {
    on<SettingsMenuStarted>(
      (_, emitter) async {
        await emitter.onEach(
          Rx.combineLatest4<UserCredentials?, ThemeSourcePreference,
              DarkModePreference, LanguagePreference, SettingsMenuLoaded>(
            userRepository.createUserSession(),
            userRepository.getThemeSourcePreference(),
            userRepository.getDarkModePreference(),
            userRepository.getLanguagePreference(),
            (user, themeSourcePreference, darkModePreference,
                    languagePreference) =>
                SettingsMenuLoaded(
              themeSourcePreference: themeSourcePreference,
              darkModePreference: darkModePreference,
              languagePreference: languagePreference,
              username: user!.username,
            ),
          ),
          onData: emitter.call,
        );
      },
      transformer: (events, mapper) => events.flatMap(mapper),
    );

    on<SettingsMenuSignedOut>((_, emitter) async {
      final currentState = state as SettingsMenuLoaded;
      final newState = currentState.copyWith(
        isSignOutInProgress: true,
      );

      emitter(newState);

      await userRepository.signOut();
      await quoteRepository.clearCache();
    });

    on<SettingsMenuThemeSourceChanged>((event, _) async {
      await userRepository.upsertThemeSourcePreference(
        event.themeSourcePreference,
      );

      add(const SettingsMenuStarted());
    });

    on<SettingsMenuDarkModePrefChanged>((event, _) async {
      await userRepository.upsertDarkModePreference(
        event.darkModePreference,
      );

      add(const SettingsMenuStarted());
    });

    on<SettingsMenuLanguagePrefChanged>((event, _) async {
      await userRepository.upsertLanguagePreference(
        event.languagePreference,
      );

      add(const SettingsMenuStarted());
    });
  }
}
