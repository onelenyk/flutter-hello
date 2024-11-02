import "dart:convert";
import "package:menyusha/app/data/firebase/auth/auth_state.dart";

import "../../../../../../data/firebase/menu/menu_payload.dart";

class ListMenuState {
  ListMenuState({
    required this.items,
  });

  final List<MenuPayload> items;
  // The copyWith method
  ListMenuState copyWith({
    final List<MenuPayload>? items,
  }) =>
      ListMenuState(
        items: items ?? this.items,
      );
}
