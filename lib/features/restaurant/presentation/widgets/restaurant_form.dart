import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class RestaurantFormResult {
  RestaurantFormResult({
    required this.name,
    required this.address,
    required this.currency,
    required this.language,
    required this.taxPercent,
    required this.workingHoursOpen,
    required this.workingHoursClose,
  });

  final String name;
  final String? address;
  final String currency;
  final String language;
  final double taxPercent;
  final String? workingHoursOpen;
  final String? workingHoursClose;
}

/// Restaurant profile form, shared by the first-run setup screen and the
/// later Restaurant Settings screen (see DesignGD.md → Forms: single-column,
/// large inputs, real-time validation).
class RestaurantForm extends StatefulWidget {
  const RestaurantForm({
    super.key,
    this.initial,
    required this.onSubmit,
    required this.isLoading,
    required this.submitLabel,
    this.enabled = true,
  });

  final Restaurant? initial;
  final ValueChanged<RestaurantFormResult> onSubmit;
  final bool isLoading;
  final String submitLabel;

  /// When false, every field is read-only and the submit button is hidden
  /// — used to show non-owners the restaurant profile without letting them
  /// edit it.
  final bool enabled;

  @override
  State<RestaurantForm> createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _addressController = TextEditingController(text: widget.initial?.address);
  late final _currencyController = TextEditingController(text: widget.initial?.currency ?? 'USD');
  late final _languageController = TextEditingController(text: widget.initial?.language ?? 'en');
  late final _taxController =
      TextEditingController(text: widget.initial?.taxPercent.toString() ?? '0');
  late final _openController = TextEditingController(text: widget.initial?.workingHoursOpen);
  late final _closeController = TextEditingController(text: widget.initial?.workingHoursClose);

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _currencyController.dispose();
    _languageController.dispose();
    _taxController.dispose();
    _openController.dispose();
    _closeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(
      RestaurantFormResult(
        name: _nameController.text.trim(),
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        currency: _currencyController.text.trim().isEmpty ? 'USD' : _currencyController.text.trim(),
        language: _languageController.text.trim().isEmpty ? 'en' : _languageController.text.trim(),
        taxPercent: double.tryParse(_taxController.text.trim()) ?? 0,
        workingHoursOpen: _openController.text.trim().isEmpty ? null : _openController.text.trim(),
        workingHoursClose: _closeController.text.trim().isEmpty ? null : _closeController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _nameController,
            label: 'Business name',
            textInputAction: TextInputAction.next,
            enabled: widget.enabled,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a business name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _addressController,
            label: 'Address',
            textInputAction: TextInputAction.next,
            enabled: widget.enabled,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _currencyController,
                  label: 'Currency',
                  hint: 'USD',
                  enabled: widget.enabled,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  controller: _languageController,
                  label: 'Language',
                  hint: 'en',
                  enabled: widget.enabled,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _taxController,
            label: 'Tax percent',
            hint: '0',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            enabled: widget.enabled,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _openController,
                  label: 'Opens',
                  hint: '09:00',
                  enabled: widget.enabled,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  controller: _closeController,
                  label: 'Closes',
                  hint: '23:00',
                  enabled: widget.enabled,
                ),
              ),
            ],
          ),
          if (widget.enabled) ...[
            const SizedBox(height: AppSpacing.md),
            AppButton(label: widget.submitLabel, isLoading: widget.isLoading, onPressed: _submit),
          ],
        ],
      ),
    );
  }
}
