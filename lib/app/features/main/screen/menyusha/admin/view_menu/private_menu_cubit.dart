import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import 'package:menyusha/app/data/firebase/menu/menu_payload_repository.dart';
import "package:menyusha/app/features/main/screen/menyusha/admin/admin_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/view_menu/private_menu_state.dart";
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_state.dart";

import "../../../../../../data/firebase/auth/auth_state.dart";
import "../../../../../../data/firebase/menu/menu_payload.dart";
import "../../login/auth_cubit.dart";

///cubit logic
class PrivateMenuCubit extends Cubit<PrivateMenuState> {
  PrivateMenuCubit(this.id)
      : super(
          PrivateMenuState(
            activeMenu: null,
          ),
        ) {
    init(id);
  }

  late final AuthenticationCubit authorizationCubit =
      getIt<AuthenticationCubit>();

  final String id;
  final getIt = GetIt.instance;

  final MenuPayloadRepository repository = MenuPayloadRepository();

  Future<void> initialize() async {
    // initialize();
  }

  Future<void> init(final String id) async {
    final item = await repository.getItem(id);
    emit(state.copyWith(activeMenu: item));
  }

  Future<void> signOut() async => authorizationCubit.signOut();

  Future<void> createNewMenu({required final MenuPayload payload}) async =>
      repository.createMenu(payload);

  Future<void> deleteMenu({required final MenuPayload payload}) async =>
      repository.deleteMenu(payload);

  Future<void> updateMenu({required final MenuPayload payload}) async =>
      repository.updateMenu(payload);

  Future<void> saveMenu({required final Menu menu}) async {
    final activeMenu = state.activeMenu;

    if (activeMenu == null) return;

    final menuToUpdate = activeMenu.copyWith(menu: menu);
    updateMenu(payload: menuToUpdate);
    emit(state.copyWith(activeMenu: menuToUpdate));

  }

  Future<void> switchMode() async {
    emit(state.copyWith(
        viewMode: state.viewMode == Mode.VIEW ? Mode.EDIT_JSON : Mode.VIEW));
  }
}
