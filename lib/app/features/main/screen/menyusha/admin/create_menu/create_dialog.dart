import "package:flutter/material.dart";

import "../../../../../../data/firebase/menu/menu_payload.dart";
import "../../theme/app_style.dart";

class CreateMenuPayloadDialog extends StatefulWidget {
  final Function(MenuPayload) onCreate;

  const CreateMenuPayloadDialog({Key? key, required this.onCreate})
      : super(key: key);

  @override
  _CreateMenuPayloadDialogState createState() =>
      _CreateMenuPayloadDialogState();
}

class _CreateMenuPayloadDialogState extends State<CreateMenuPayloadDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController titleSrcController = TextEditingController();
  final TextEditingController publicIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  DesignPreset selectedPreset = DesignPreset.BANDANA;
  List<Position> positions = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New MenuPayload'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title Source'),
            ),
            // Public ID
            TextField(
              controller: publicIdController,
              decoration: InputDecoration(labelText: 'Public ID'),
            ),
            // User ID
            TextField(
              controller: userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            // Design Preset Dropdown
            DropdownButton<DesignPreset>(
              value: selectedPreset,
              onChanged: (preset) {
                setState(() {
                  selectedPreset = preset!;
                });
              },
              items: DesignPreset.values.map((preset) {
                return DropdownMenuItem(
                  value: preset,
                  child: Text(preset.name),
                );
              }).toList(),
            ),
            // Positions
            // Title Source
            TextField(
              controller: titleSrcController,
              decoration: InputDecoration(labelText: 'Image title link'),
            ),

            ElevatedButton(
              onPressed: () => _addPositionDialog(),
              child: Text('Add Position'),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: positions.map((pos) {
                  return ListTile(
                    title: Text(pos.title),
                    subtitle:
                    Text("Group: ${pos.group}, Price: \$${pos.price}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => setState(() => positions.remove(pos)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        AppDesign.buildBlueOutlinedButton(
            child: Text(
              'Create',
              style: AppStyles.blueOutlinedButtonTextStyle,
            ),
            onPressed: () {
              final newPayload = MenuPayload(
                id: "",
                publicId: publicIdController.text,
                userId: userIdController.text,
                title: titleController.text,
                menu: Menu(
                  designPreset: selectedPreset,
                  titleSrc: titleSrcController.text,
                  positions: positions,
                ),
              );
              widget.onCreate(newPayload);
              Navigator.pop(context);
            })
      ],
    );
  }

  Future<void> _addPositionDialog() async {
    final TextEditingController groupController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController outputController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Position'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: groupController,
                decoration: InputDecoration(labelText: 'Group'),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: outputController,
                decoration: InputDecoration(labelText: 'Output'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newPosition = Position(
                id: UniqueKey().toString(),
                group: groupController.text,
                title: titleController.text,
                description: descriptionController.text,
                price: double.parse(priceController.text),
                output: outputController.text,
              );
              setState(() {
                positions.add(newPosition);
              });
              Navigator.pop(context);
            },
            child: Text('Add Position'),
          ),
        ],
      ),
    );
  }
}
