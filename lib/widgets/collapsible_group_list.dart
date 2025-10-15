import 'package:borrow_mii/core/controllers/choose_controller.dart';
import 'package:flutter/material.dart';

class CollapsibleGroupList<T> extends StatefulWidget {
  final String Function(T element) getLabel;
  final String Function(T element) getGroupKey;
  final Widget Function(T element, BuildContext context) buildTile;
  final void Function(T element)? onLongPress;
  final Color selectedTileColor;
  final SimpleChooser chooser;
  final bool allowSelection;
  final Color selectedColor;
  const CollapsibleGroupList({
    super.key,
    required this.getGroupKey,
    required this.getLabel,
    required this.buildTile,
    required this.chooser,
    this.allowSelection = false,
    this.selectedColor = const Color.fromARGB(255, 0,0,0),
    this.selectedTileColor = const Color.fromARGB(255, 245, 255, 106),
    this.onLongPress
  });

  @override
  State<CollapsibleGroupList> createState() => _CollapsibleGroupListWidgetState<T>();

}


class _CollapsibleGroupListWidgetState<T> extends State<CollapsibleGroupList<T>> {
  Widget makeTile(List<int> items, String label) {
    final tileText = widget.getGroupKey(widget.chooser.items[0]);
    return ExpansionTile(title: Text(label),
      children: List.generate(items.length, (i) {
        final itemIdx = items[i];
        T item = widget.chooser.getItem(itemIdx);
        return ListTile(
          title: widget.buildTile(item, context),
          selected: widget.chooser.indices.contains(itemIdx),
          selectedTileColor: widget.selectedTileColor,
          selectedColor: widget.selectedColor,
          onTap: widget.allowSelection ? () => {
            setState(() => widget.chooser.pushIndex(itemIdx))
          } : null,
          onLongPress: widget.onLongPress != null ? () => widget.onLongPress!(item) : null,
        ) ;
      }),

    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for(final entry in widget.chooser.maps.entries) ... [
          makeTile(entry.value, entry.key)
        ]
      ],
    );

  }
}