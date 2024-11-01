import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import 'package:menyusha/app/data/firebase/menu/menu_payload_repository.dart';
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_state.dart";

///cubit logic
class PublicMenuCubit extends Cubit<PublicMenuState> {
  PublicMenuCubit(this.id)
      : super(
          PublicMenuState(
            activeMenu: null,
          ),
        ) {
    init(id);
  }

  final String id;
  final getIt = GetIt.instance;

  final MenuPayloadRepository repository = MenuPayloadRepository();

  Future<void> init(final String id) async {
    final item = await repository.getItemByPublicId(id);
    emit(state.copyWith(activeMenu: item));
  }
}
