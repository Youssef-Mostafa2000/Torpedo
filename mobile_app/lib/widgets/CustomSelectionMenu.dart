import 'package:flutter/material.dart';

class CustomSelectionMenu extends StatefulWidget {
  final List<String>? items;
  final ValueChanged<String>? onChanged;
  final String? hint;
  final String? selectedItem;
  final String? label;
  CustomSelectionMenu({
    required this.items,
    required this.onChanged,
    required this.hint,
    required this.selectedItem,
    required this.label,
  });

  @override
  State<CustomSelectionMenu> createState() => _CustomSelectionMenuState();
}

class _CustomSelectionMenuState extends State<CustomSelectionMenu> {
  bool _isDropdownOpen = false;
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  String? _selectedItem;
  Color? itemColor;

  List<Color>? _itemColors;

  @override
  void initState() {
    // TODO: implement initState
    itemColor = const Color(0xffF4F4F4);
    _itemColors = List<Color>.generate(
      widget.items!.length,
      (index) => const Color(0xffF4F4F4),
    );

    super.initState();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry.remove();
    setState(() {
      _isDropdownOpen = false;
    });
  }

  void _changeColor(int index) {
    setState(() {
      _itemColors![index] = (_itemColors![index] == Color(0xffF4F4F4))
          ? Colors.red
          : const Color(0xffF4F4F4);
    });
    print(_itemColors![index]);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            width: size.width,
            top: offset.dy + size.height - 1.5,
            left: offset.dx,
            child: Material(
              // elevation: 2.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                constraints: BoxConstraints(
                  maxHeight:
                      280, // Set the maximum height for the dropdown menu
                ),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  /*boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],*/
                ),
                child: /*ListView.builder(
                  // textDirection: TextDirection.rtl,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.items!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        if (_itemColors![index] == Color(0xffF4F4F4)) {
                          setState(() {
                            _itemColors![index] = Colors.red;
                          });
                        } else {
                          setState(() {
                            _itemColors![index] = Color(0xffF4F4F4);
                          });
                        }
                      },
                      onTap: () {
                        setState(() {
                          _selectedItem = widget.items![index];
                          _isDropdownOpen = false;
                        });
                        widget.onChanged!(widget.items![index]);
                        _closeDropdown();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _itemColors![index],
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: Text(widget.items![index]),
                      ),
                    );
                  },*/
                    ListView(
                  // textDirection: TextDirection.rtl,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: widget.items!.map((item) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItem = item;
                          _isDropdownOpen = false;
                        });
                        widget.onChanged!(item);
                        _closeDropdown();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F4),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 8),
          child: Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xffF4F4F4),
                    style: BorderStyle.solid,
                  ),
                  color: const Color(0xffF4F4F4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.selectedItem! == ''
                          ? widget.hint!
                          : widget.selectedItem!,
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(_isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
