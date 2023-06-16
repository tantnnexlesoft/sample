import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sample/core/extension/screen_size_extension.dart';
import 'package:sample/core/widgets/image/app_svg_image.dart';
import '../../core/constant/resource/res.dart';
import '../../core/helper/html_shim.dart' if (dart.library.html) 'dart:html'
    show window;
import '../../core/enum/menu/menu_item.dart';
import '../../core/utils/device_util.dart';
import '../../core/widgets/button/app_button.dart';

abstract class MasterView extends StatefulWidget {
  const MasterView({
    Key? key,
    required this.hasRightMenu,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  Widget getChild(BuildContext context);

  Widget getLeftMenu(BuildContext context);

  Widget? getRightMenu(BuildContext context, {bool showSearchFeed = true}) =>
      null;

  final bool hasRightMenu;

  final bool resizeToAvoidBottomInset;

  EMenuItem? getSelectedMenu() => null;

  @override
  State<MasterView> createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView> {
  late ValueNotifier<bool> _isDesktopView;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget? child;
  Orientation? currentOrientation;

  @override
  void initState() {
    super.initState();
    if (DeviceUtil.isWebDesktop) {
      if ((window.innerWidth ?? 0) >= 1000) {
        _isDesktopView = ValueNotifier<bool>(true);
      } else {
        _isDesktopView = ValueNotifier<bool>(false);
      }
      window.addEventListener('resize', (event) {
        if ((window.innerWidth ?? 0) >= 1000) {
          _isDesktopView.value = true;
        } else {
          _isDesktopView.value = false;
        }
      });
    } else {
      _isDesktopView = ValueNotifier<bool>(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    child ??= widget.getChild(context);
    if (DeviceUtil.isWebDesktop) {
      return ValueListenableBuilder<bool>(
        valueListenable: _isDesktopView,
        builder: (BuildContext context, value, Widget? child) {
          if (value) return buildDesktopView(context, child);
          return buildMobileView(context, child);
        },
        child: child,
      );
    }
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (currentOrientation == null) {
          currentOrientation = orientation;
        }
        if (currentOrientation == Orientation.landscape) {
          return buildDesktopView(context, child);
        }
        return buildMobileView(context, child);
      },
    );
  }

  Widget buildDesktopView(BuildContext context, Widget? child) {
    DeviceUtil.isUsingMobileViewOnDeskTopUI = false;
    final rightMenu = widget.getRightMenu(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 3, child: widget.getLeftMenu(context)),
          Expanded(
            flex: widget.hasRightMenu ? 7 : 10,
            child: Column(
              children: [
                // if (rightMenu != null)
                //   SizedBox(
                //     height: 20.wh,
                //   ),
                Expanded(child: child ?? Container()),
              ],
            ),
          ),
          if (widget.hasRightMenu)
            Expanded(
              flex: 3,
              child: (rightMenu != null)
                  ? Padding(
                      padding: EdgeInsets.only(top: 14.wh),
                      child: rightMenu,
                    )
                  : Container(),
            )
        ],
      ),
    );
  }

  Widget buildMobileView(BuildContext context, Widget? child) {
    DeviceUtil.isUsingMobileViewOnDeskTopUI = true;
    final rightMenu = widget.getRightMenu(context, showSearchFeed: false);

    return kIsWeb
        ? _buildViewOnWeb(
            rightMenu: rightMenu,
          )
        : _buildViewOnMobileTablet(
            rightMenu: rightMenu,
          );
  }

  Widget _buildViewOnMobileTablet({
    Widget? rightMenu,
  }) {
    return _buildViewOnMobileTabletContent(
      rightMenu: rightMenu,
    );
  }

  Widget _buildViewOnMobileTabletContent({
    Widget? rightMenu,
  }) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: AppBar(
        elevation: 0,
        leading: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(left: 10.wh),
            child: AppButton(
              height: 37.wh,
              width: 33.wh,
              child: Icon(
                Icons.menu,
                size: 25.wh,
              ),
              onTap: () => scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ),
        actions: (rightMenu != null)
            ? []
            : [
                Container(),
              ],
      ),
      drawer: Drawer(
        child: widget.getLeftMenu(context),
      ),
      endDrawer: (rightMenu == null)
          ? null
          : Drawer(
              child: rightMenu,
            ),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: child ?? Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildViewOnWeb({
    Widget? rightMenu,
  }) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(left: 10.wh),
            child: AppButton(
              height: 37.wh,
              width: 33.wh,
              child: Icon(
                Icons.menu,
                size: 25.wh,
                color: Colors.white,
              ),
              onTap: () => scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ),
        actions: (rightMenu != null)
            ? []
            : [
                Container(),
              ],
      ),
      drawer: Drawer(
        child: widget.getLeftMenu(context),
      ),
      endDrawer: (rightMenu == null)
          ? const SizedBox()
          : Drawer(
              backgroundColor: Colors.white,
              child: rightMenu,
            ),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: child ?? Container(),
          ),
        ],
      ),
    );
  }
}

class ScreenWeb<T extends StatelessWidget> extends MasterView {
  final Widget Function() child;
  final Widget Function(bool)? rightMenu;
  final EMenuItem Function()? selectedMenu;

  const ScreenWeb({
    Key? key,
    required this.child,
    this.rightMenu,
    this.selectedMenu,
    hasRightMenu = true,
    resizeToAvoidBottomInset = true,
  }) : super(
            key: key,
            hasRightMenu: hasRightMenu,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset);

  @override
  Widget getChild(BuildContext context) {
    return child();
  }

  @override
  Widget? getRightMenu(BuildContext context, {bool showSearchFeed = true}) {
    return rightMenu?.call(showSearchFeed);
  }

  @override
  EMenuItem? getSelectedMenu() {
    return selectedMenu?.call();
  }

  @override
  Widget getLeftMenu(BuildContext context) {
    final EMenuItem? selectedMenuItem = getSelectedMenu();
    return Container();
  }
}
