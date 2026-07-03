import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/seed_data_service.dart';
import '../../../../core/session/app_settings_repository.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../branches/data/branch_repository.dart';
import '../../../staff/data/staff_repository.dart';
import '../../data/restaurant_repository.dart';
import '../widgets/restaurant_form.dart';

class RestaurantSetupScreen extends ConsumerStatefulWidget {
  const RestaurantSetupScreen({super.key});

  @override
  ConsumerState<RestaurantSetupScreen> createState() => _RestaurantSetupScreenState();
}

class _RestaurantSetupScreenState extends ConsumerState<RestaurantSetupScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _createRestaurant(RestaurantFormResult result) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final profile = ref.read(currentProfileProvider).value;
      if (profile == null) {
        setState(() => _errorMessage = 'Your session expired. Please sign in again.');
        return;
      }
      final restaurant = await ref.read(restaurantRepositoryProvider).create(
            name: result.name,
            address: result.address,
            currency: result.currency,
            language: result.language,
            taxPercent: result.taxPercent,
            workingHoursOpen: result.workingHoursOpen,
            workingHoursClose: result.workingHoursClose,
          );
      final branch = await ref.read(branchRepositoryProvider).create(
            restaurantId: restaurant.id,
            name: 'Main Branch',
            address: result.address,
            workingHoursOpen: result.workingHoursOpen,
            workingHoursClose: result.workingHoursClose,
          );
      final owner = await ref.read(staffRepositoryProvider).createOwner(
            restaurantId: restaurant.id,
            profileId: profile.id,
            name: profile.name,
          );
      await ref.read(appSettingsRepositoryProvider).set(SettingsKeys.currentBranchId, branch.id.toString());
      await ref
          .read(appSettingsRepositoryProvider)
          .set(SettingsKeysStaff.activeStaffId, owner.id.toString());
    } catch (e) {
      setState(() => _errorMessage = 'Could not create restaurant. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadSampleData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final profile = ref.read(currentProfileProvider).value;
      if (profile == null) {
        setState(() => _errorMessage = 'Your session expired. Please sign in again.');
        return;
      }
      await ref.read(seedDataServiceProvider).seedIfNeeded(profileId: profile.id, profileName: profile.name);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Your Restaurant')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Tell us about your business — you'll be ready to take orders in a couple of minutes.",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (_errorMessage != null) ...[
                    Text(
                      _errorMessage!,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  RestaurantForm(
                    onSubmit: _createRestaurant,
                    isLoading: _isLoading,
                    submitLabel: 'Create Restaurant',
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label: 'Load Sample Data Instead',
                    variant: AppButtonVariant.text,
                    onPressed: _isLoading ? null : _loadSampleData,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
