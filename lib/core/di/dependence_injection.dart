import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../route/app_router.dart';
import '../../route/common_route_guard.dart';
import '../local_storage/secure_storage.dart';
import '../local_storage/shared_prefs.dart';


final GetIt getIt = GetIt.instance;

Future<void> registerCommonDependencies() async {
  getIt.registerSingletonAsync(() => SharedPrefs().init());
  getIt.registerSingleton<SecureStorage>(SecureStorage());
  // getIt.registerSingleton<EventBus>(EventBus());
}

Future<void> registerDependencies() async {
  // Add inject dependency
  // getIt.registerSingleton(BuildConfig(environment));
  // getIt.registerSingleton(Dio());
  // getIt.registerSingleton(XMPPClient());
  // getIt.registerSingleton(DioClient(
  //   getIt<Dio>(),
  //   getIt<BuildConfig>(),
  // ));
  // getIt.registerLazySingleton<DialogHelper>(() => DialogHelperImpl());
  getIt.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>());
  getIt.registerSingleton<CommonRouteGuard>(CommonRouteGuard());
  // getIt.registerSingleton<AppRouter>(
  //   AppRouter(
  //     getIt<GlobalKey<NavigatorState>>(),
  //     getIt<CommonRouteGuard>(),
  //   ),
  // );
  _registerRepositories();
  _registerBlocs();
}

void _registerRepositories() {
  // getIt.registerLazySingleton<IAuthenticationRepository>(
  //   () => AuthenticationRepositoryImpl(getIt<DioClient>(), getIt<XMPPClient>()),
  // );
  // getIt.registerLazySingleton<UserRepository>(
  //   () => UserRepositoryImpl(getIt<DioClient>()),
  // );
  // getIt.registerLazySingleton<IDocumentRepository>(
  //   () => DocumentRepositoryImpl(getIt<DioClient>()),
  // );
  // getIt.registerLazySingleton<IStaffRepository>(
  //   () => StaffRepositoryImpl(getIt<DioClient>()),
  // );
  // getIt.registerLazySingleton<ISuggestionRepository>(
  //   () => SuggestionRepositoryImpl(getIt<DioClient>()),
  // );
  // getIt.registerLazySingleton<NotificationRepository>(
  //   () => NotificationRepositoryImpl(getIt<DioClient>()),
  // );
  // getIt.registerLazySingleton<ChatRepository>(
  //   () => ChatRepositoryImpl(getIt<DioClient>(), getIt<XMPPClient>()),
  // );
}

void _registerBlocs() {
  // getIt.registerFactory(
  //   () => ThemeBloc(),
  // );
  // getIt.registerFactory(
  //   () => SplashBloc(getIt<IAuthenticationRepository>()),
  // );
  // getIt.registerFactory(
  //   () => UpdaterBloc(
  //     getIt<UserRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => AuthenticationBloc(
  //     getIt<IAuthenticationRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ForgetPasswordBloc(
  //     getIt<IAuthenticationRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => SessionBloc(),
  // );
  // getIt.registerFactory(
  //   () => LocaleBloc(
  //     getIt<UserRepository>(),
  //   ),
  // );
  // getIt.registerLazySingleton(
  //   () => DocumentTypeBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => HomeBloc(),
  // );
  // getIt.registerFactory(
  //   () => SearchBloc(),
  // );
  // getIt.registerFactory(
  //   () => DocumentDetailBloc(),
  // );
  // getIt.registerFactory(
  //   () => TabBloc(),
  // );
  // getIt.registerFactory(
  //   () => UserBloc(
  //     getIt<UserRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => HeaderSliderBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DashboardRealmBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => MediaBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => CountDownBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DocumentLatestBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => SliderEventBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DocumentBusinessBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DocumentEventBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ChangePasswordBloc(),
  // );
  // getIt.registerFactory(
  //   () => DocumentNotificationBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DocumentOutstandingBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DocumentFilterBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DigitalAlbumBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => CommonBottomSheetBloc(),
  // );
  // getIt.registerFactory(
  //   () => CommentTextFieldBloc(),
  // );
  // getIt.registerFactory(
  //   () => PhonebookBloc(),
  // );
  // getIt.registerFactory(
  //   () => DocumentFavoriteBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => SuggestionBloc(
  //     getIt<IDocumentRepository>(),
  //     getIt<ISuggestionRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DigitalVideoBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => SendFeedbackBloc(
  //     getIt<ISuggestionRepository>(),
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => CommentFeedbackTextFieldBloc(),
  // );
  // getIt.registerFactory(
  //   () => DetailFeedbackBloc(
  //     getIt<ISuggestionRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => AdsSliderBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => PushNotificationBloc(
  //     getIt<NotificationRepository>(),
  //   ),
  // );
  // getIt.registerLazySingleton(
  //   () => UnreadNotificationBloc(
  //     getIt<NotificationRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => NotificationsBloc(
  //     getIt<NotificationRepository>(),
  //     getIt<UnreadNotificationBloc>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => DetailFeedbackCommentBloc(
  //     getIt<ISuggestionRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ChatBloc(
  //     getIt<ChatRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ChatBoxBloc(getIt<ChatRepository>()),
  // );
  // getIt.registerFactory(
  //   () => ChatTextFieldBloc(),
  // );
  // getIt.registerFactory(
  //   () => PersonalInformationBloc(getIt<IStaffRepository>()),
  // );
  // getIt.registerFactory(
  //   () => ChatNotificationSettingBloc(
  //     getIt<IAuthenticationRepository>(),
  //     getIt<UserRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => CalendarBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => GeneralInformationBloc(
  //     getIt<IDocumentRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ChatNotificationButtonBloc(
  //     getIt<ChatRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ConversationBloc(
  //     getIt<ChatRepository>(),
  //     getIt<UserRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => BackgroundBloc(
  //     getIt<IAuthenticationRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ForwardMessageBloc(
  //     getIt<ChatRepository>(),
  //   ),
  // );
  // getIt.registerFactory(
  //   () => ForwardPhonebookBloc(),
  // );
}
