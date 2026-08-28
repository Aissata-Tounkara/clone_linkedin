import 'package:flutter/material.dart';
import '../theme/app_tokens.dart';

/// Primitives visuelles réutilisées sur tous les écrans, calées sur LinkedIn.

/// Fin séparateur 1 px (les listes LinkedIn n'ont pas d'ombre, juste ça).
class LiHairline extends StatelessWidget {
  const LiHairline({super.key, this.indent = 0});
  final double indent;
  @override
  Widget build(BuildContext context) => Divider(
    height: 1,
    thickness: 1,
    color: LiColors.hairline,
    indent: indent,
    endIndent: 0,
  );
}

/// Épais séparateur gris entre deux blocs (comme entre les cartes du feed).
class LiBlockGap extends StatelessWidget {
  const LiBlockGap({super.key, this.height = 8});
  final double height;
  @override
  Widget build(BuildContext context) =>
      Container(height: height, color: LiColors.canvas);
}

/// Carte blanche d'une section de profil : titre + action facultative.
class LiSectionCard extends StatelessWidget {
  const LiSectionCard({
    super.key,
    this.title,
    this.action,
    this.onAction,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 16),
  });
  final String? title;
  final IconData? action;
  final VoidCallback? onAction;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: LiColors.surface,
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (action != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: onAction,
                  icon: Icon(action, color: LiColors.textSecondary),
                ),
            ],
          ),
        if (title != null) const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

/// Rangée horizontale de chips à choix unique (filtres de feed, notifs, jobs).
class LiChipsRow extends StatelessWidget {
  const LiChipsRow({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: options.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),
      itemBuilder: (_, i) {
        final value = options[i];
        final isSel = value == selected;
        return ChoiceChip(
          label: Text(value),
          selected: isSel,
          showCheckmark: false,
          onSelected: (_) => onSelected(value),
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSel ? LiColors.brandHover : LiColors.textSecondary,
          ),
          side: BorderSide(
            color: isSel ? LiColors.brand : LiColors.border,
            width: isSel ? 1.4 : 1,
          ),
        );
      },
    ),
  );
}

/// Bouton d'action d'une carte de post : icône + libellé, gris ou actif.
class LiIconAction extends StatelessWidget {
  const LiIconAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.onLongPress,
    this.color,
    this.active = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final c = color ?? (active ? LiColors.brand : LiColors.textSecondary);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: c),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: c,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Petite pastille rouge de compteur (bottom nav, icône messagerie).
class LiBadge extends StatelessWidget {
  const LiBadge({super.key, required this.count, this.child});
  final int count;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child ?? const SizedBox.shrink();
    final label = count > 99 ? '99+' : '$count';
    final dot = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      constraints: const BoxConstraints(minWidth: 18),
      decoration: BoxDecoration(
        color: LiColors.badge,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    if (child == null) return dot;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(right: -6, top: -4, child: dot),
      ],
    );
  }
}

/// Bottom sheet du menu « ⋯ » d'un post / d'une notification.
Future<void> showLiOverflowSheet(
  BuildContext context, {
  required List<({IconData icon, String label})> items,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items)
            ListTile(
              leading: Icon(item.icon, color: LiColors.textPrimary),
              title: Text(
                item.label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(sheetContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(item.label),
                    duration: const Duration(milliseconds: 900),
                  ),
                );
              },
            ),
        ],
      ),
    ),
  );
}

/// Séparateur « Trier par : … » du feed.
class LiSortHeader extends StatelessWidget {
  const LiSortHeader({super.key, this.value = 'Les plus pertinents'});
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    color: LiColors.canvas,
    padding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
    child: Row(
      children: [
        const Expanded(child: LiHairline()),
        const SizedBox(width: 10),
        Text(
          'Trier par : ',
          style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: LiColors.textPrimary,
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, size: 16),
      ],
    ),
  );
}
