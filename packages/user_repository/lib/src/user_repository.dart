import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:domain_models/domain_models.dart';

import 'mappers/mappers.dart';
import 'user_local_storage.dart';
import 'user_secure_storage.dart';

class UserRepository {
  UserRepository({
    required ThemeKeyValueStorage themeModeStorage,
    required TypeaheadKeyValueStorage typeaheadStorage,
    required this.remoteSessionApi,
    required this.remoteUsersApi,
    required this.remoteTypeaheadApi,
    @visibleForTesting UserLocalStorage? localStorage,
    @visibleForTesting UserSecureStorage? secureStorage,
  })  : _localStorage = localStorage ??
            UserLocalStorage(
              themeModeStorage: themeModeStorage,
              typeaheadStorage: typeaheadStorage,
            ),
        _secureStorage = const UserSecureStorage();

  final SessionApiSection remoteSessionApi;
  final UsersApiSection remoteUsersApi;
  final TypeaheadApiSection remoteTypeaheadApi;
  final UserLocalStorage _localStorage;
  final UserSecureStorage _secureStorage;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  final BehaviorSubject<ThemeModePreference> _themeModePreferenceSubject =
      BehaviorSubject();

  Future<void> upsertThemeModePreference(ThemeModePreference theme) async {
    await _localStorage.upsertThemeModePreference(theme.toCacheModel());
    _themeModePreferenceSubject.add(theme);
  }

  Stream<ThemeModePreference> getThemeModePreference() async* {
    if (!_themeModePreferenceSubject.hasValue) {
      final storedPreference = await _localStorage.getThemeModePreference();
      //TODO add double nullcheck to _themeModePreferenceSubject of this method
      _themeModePreferenceSubject.add(storedPreference!.toDomainModel());
    }

    yield* _themeModePreferenceSubject.stream;
  }

  Future<Typeahead?> getTypeahead() async {
    final cacheTypeahead = await _localStorage.getTypeahead();

    if (cacheTypeahead != null) {
      return cacheTypeahead.toDomainModel();
    }

    try {
      final remoteTypeahead = await remoteTypeaheadApi.getTypeahead();
      await _localStorage.upsertTypeahead(
        remoteTypeahead.toCacheModel(),
      );

      return remoteTypeahead.toDomainModel();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String username, String password) async {
    try {
      /*
      Call the 'sign-in' endpoint on the server using the remoteApi
      property. If successful, a UserRM object is returned and 
      assigned to the apiUser variable. UserRM class holds the 
      recently signed-in user's token, email, and username.
      */
      final sessionApiUser = await remoteSessionApi.signIn(
        username,
        password,
      );

      await _secureStorage.upsertUserInfo(
        username: sessionApiUser.userCredentials.username!,
        email: sessionApiUser.userCredentials.email!,
        token: sessionApiUser.userToken,
      );

      // Use a mapper function, toDomainModel(), to convert the
      //sessionApiUser object from UserRM type to the User type.
      final domainUser = sessionApiUser.toDomainModel();

      //Replaced- or added, if this is the first sign-in- a new value
      // to the BehaviourSubject.
      _userSubject.add(domainUser);
    } catch (e) {
      switch (e) {
        /*
      Capture any FavQsExceptions and convert it to an equivalent 
      domain_models exception since the former is only known by packages 
      importing fav_qs_api_v2 internal package, which isn't the case
      for this UserRepository class. The latter is from domain_models
      package, and therefore known to all features, making it possible
      for them to handle the exception properly.
      */
        case InvalidUsernameOrPasswordFavQsException():
          throw InvalidUsernameOrPassword();
        case UsernameInactiveFavQsException():
          throw UsernameInactive();
        case UsernameOrPasswordIsMissingFavQsException():
          throw UsernameOrPasswordIsMissing();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await remoteSessionApi.signOut();
      await _secureStorage.deleteUserInfo();
      _userSubject.add(null);
    } on UserSessionNotFoundFavQsException catch (_) {
      throw UserSessionNotFound();
    }
  }

  //Expose the user BehaviourSubject
  Stream<User?> getUser() async* {
    if (!_userSubject.hasValue) {
      final userInfo = await Future.wait([
        _secureStorage.getEmail(),
        _secureStorage.getUsername(),
      ]);

      final email = userInfo[0];
      final username = userInfo[1];

      if (email != null && username != null) {
        _userSubject.add(User(username: username, email: email));
      } else {
        _userSubject.add(null);
      }

      yield* _userSubject.stream;
    }
  }

  //Provide the userToken
  Future<String?> getToken() async {
    return _secureStorage.getToken();
  }

  Future<void> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      final userToken = await remoteUsersApi.signUp(username, email, password);

      await _secureStorage.upsertUserInfo(
          username: username, email: email, token: userToken);

      _userSubject.add(
        User(username: username, email: email),
      );
    } catch (e) {
      switch (e) {
        case UserSessionAlreadyPresentFavQsException():
          throw UserSessionAlreadyPresent();
        case EmailAlreadyRegisteredFavQsException():
          throw EmailAlreadyRegistered();
        case UsernameAlreadyTakenFavQsException():
          throw UsernameAlreadyTaken();
        case InvalidPasswordFavQsException():
          throw InvalidPassword();
        case PicNotFoundFavQsException():
          throw PicNotFound();
        case ProfanityFilterToggleErrorFavQsException():
          throw ProfanityFilterToggleError();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<void> updateUser({
    String? username,
    String? email,
    String? newPassword,
    String? twitterUsername,
    String? facebookUsername,
    String? pic,
    bool? enableProfanityFilter,
  }) async {
    try {
      await remoteUsersApi.updateUser(
        username: username,
        email: email,
        password: newPassword,
        twitterUsername: twitterUsername,
        facebookUsername: facebookUsername,
        pic: pic,
        enableProfanityFilter: enableProfanityFilter,
      );

      await _secureStorage.upsertUserInfo(
        username: username!,
        email: email!,
        password: newPassword,
        twitterUsername: twitterUsername,
        facebookUsername: facebookUsername,
        pic: pic,
        enableProfanityFilter: enableProfanityFilter,
      );

      _userSubject.add(User(
        username: username,
        email: email,
        password: newPassword,
        twitterUsername: twitterUsername,
        facebookUsername: facebookUsername,
        pic: pic,
        enableProfanityFilter: enableProfanityFilter,
      ));
    } catch (e) {
      switch (e) {
        case UserSessionAlreadyPresentFavQsException():
          throw UserSessionAlreadyPresent();
        case EmailAlreadyRegisteredFavQsException():
          throw EmailAlreadyRegistered();
        case UsernameAlreadyTakenFavQsException():
          throw UsernameAlreadyTaken();
        case InvalidPasswordFavQsException():
          throw InvalidPassword();
        case PicNotFoundFavQsException():
          throw PicNotFound();
        case ProfanityFilterToggleErrorFavQsException():
          throw ProfanityFilterToggleError();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<void> forgotPasswordRequest(String email) async {
    try {
      await remoteUsersApi.forgotPasswordRequest(email);
    } on UserNotFoundFavQsException catch (_) {
      throw UserNotFound();
    }
  }

  //TODO see how to implement resetPassword
}

/*
BehaviourSubject class, from RxDart package, is a class that:
  --Holds a value, whose type is specified between the angle
    brackets <>.
  --Provides a Stream property that you can listen for any  
    changes to that value. When a given code starts to listen 
    to BehaviourSubject's stream, it immediately gets the latest
    value on that property-assuming that one has already been added.

This class is one of the most concise ways of managing app state.
*/
