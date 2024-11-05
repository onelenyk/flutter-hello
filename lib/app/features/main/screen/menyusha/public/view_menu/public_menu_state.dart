import "dart:convert";

import "../../../../../../data/firebase/menu/menu_payload.dart";

class PublicMenuState {
  PublicMenuState({
    required this.isInitialization,
    required this.menuLoadingFailed,
    required this.loadedMenu,
  });

  final MenuPayload? loadedMenu;
  final bool isInitialization;
  final bool menuLoadingFailed;

  // The copyWith method
  PublicMenuState copyWith({
    final MenuPayload? activeMenu,
    final bool? isInitialization,
    final bool? menuLoadingFailed,
  }) =>
      PublicMenuState(
        loadedMenu: activeMenu ?? this.loadedMenu,
        isInitialization: isInitialization ?? this.isInitialization,
        menuLoadingFailed: menuLoadingFailed ?? this.menuLoadingFailed,
      );
}
