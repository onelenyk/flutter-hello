import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:menyusha/app/data/firebase/user/user_payload.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/list_menu/list_menu_state.dart";

import "../../../../../../data/firebase/auth/auth_state.dart";
import "../../../../../../data/firebase/menu/menu_payload.dart";
import "../../../../../../data/firebase/menu/menu_payload_repository.dart";
import "../../login/auth_cubit.dart";
import "../admin_state.dart";

///cubit logic
class ListMenuCubit extends Cubit<ListMenuState> {
  ListMenuCubit() : super(ListMenuState(items: [])) {
    initialize();
  }

  final getIt = GetIt.instance;

  late final AuthenticationCubit authorizationCubit =
      getIt<AuthenticationCubit>();

  final MenuPayloadRepository repository = MenuPayloadRepository();

  Future<void> listenUserItems(final UserPayload payload) async {
    repository.getItemsLive().listen((final items) async {
      emit(state.copyWith(items: items));
    });
  }

  Future<void> initialize() async {
    // initialize();
    authorizationCubit.stream.listen((final authorizationState) async {
      if (authorizationState is AuthLoading) {

      } else if (authorizationState is AuthInitial) {

      } else if (authorizationState is AuthFailed) {

      } else if (authorizationState is AuthSuccess) {
        await listenUserItems(authorizationState.userPayload!);
      } else {}
    });
  }


  Future<void> signOut() async => authorizationCubit.signOut();

  Future<void> createNewMenu({required final MenuPayload payload}) async =>
      repository.createMenu(payload);

  Future<void> deleteMenu({required final MenuPayload payload}) async =>
      repository.deleteMenu(payload);

  Future<void> updateMenu({required final MenuPayload payload}) async =>
      repository.updateMenu(payload);
}
