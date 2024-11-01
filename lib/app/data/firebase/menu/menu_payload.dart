
import "package:menyusha/app/data/repository/base_model.dart";

enum DesignPreset {
  BANDANA,
  SANTOKU,
  BBQ,
  BOSTON,
  VOLGA,
  CUSTOM;

  // Convert enum to string
  String toJson() => name;

  // Convert string back to enum
  static DesignPreset fromJson(String json) => DesignPreset.values.byName(json);
}

class MenuPayload implements BaseModel {
  MenuPayload({
    required this.id,
    required this.publicId,
    required this.userId,
    required this.title,
    required this.menu,
  });// Generate a unique ID if not provided

  @override
  final String id;
  final String publicId;
  final String userId;
  final String title;
  final Menu menu;

  MenuPayload copyWith({
    String? id,
    String? publicId,
    String? userId,
    String? title,
    Menu? menu,
  }) =>
      MenuPayload(
        id: id ?? this.id,
        publicId: publicId ?? this.publicId,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        menu: menu ?? this.menu,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'publicId': publicId,
    'userId': userId,
    'title': title,
    'menu': menu?.toJson(),
  };

  factory MenuPayload.fromJson(Map<String, dynamic> json) {
    try {
      return MenuPayload(
        id: json['id'] as String,
        publicId: json['publicId'] as String,
        userId: json['userId'] as String,
        title: json['title'] as String,
        menu: Menu.fromJson(json['menu'] as Map<String, dynamic>),
      );
    } catch (e) {
      throw FormatException("Invalid JSON format for MenuHolder: $e");
    }
  }

  @override
  BaseModel copyWithId({String? id}) {
    return copyWith(id: id);
  }
}

class Menu {
  Menu({
    required this.designPreset,
    required this.titleSrc,
    required this.positions,
  });

  final DesignPreset designPreset;
  final String titleSrc;
  final List<Position> positions;

  Map<String, List<Position>> get groupedPositions {
    final grouped = <String, List<Position>>{};
    for (final dish in positions) {
      if (grouped.containsKey(dish.group)) {
        grouped[dish.group]!.add(dish);
      } else {
        grouped[dish.group] = [dish];
      }
    }
    return grouped;
  }
  Menu copyWith({
    DesignPreset? designPreset,
    String? titleSrc,
    List<Position>? positions,
  }) =>
      Menu(
        designPreset: designPreset ?? this.designPreset,
        titleSrc: titleSrc ?? this.titleSrc,
        positions: positions ?? this.positions,
      );
  Map<String, dynamic> toJson() => {
    'designPreset': designPreset.toJson(),
    'titleSrc': titleSrc,
    'positions': positions.map((pos) => pos.toJson()).toList(),
  };
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      designPreset: DesignPreset.fromJson(json['designPreset'] as String),
      titleSrc: json['titleSrc'] as String,
      positions: (json['positions'] as List<dynamic>)
          .map((item) => Position.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Position {
  Position({
    required this.id,
    required this.group,
    required this.title,
    required this.description,
    required this.price,
    required this.output,
  });
  final String id;
  final String group;
  final String title;
  final String description;
  final double price;
  final String output;
  Position copyWith({
    String? id,
    String? group,
    String? title,
    String? description,
    double? price,
    String? output,
  }) =>
      Position(
        id: id ?? this.id,
        group: group ?? this.group,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        output: output ?? this.output,
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'group': group,
    'title': title,
    'description': description,
    'price': price,
    'output': output,
  };
  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'] as String,
      group: json['group'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      output: json['output'] as String,
    );
  }
}