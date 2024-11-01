import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_state.dart";

import "../../../../../data/firebase/menu/menu_payload.dart";

///cubit logic
class MenyushaCubit extends Cubit<MenyushaState> {
  static final Map<String, dynamic> json = {
    "titleSrc": "https://i.imgur.com/ipzpsgH.png",
    "designPreset": "SANTOKU",
    "positions": [
      {
        "id": "bandana-tshirt",
        "group": "t-shirt",
        "title": "BANDANA",
        "description": "Black t-shirt, bandana big logo, bandana small logo",
        "price": 1800,
        "output": ""
      },
      {
        "id": "burshtyn-tshirt",
        "group": "t-shirt",
        "title": "BURSHTYN",
        "description": "Black t-shirt, burshtyn big logo, burshtyn styled small logo",
        "price": 1800,
        "output": ""
      },
      {
        "id": "bandana-silver-tag",
        "group": "not for sale",
        "title": "BANDANA SILVER TAG",
        "description": "Silver bandana tag, epoxy",
        "price": 0,
        "output": "(s925 12g)"
      },
      {
        "id": "bandana-clipper-stand",
        "group": "not for sale",
        "title": "BANDANA CLIPPER STAND - LIMITED EDITION",
        "description": "3d printed stand for clipper lighters, bandana logo",
        "price": 0,
        "output": ""
      },
      {
        "id": "bandana-tag-keychain",
        "group": "not for sale",
        "title": "BANDANA TAG KEYCHAIN",
        "description": "3d printed keychain",
        "price": 0,
        "output": ""
      }
    ]
  };
  MenyushaCubit()
      : super(
          MenyushaState(
            activeMenu: MenuPayload(
                id: "",
                userId: "",
                publicId: "",
                title: "",
                menu: Menu.fromJson(json)),
          ),
        );
  final getIt = GetIt.instance;

  void addDish() {
    final currentDishes = state.activeMenu.menu.positions;

    final di = Position(
        id: "template-id",
        group: "template-group",
        title: "template-title",
        description: "template-description",
        price: 0.0,
        output: "template-output");

    currentDishes.add(di);

    final menu = state.activeMenu.menu.copyWith(positions: currentDishes);

    emit(state.copyWith(activeMenu: state.activeMenu.copyWith(menu: menu)));
  }

  void saveMenu({required final Menu menu}) {
    emit(state.copyWith(activeMenu: state.activeMenu.copyWith(menu: menu)));
  }
}
