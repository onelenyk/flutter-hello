import "dart:convert";

import "../../../../../../data/firebase/menu/menu_payload.dart";


class PublicMenuState {
  PublicMenuState({
    required this.activeMenu,
  });

  final MenuPayload? activeMenu;

  // The copyWith method
  PublicMenuState copyWith({
    final MenuPayload? activeMenu,
  }) =>
      PublicMenuState(
        activeMenu: activeMenu ?? this.activeMenu,
      );
}

