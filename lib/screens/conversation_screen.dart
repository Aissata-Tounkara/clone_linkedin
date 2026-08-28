import 'dart:async';

import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../models/conversation.dart';
import '../theme/app_tokens.dart';
import '../widgets/gen_avatar.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.conversation});
  final Conversation conversation;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  bool _typing = false;
  Timer? _typingTimer;

  Conversation get conv => widget.conversation;

  @override
  void initState() {
    super.initState();
    Repository.instance.markConversationRead(conv);
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Repository.instance.sendMessage(conv, text);
    _controller.clear();
    setState(() => _typing = true);
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _typing = false);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            GenAvatar(seed: conv.seed, name: conv.name, size: 32),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(conv.name, style: const TextStyle(fontSize: 16)),
                  Text(
                    conv.online ? 'En ligne' : conv.headline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: conv.online
                          ? LiColors.greenDark
                          : LiColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: Repository.instance,
              builder: (context, _) {
                final msgs = conv.messages;
                _scrollToBottom();
                return ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.all(12),
                  itemCount: msgs.length + (_typing ? 1 : 0) + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) return _IntroCard(conv: conv);
                    final index = i - 1;
                    if (index >= msgs.length) return const _TypingBubble();
                    final m = msgs[index];
                    final showDay = index == 0 ||
                        msgs[index - 1].day != m.day;
                    return Column(
                      children: [
                        if (showDay) _DayChip(label: m.day),
                        _Bubble(message: m, seed: conv.seed, name: conv.name),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          _Composer(controller: _controller, onSend: _send),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.conv});
  final Conversation conv;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          GenAvatar(seed: conv.seed, name: conv.name, size: 72),
          const SizedBox(height: 8),
          Text(conv.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          Text(
            conv.headline,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      label,
      style: TextStyle(fontSize: 12, color: LiColors.textTertiary),
    ),
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message, required this.seed, required this.name});
  final ChatMessage message;
  final String seed, name;

  @override
  Widget build(BuildContext context) {
    final mine = message.mine;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!mine) ...[
            GenAvatar(seed: seed, name: name, size: 28),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 280),
                  decoration: BoxDecoration(
                    color: mine ? LiColors.brand : LiColors.bubbleIn,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(mine ? 14 : 2),
                      bottomRight: Radius.circular(mine ? 2 : 14),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: mine ? Colors.white : LiColors.textPrimary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    mine ? '${message.time} · ${message.status}' : message.time,
                    style: TextStyle(
                      fontSize: 10,
                      color: LiColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();
  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
        ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 6, left: 36),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: LiColors.bubbleIn,
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              final t = (_c.value + i * 0.2) % 1.0;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: LiColors.textTertiary.withValues(
                    alpha: 0.3 + 0.7 * (t < 0.5 ? t * 2 : (1 - t) * 2),
                  ),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.onSend});
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: LiColors.hairline)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline,
                    color: LiColors.textSecondary),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  decoration: InputDecoration(
                    hintText: 'Écrire un message…',
                    isDense: true,
                    filled: true,
                    fillColor: LiColors.bubbleIn,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onSend,
                icon: const Icon(Icons.send, color: LiColors.brand),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
