import "dart:convert";

import "../../../../../data/firebase/menu/menu_payload.dart";


class MenyushaState {
  MenyushaState({
    required this.activeMenu,
  });

  final MenuPayload activeMenu;

  // The copyWith method
  MenyushaState copyWith({
    final MenuPayload? activeMenu,
  }) =>
      MenyushaState(
        activeMenu: activeMenu ?? this.activeMenu,
      );
}

