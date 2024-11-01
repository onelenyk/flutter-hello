import "dart:convert";
import "package:menyusha/app/data/firebase/auth/auth_state.dart";

import "../../../../../data/firebase/menu/menu_payload.dart";
import "../menu/menyusha_state.dart";

class AdminState {
  AdminState({
    required this.items,
    required this.authState,
  });

  final List<MenuPayload> items;

  final AuthSuccess? authState;

  // The copyWith method
  AdminState copyWith({
    final List<MenuPayload>? items,
    final AuthSuccess? authState
  }) =>
      AdminState(
        items: items ?? this.items,
        authState: authState ?? this.authState,
      );
}
