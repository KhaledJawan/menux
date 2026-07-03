import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../data/message_repository.dart';
import '../widgets/message_form_sheet.dart';

class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesProvider);

    return AppScaffold(
      title: 'Messages',
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMessageFormSheet(context),
        child: const Icon(Icons.edit_outlined),
      ),
      body: messagesAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(messagesProvider)),
        data: (messages) {
          if (messages.isEmpty) {
            return EmptyState(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'No messages yet',
              message: 'Send a message to your team.',
              actionLabel: 'New Message',
              onAction: () => showMessageFormSheet(context),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.sm),
            itemCount: messages.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, index) {
              final message = messages[index];
              return AppCard(
                onTap: () {
                  if (!message.isRead) {
                    ref.read(messageRepositoryProvider).markRead(message.id);
                  }
                  showAppBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(message.title, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text(
                          'From ${message.senderName} · ${DateFormat.yMMMd().add_jm().format(message.createdAt)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(message.body),
                      ],
                    ),
                  );
                },
                child: Row(
                  children: [
                    if (!message.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: AppSpacing.xs),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.title,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: message.isRead ? FontWeight.w400 : FontWeight.w600,
                                ),
                          ),
                          Text(
                            message.body,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      DateFormat.MMMd().format(message.createdAt),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
