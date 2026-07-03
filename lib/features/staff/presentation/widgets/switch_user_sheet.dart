import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/session/app_settings_repository.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/staff_repository.dart';

Future<void> showSwitchUserSheet(BuildContext context, {required int restaurantId}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _SwitchUserSheet(restaurantId: restaurantId),
  );
}

class _SwitchUserSheet extends ConsumerWidget {
  const _SwitchUserSheet({required this.restaurantId});

  final int restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffForRestaurantProvider(restaurantId));
    final activeId = ref.watch(activeStaffMemberProvider).value?.id;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Who is using Menux?', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Select your name to check in with your role.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        staffAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => const SizedBox.shrink(),
          data: (staff) {
            final active = staff.where((s) => s.isActive).toList();
            if (active.isEmpty) {
              return Text(
                'No staff yet — add your team from More → Staff.',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            }
            return Column(
              children: [
                for (final member in active)
                  ListTile(
                    title: Text(member.name),
                    subtitle: Text(StaffRole.values.byName(member.role).label),
                    trailing: member.id == activeId
                        ? const Icon(Icons.check_rounded)
                        : (member.pin != null ? const Icon(Icons.lock_outline_rounded, size: 18) : null),
                    onTap: () => _select(context, ref, member),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _select(BuildContext context, WidgetRef ref, StaffMember member) async {
    if (member.pin == null || member.pin!.isEmpty) {
      await ref.read(appSettingsRepositoryProvider).set(SettingsKeysStaff.activeStaffId, member.id.toString());
      if (context.mounted) Navigator.of(context).pop();
      return;
    }

    final pinController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? error;

    final verified = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.sm, 0, AppSpacing.sm, AppSpacing.sm),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Enter PIN for ${member.name}', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  if (error != null) ...[
                    Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    const SizedBox(height: AppSpacing.xs),
                  ],
                  AppTextField(
                    controller: pinController,
                    label: 'PIN',
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label: 'Confirm',
                    onPressed: () {
                      if (pinController.text.trim() == member.pin) {
                        Navigator.of(context).pop(true);
                      } else {
                        setState(() => error = 'Incorrect PIN');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (verified == true) {
      await ref.read(appSettingsRepositoryProvider).set(SettingsKeysStaff.activeStaffId, member.id.toString());
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}
