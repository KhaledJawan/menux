import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/session/app_settings_repository.dart';

part 'auth_repository.g.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
}

/// Local-first authentication. Menux has no Supabase project configured in
/// this build, so accounts live entirely on-device — this also satisfies
/// the "local/dev mode" requirement when Supabase env vars are absent.
class AuthRepository {
  AuthRepository(this._db, this._settings);

  final AppDatabase _db;
  final AppSettingsRepository _settings;

  String _hash(String password) => sha256.convert(utf8.encode(password)).toString();

  Future<LocalProfile> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final existing = await (_db.select(_db.localProfiles)
          ..where((t) => t.email.equals(normalizedEmail)))
        .getSingleOrNull();
    if (existing != null) {
      throw AuthException('An account with this email already exists.');
    }

    final id = await _db.into(_db.localProfiles).insert(
          LocalProfilesCompanion.insert(
            name: name.trim(),
            email: normalizedEmail,
            passwordHash: _hash(password),
          ),
        );
    final profile = await (_db.select(_db.localProfiles)..where((t) => t.id.equals(id))).getSingle();
    await _settings.set(SettingsKeys.sessionProfileId, profile.id.toString());
    return profile;
  }

  Future<LocalProfile> login({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    final profile = await (_db.select(_db.localProfiles)
          ..where((t) => t.email.equals(normalizedEmail)))
        .getSingleOrNull();
    if (profile == null || profile.passwordHash != _hash(password)) {
      throw AuthException('Incorrect email or password.');
    }
    await _settings.set(SettingsKeys.sessionProfileId, profile.id.toString());
    return profile;
  }

  /// Local-only password reset: verifies the account exists, then sets a
  /// new password directly (there is no email service without Supabase).
  Future<void> resetPassword({required String email, required String newPassword}) async {
    final normalizedEmail = email.trim().toLowerCase();
    final profile = await (_db.select(_db.localProfiles)
          ..where((t) => t.email.equals(normalizedEmail)))
        .getSingleOrNull();
    if (profile == null) {
      throw AuthException('No account found with this email.');
    }
    await (_db.update(_db.localProfiles)..where((t) => t.id.equals(profile.id)))
        .write(LocalProfilesCompanion(passwordHash: Value(_hash(newPassword))));
  }

  Future<void> logout() async {
    await _settings.remove(SettingsKeys.sessionProfileId);
  }

  Stream<LocalProfile?> watchCurrentProfile() {
    return _settings.watch(SettingsKeys.sessionProfileId).asyncExpand((idString) {
      final id = int.tryParse(idString ?? '');
      if (id == null) return Stream.value(null);
      final query = _db.select(_db.localProfiles)..where((t) => t.id.equals(id));
      return query.watchSingleOrNull();
    });
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appSettingsRepositoryProvider),
  );
}

// Hand-written (not @riverpod-generated): riverpod_generator's type-to-code
// step fails on providers whose return type embeds a Drift-generated row
// class such as LocalProfile. See branch_repository.dart for the same
// pattern.
final currentProfileProvider = StreamProvider<LocalProfile?>((ref) {
  return ref.watch(authRepositoryProvider).watchCurrentProfile();
});
