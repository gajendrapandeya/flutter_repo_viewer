import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/application/auth_notifier.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/secure_credentials_storage.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';
import 'package:repo_viewer/auth/infrastructure/oauth2_interceptor.dart';

final flutterSecuredStorage = Provider((ref) => const FlutterSecureStorage());

final dioForAuthProvider = Provider((ref) => Dio());

final oAuth2InterceptorProvider = Provider(
  (ref) => OAuth2Interceptor(
    ref.watch(githubAuthenticatorProvider),
    ref.watch(authNotifierProvider.notifier),
    ref.watch(
      dioForAuthProvider,
    ),
  ),
);

final credentialStorageProvider = Provider<CredentialsStorage>(
  (ref) => SecureCredentialsStorage(
    ref.watch(flutterSecuredStorage),
  ),
);

final githubAuthenticatorProvider = Provider(
  (ref) => GithubAuthenticator(
    ref.watch(credentialStorageProvider),
    ref.watch(dioForAuthProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.watch(githubAuthenticatorProvider),
  ),
);
