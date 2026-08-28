import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_tokens.dart';

/// Barre de réactions LinkedIn : apparaît à l'appui long sur « J'aime ».
/// 6 réactions animées en cascade ; on relâche sur l'une d'elles pour choisir.
class ReactionBar extends StatelessWidget {
  const ReactionBar({super.key, required this.onPick});
  final ValueChanged<LiReaction> onPick;

  static Future<void> show(
    BuildContext context, {
    required Offset anchor,
    required ValueChanged<LiReaction> onPick,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (dialogContext) {
        final size = MediaQuery.sizeOf(dialogContext);
        final top = (anchor.dy - 64).clamp(40.0, size.height - 120);
        final left = (anchor.dx - 20).clamp(12.0, size.width - 300);
        return Stack(
          children: [
            Positioned(
              left: left,
              top: top,
              child: Material(
                color: Colors.transparent,
                child: ReactionBar(
                  onPick: (r) {
                    Navigator.of(dialogContext).pop();
                    onPick(r);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: LiDuration.base,
      curve: Curves.easeOutBack,
      builder: (context, v, child) => Transform.scale(
        scale: 0.7 + 0.3 * v,
        alignment: Alignment.bottomLeft,
        child: Opacity(opacity: v.clamp(0, 1), child: child),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final r in LiReaction.values)
              _ReactionButton(reaction: r, onTap: () => onPick(r)),
          ],
        ),
      ),
    );
  }
}

class _ReactionButton extends StatefulWidget {
  const _ReactionButton({required this.reaction, required this.onTap});
  final LiReaction reaction;
  final VoidCallback onTap;

  @override
  State<_ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<_ReactionButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.reaction.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            widget.onTap();
          },
          child: AnimatedScale(
            scale: _hover ? 1.3 : 1,
            duration: LiDuration.fast,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                widget.reaction.emoji,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pile compacte d'emojis de réaction pour la preuve sociale.
class ReactionStack extends StatelessWidget {
  const ReactionStack({super.key, required this.reactions, this.size = 16});
  final List<LiReaction> reactions;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (reactions.isEmpty) {
      return Text('👍', style: TextStyle(fontSize: size));
    }
    return SizedBox(
      width: size + (reactions.length - 1) * (size * 0.7),
      height: size + 2,
      child: Stack(
        children: [
          for (var i = 0; i < reactions.length; i++)
            Positioned(
              left: i * (size * 0.7),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  reactions[i].emoji,
                  style: TextStyle(fontSize: size),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
