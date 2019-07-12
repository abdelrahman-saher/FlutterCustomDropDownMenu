import 'package:flutter/material.dart';
import 'dart:math';

class CustomDropDown extends StatefulWidget {
  final String title;
  final double titleSize;
  final IconData headerIcon;
  final double iconSize;
  final String errorMessage;
  final double errorMessageSize;
  final bool error;
  final String hintText;
  final List<Map<String, dynamic>> items;
  final Function onSelected;
  final Map<String, dynamic> selectedItem;
  final bool withoutHeader;
  final Color iconColor;
  final Color bgColor;
  final Color textColor;
  final Color dividerColor;
  final bool withBorder;
  final Color borderColor;
  final Color headerColor;
  final Direction direction;
  final double borderRadius;
  final double itemsTextSize;
  final Color headerIconColor;
  final double borderWidth;
  CustomDropDown({
    this.title,
    this.headerIcon,
    this.hintText,
    this.items,
    this.onSelected,
    this.error,
    this.errorMessage,
    this.selectedItem,
    this.withoutHeader = false,
    this.iconColor = Colors.white,
    this.bgColor,
    this.textColor = Colors.white,
    this.dividerColor,
    this.withBorder = false,
    this.borderColor,
    this.headerColor = Colors.white,
    this.direction,
    this.errorMessageSize,
    this.titleSize,
    this.borderRadius,
    this.itemsTextSize,
    this.iconSize = 20,
    this.headerIconColor,
    this.borderWidth = 1,
  });
  @override
  State<StatefulWidget> createState() {
    return _CustomDropDownState();
  }
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool showMenu = false;
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  final LayerLink _layerLink = LayerLink();
  String selectedName, selectedValue;
  List<Widget> items = [];
  GlobalKey key = GlobalKey();

  List<Widget> generateItemsList() {
    List<Widget> tempItemsList = [];
    widget.items.forEach((Map<String, dynamic> item) {
      tempItemsList.add(_buildItem(item: item));
    });
    return tempItemsList;
  }

  showMenuOverlay(BuildContext context) {
    items = generateItemsList();
    RenderBox renderBox = key.currentContext.findRenderObject();
    var size = renderBox.size;
    overlayState = Overlay.of(context);
    final pos = renderBox.localToGlobal(Offset.zero);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
            top: pos.dy,
            width: size.width,
            child: CompositedTransformFollower(
              showWhenUnlinked: false,
              link: _layerLink,
              offset: Offset(
                  0.0,
                  (widget.withBorder
                      ? size.height - widget.borderWidth
                      : size.height)),
              child: _buildMenu(items),
            ),
          ),
    );
    overlayState.insert(overlayEntry);
  }

  hideMenu() {
    overlayEntry.remove();
  }

  Widget _buildBase() {
    return GestureDetector(
      key: key,
      onTap: () {
        if (showMenu) {
          hideMenu();
        } else {
          showMenuOverlay(context);
        }
        setState(() {
          showMenu = !showMenu;
        });
      },
      child: Stack(
        children: <Widget>[
          widget.withBorder
              ? showMenu
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SemiRoundedBorderButton(
                        borderSide: BorderSide(
                            color: widget.borderColor,
                            width: widget.borderWidth),
                        radius: Radius.circular(widget.borderRadius),
                        background: Colors.transparent,
                      ),
                    )
                  : Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.borderColor,
                              width: widget.borderWidth),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(widget.borderRadius),
                            bottomLeft: showMenu
                                ? Radius.circular(0)
                                : Radius.circular(widget.borderRadius),
                            topRight: Radius.circular(widget.borderRadius),
                            bottomRight: showMenu
                                ? Radius.circular(0)
                                : Radius.circular(widget.borderRadius),
                          ),
                        ),
                      ),
                    )
              : Container(),
          Center(
            child: Row(
              children: widget.direction == Direction.Left
                  ? _baseRowItems().reversed.toList()
                  : _baseRowItems(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _baseRowItems() {
    return [
      Container(
        margin: widget.withBorder
            ? widget.direction == Direction.Right
                ? EdgeInsets.only(
                    top: widget.borderWidth,
                    left: widget.borderWidth,
                    bottom: widget.borderWidth)
                : EdgeInsets.only(
                    top: widget.borderWidth,
                    right: widget.borderWidth,
                    bottom: widget.borderWidth)
            : EdgeInsets.all(0),
        height: widget.withBorder ? (50 - (2 * widget.borderWidth)) : 50,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: widget.direction == Direction.Right
              ? BorderRadius.only(
                  topLeft: Radius.circular(widget.borderRadius),
                  bottomLeft: showMenu
                      ? Radius.circular(0)
                      : Radius.circular(widget.borderRadius),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(widget.borderRadius),
                  bottomRight: showMenu
                      ? Radius.circular(0)
                      : Radius.circular(widget.borderRadius),
                ),
        ),
        child: Icon(
          showMenu ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: widget.iconColor,
          size: 30,
        ),
      ),
      Expanded(
        child: Container(
          padding: widget.direction == Direction.Right
              ? EdgeInsets.only(right: 20)
              : EdgeInsets.only(left: 20),
          alignment: widget.direction == Direction.Right
              ? Alignment.centerRight
              : Alignment.centerLeft,
          height: widget.withBorder ? (50 - (2 * widget.borderWidth)) : 50,
          margin: widget.withBorder
              ? widget.direction == Direction.Right
                  ? EdgeInsets.only(right: widget.borderWidth)
                  : EdgeInsets.only(left: widget.borderWidth)
              : EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: widget.direction == Direction.Right
                ? BorderRadius.only(
                    topRight: Radius.circular(widget.borderRadius),
                    bottomRight: showMenu
                        ? Radius.circular(0)
                        : Radius.circular(widget.borderRadius),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    bottomLeft: showMenu
                        ? Radius.circular(0)
                        : Radius.circular(widget.borderRadius),
                  ),
          ),
          child: Text(selectedName == null ? widget.hintText : selectedName,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.itemsTextSize > 20 ? 20 : widget.itemsTextSize,
              )),
        ),
      ),
    ];
  }

  Widget _buildMenu(List<Widget> items) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        widget.withBorder
            ? showMenu
                ? Positioned(
                    top: -4 * widget.borderWidth,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Transform(
                      child: SemiRoundedBorderButton(
                        borderSide: BorderSide(
                            color: widget.borderColor,
                            width: widget.borderWidth),
                        radius: Radius.circular(widget.borderRadius),
                        background: Colors.transparent,
                      ),
                      alignment: FractionalOffset.center,
                      transform: Matrix4.rotationZ(pi),
                    ),
                  )
                : Container()
            : Container(),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: widget.withBorder
              ? EdgeInsets.only(
                  left: widget.borderWidth,
                  bottom: widget.borderWidth,
                  right: widget.borderWidth)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(widget.borderRadius),
                bottomRight: Radius.circular(widget.borderRadius)),
          ),
          width: double.infinity,
          height: items.length >= 3 ? 100 : items.length * 50.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: items,
          ),
        )
      ],
    );
  }

  Widget _buildItem({
    Map<String, dynamic> item,
  }) {
    String name;
    String value;
    name = item['name'];
    value = item['value'];
    return GestureDetector(
      onTap: () {
        hideMenu();
        setState(
          () {
            showMenu = false;
            selectedName = name;
            selectedValue = value;
            widget.onSelected({
              "name": selectedName,
              "value": selectedValue,
            });
          },
        );
      },
      child: Column(
        children: <Widget>[
          Divider(
            color: widget.dividerColor,
            height: 2,
          ),
          Container(
            height: 40,
            alignment: widget.direction == Direction.Right
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                  fontSize:
                      widget.itemsTextSize > 20 ? 20 : widget.itemsTextSize,
                  color: widget.textColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeaderItems() {
    return [
      Text(
        widget.title,
        style: TextStyle(
          color: widget.headerColor,
          fontSize: widget.titleSize,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Icon(
        widget.headerIcon,
        size: widget.iconSize,
        color: widget.headerIconColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        !widget.withoutHeader
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: widget.direction == Direction.Right
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: widget.direction == Direction.Left
                      ? _buildHeaderItems().reversed.toList()
                      : _buildHeaderItems(),
                ),
              )
            : Container(),
        !widget.withoutHeader
            ? SizedBox(
                height: 5,
              )
            : Container(),
        CompositedTransformTarget(
          link: _layerLink,
          child: _buildBase(),
        ),
        widget.error
            ? Container(
                height: 20,
                padding: widget.direction == Direction.Right
                    ? EdgeInsets.only(right: 20)
                    : EdgeInsets.only(left: 20),
                margin: EdgeInsets.only(top: 5),
                alignment: widget.direction == Direction.Right
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  widget.errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: widget.errorMessageSize >= 15
                        ? 15
                        : widget.errorMessageSize,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class SemiRoundedBorderButton extends StatelessWidget {
  final BorderSide borderSide;
  final Radius radius;
  final Color background;

  const SemiRoundedBorderButton({
    Key key,
    @required this.borderSide,
    @required this.radius,
    @required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ClipRect(
      clipper: new SemiRoundedBorderClipper(borderSide.width + 1.0),
      child: new DecoratedBox(
        decoration: new ShapeDecoration(
          color: background,
          shape: new RoundedRectangleBorder(
            side: borderSide,
            borderRadius: new BorderRadius.only(
              topLeft: radius,
              topRight: radius,
            ),
          ),
        ),
      ),
    );
  }
}

class SemiRoundedBorderClipper extends CustomClipper<Rect> {
  final double borderStrokeWidth;

  const SemiRoundedBorderClipper(this.borderStrokeWidth);

  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(
        0.0, 0.0, size.width, size.height - borderStrokeWidth);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    if (oldClipper.runtimeType != SemiRoundedBorderClipper) return true;
    return (oldClipper as SemiRoundedBorderClipper).borderStrokeWidth !=
        borderStrokeWidth;
  }
}

enum Direction { Right, Left }
