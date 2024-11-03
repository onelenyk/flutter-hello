import "dart:convert";

import "../../../../../../data/firebase/menu/menu_payload.dart";


class PrivateMenuState {
  PrivateMenuState({
    required this.activeMenu,
    this.viewMode = Mode.VIEW,
  });

  final MenuPayload? activeMenu;

  final Mode viewMode;

  // The copyWith method
  PrivateMenuState copyWith({
    final MenuPayload? activeMenu,
    final Mode? viewMode,
  }) =>
      PrivateMenuState(
        activeMenu: activeMenu ?? this.activeMenu,
        viewMode: viewMode ?? this.viewMode,
      );
}

enum Mode {
  VIEW,
  EDIT_JSON,
  EDIT_UI,
  ;

  String toJson() => name;
  // Convert string back to enum
  static DesignPreset fromJson(String json) => DesignPreset.values.byName(json);
}
