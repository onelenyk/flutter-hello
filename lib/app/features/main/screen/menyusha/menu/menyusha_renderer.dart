import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/common/hover_button.dart";
import "package:menyusha/app/common/info_block.dart";
import "package:menyusha/app/common/responsive_util.dart";
import "package:markdown/markdown.dart" as md;
import "package:menyusha/app/features/main/screen/menyusha/a4_page_container.dart";

import "../../../../../data/firebase/menu/menu_payload.dart";
import "../../base/base_screen.dart";
import "../../base/mobile_frame.dart";
import "../../base/responsive_state.dart";
import "../theme/theme_manager.dart";

class MenuRendererWidget extends StatelessWidget {
  const MenuRendererWidget({
    super.key,
    required this.menu,
  });

  final Menu menu;

  @override
  Widget build(final BuildContext context) {
    final theme =
    MenuThemeManager.getTheme(menu.designPreset);

    return SelectionArea(
      child: SingleChildScrollView(
        child: A4PageContainer(
          color: theme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTitle(),
                SizedBox(height: 16),
                buildDishGroupWidget(menu.groupedPositions),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    final theme = MenuThemeManager.getTheme(menu.designPreset);

    if (menu.titleSrc.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 350,
            height: 100,
            child: Placeholder(
              color: Colors.redAccent,
              child: Center(
                child: Text(
                  "Add image",
                  style: theme.titleStyle,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.network(menu.titleSrc),
            width: 350,
            height: 100,
          )
        ],
      );
    }
  }

  Widget buildDishGroupWidget(final Map<String, List<Position>> groupedDishes) {
    final theme = MenuThemeManager.getTheme(menu.designPreset);

    if (groupedDishes.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Placeholder(
                  color: Colors.red.withAlpha(index * 10),
                  child: Center(
                    child: Text(
                      "Add Dishes",
                      style: theme.titleStyle,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );
    } else {
      return Column(
        children: groupedDishes.entries.map((final entry) {
          final group = entry.key;
          final dishes = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(group, style: theme.groupTitleStyle),
                ],
              ),
              ...dishes.map((final dish) => buildDishItem(dish)).toList(),
              SizedBox(height: 16), // Add some space between groups
            ],
          );
        }).toList(),
      );
    }
  }

  Widget buildDishItem(final Position dish) {
    final theme = MenuThemeManager.getTheme(menu.designPreset);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dish.title,
                style: theme.itemTitleStyle,
              ),
              Text(
                '\₴${dish.price}',
                style: theme.itemPriceStyle,
              ),
            ],
          ),
          SizedBox(height: 4),
          Text('${dish.description} ${dish.output}',
              style: theme.itemDescriptionStyle),
        ],
      ),
    );
  }
}

class MenuEditorWidget extends StatefulWidget {
  const MenuEditorWidget({
    super.key,
    required this.menu,
    required this.onSave,
  });

  final Menu menu;
  final ValueChanged<Menu> onSave;

  @override
  _MenuEditorState createState() => _MenuEditorState();
}

class _MenuEditorState extends State<MenuEditorWidget> {
  late TextEditingController _jsonController;

  @override
  void didUpdateWidget(MenuEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the menu has changed
    if (oldWidget.menu != widget.menu) {
      setState(() {
        // Update the text in the controller with the new menu data
        _jsonController.text = prettyPrintJson(widget.menu.toJson());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize with the current menu and set the controller to display the formatted JSON
    _jsonController = TextEditingController(
      text: prettyPrintJson(widget.menu.toJson()),
    );
  }

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  // Call this when the user clicks Save to return the updated model
  void _handleSave() {
    try {
      // Parse the JSON input and update the menu model
      final updatedJson = jsonDecode(_jsonController.text);
      final updatedMenu = Menu.fromJson(updatedJson);

      // Trigger the save callback with the updated model
      widget.onSave(updatedMenu);
    } catch (e) {
      // Handle JSON parsing errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid JSON: ${e.toString()}')),
      );
    }
  }

  // Call this when the user clicks Cancel to reset the input to the original model
  void _handleCancel() {
    setState(() {
      _jsonController.text = prettyPrintJson(widget.menu.toJson());
    });
  }

  // Helper function to format JSON
  String prettyPrintJson(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  '); // Indentation with 2 spaces
    return encoder.convert(json);
  }

  @override
  Widget build(BuildContext context) {
    final theme = MenuThemeManager.getTheme(widget.menu.designPreset);

    return A4PageContainer(
      color: theme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Input field for JSON
            Expanded(
              child: TextField(
                controller: _jsonController,
                maxLines: null,
                // Allows TextField to grow vertically
                expands: true,
                // Expands to fill the available height
                textAlign: TextAlign.start,

                style: theme.itemDescriptionStyle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit Menu JSON',
                ),
              ),
            ),
            SizedBox(height: 16),
            // Save and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HoverButton(
                  onTap: _handleCancel,
                  onDoubleTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      "cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDFD3C3),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                HoverButton(
                  onTap: _handleSave,
                  onDoubleTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDFD3C3),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
