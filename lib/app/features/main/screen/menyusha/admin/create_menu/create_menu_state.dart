import "dart:convert";
import "package:menyusha/app/data/firebase/auth/auth_state.dart";

import "../../../../../../data/firebase/menu/menu_payload.dart";

class CreateMenuState {
  CreateMenuState({
    required this.items,
    required this.activeMenu,
  });

  final List<MenuPayload> items;
  final MenuPayload? activeMenu;
  // The copyWith method
  CreateMenuState copyWith({
    final List<MenuPayload>? items,
    final MenuPayload? activeMenu,
  }) =>
      CreateMenuState(
        items: items ?? this.items,
        activeMenu: activeMenu ?? this.activeMenu,
      );
}
