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
        AppDesign.buildBlueOutlinedButtonText(
            text: "Create",
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

/*
class CreateMenuPayloadWidget extends StatefulWidget {
  final Function(MenuPayload) onCreate;
  final Function(MenuPayload) onPayloadChange;

  const CreateMenuPayloadWidget({
    Key? key,
    required this.onCreate,
    required this.onPayloadChange,
  }) : super(key: key);

  @override
  _CreateMenuPayloadWidgetState createState() =>
      _CreateMenuPayloadWidgetState();
}

class _CreateMenuPayloadWidgetState extends State<CreateMenuPayloadWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController titleSrcController = TextEditingController();
  final TextEditingController publicIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  DesignPreset selectedPreset = DesignPreset.BANDANA;
  List<Position> positions = [];

  bool showPositionForm = false;

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    titleController.addListener(_notifyChange);
    titleSrcController.addListener(_notifyChange);
    publicIdController.addListener(_notifyChange);
    userIdController.addListener(_notifyChange);
  }

  void _notifyChange() {
    final updatedPayload = _buildMenuPayload();
    widget.onPayloadChange(updatedPayload);
  }

  MenuPayload _buildMenuPayload() {
    return MenuPayload(
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Create New MenuPayload',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: publicIdController,
            decoration: InputDecoration(labelText: 'Public ID'),
          ),
          TextField(
            controller: userIdController,
            decoration: InputDecoration(labelText: 'User ID'),
          ),
          TextField(
            controller: titleSrcController,
            decoration: InputDecoration(labelText: 'Image Title Link'),
          ),
          DropdownButton<DesignPreset>(
            value: selectedPreset,
            onChanged: (preset) {
              setState(() {
                selectedPreset = preset!;
                _notifyChange();
              });
            },
            items: DesignPreset.values.map((preset) {
              return DropdownMenuItem(
                value: preset,
                child: Text(preset.name),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showPositionForm = true;
              });
            },
            child: Text('Add Position'),
          ),
          if (showPositionForm) _positionForm(),
          Column(
            children: positions.map((pos) {
              return ListTile(
                title: Text(pos.title),
                subtitle: Text("Group: ${pos.group}, Price: \$${pos.price}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => setState(() {
                    positions.remove(pos);
                    _notifyChange();
                  }),
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Handle cancel action, e.g., clear fields or navigate back
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newPayload = _buildMenuPayload();
                  widget.onCreate(newPayload);
                  // Optionally clear fields after creation
                },
                child: Text('Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _positionForm() {
    final TextEditingController groupController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController outputController = TextEditingController();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Add Position',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showPositionForm = false;
                    });
                  },
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
                      showPositionForm = false;
                      _notifyChange();
                    });
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    titleSrcController.dispose();
    publicIdController.dispose();
    userIdController.dispose();
    super.dispose();
  }
}

*/

class CreateMenuPayloadWidget extends StatefulWidget {
  final Function(MenuPayload) onCreate;
  final Function(MenuPayload) onPayloadChange;

  const CreateMenuPayloadWidget({
    Key? key,
    required this.onCreate,
    required this.onPayloadChange,
  }) : super(key: key);

  @override
  _CreateMenuPayloadWidgetState createState() => _CreateMenuPayloadWidgetState();
}

class _CreateMenuPayloadWidgetState extends State<CreateMenuPayloadWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController titleSrcController = TextEditingController();
  final TextEditingController publicIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  DesignPreset selectedPreset = DesignPreset.BANDANA;
  List<Position> positions = [];
  bool showPositionForm = false;

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    titleController.addListener(_notifyChange);
    titleSrcController.addListener(_notifyChange);
    publicIdController.addListener(_notifyChange);
    userIdController.addListener(_notifyChange);
  }

  void _notifyChange() {
    widget.onPayloadChange(_buildMenuPayload());
  }

  MenuPayload _buildMenuPayload() {
    return MenuPayload(
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create New MenuPayload',
            style: AppStyles.body3Style,
          ),
          const SizedBox(height: 12.0),
          _buildInputField(controller: titleController, label: 'Title'),
          _buildInputField(controller: publicIdController, label: 'Public ID'),
          _buildInputField(controller: userIdController, label: 'User ID'),
          _buildInputField(controller: titleSrcController, label: 'Image Title Link'),
          _buildDesignPresetDropdown(),
          const SizedBox(height: 12.0),
          _buildAddPositionButton(),
          if (showPositionForm) _positionForm(),
          const SizedBox(height: 12.0),
          _buildPositionList(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: AppStyles.inputDecoration.copyWith(labelText: label),
        style: AppStyles.labelTextStyle,
      ),
    );
  }

  Widget _buildDesignPresetDropdown() {
    return DropdownButton<DesignPreset>(
      value: selectedPreset,
      onChanged: (preset) {
        setState(() {
          selectedPreset = preset!;
          _notifyChange();
        });
      },
      items: DesignPreset.values.map((preset) {
        return DropdownMenuItem(
          value: preset,
          child: Text(preset.name, style: AppStyles.bodyStyle),
        );
      }).toList(),
    );
  }

  Widget _buildAddPositionButton() {
    return AppDesign.buildBlueOutlinedButtonText(
      onPressed: () => setState(() => showPositionForm = true),
      text: 'Add Position',
    );
  }

  Widget _positionForm() {
    final TextEditingController groupController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController outputController = TextEditingController();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Position', style: AppStyles.body2Style),
            _buildInputField(controller: groupController, label: 'Group'),
            _buildInputField(controller: titleController, label: 'Title'),
            _buildInputField(controller: descriptionController, label: 'Description'),
            _buildInputField(
              controller: priceController,
              label: 'Price',
            ),
            _buildInputField(controller: outputController, label: 'Output'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppDesign.buildBlueOutlinedButtonText(
                  onPressed: () => setState(() => showPositionForm = false),
                  text: 'Cancel',
                ),
                const SizedBox(width: 8.0),
                AppDesign.buildBlueOutlinedButtonText(
                  onPressed: () {
                    final newPosition = Position(
                      id: UniqueKey().toString(),
                      group: groupController.text,
                      title: titleController.text,
                      description: descriptionController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                      output: outputController.text,
                    );
                    setState(() {
                      positions.add(newPosition);
                      showPositionForm = false;
                      _notifyChange();
                    });
                  },
                  text: 'Add',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionList() {
    return Column(
      children: positions.map((pos) {
        return ListTile(
          title: Text(pos.title, style: AppStyles.bodyStyle),
          subtitle: Text("Group: ${pos.group}, Price: \$${pos.price}", style: AppStyles.footerStyle),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                positions.remove(pos);
                _notifyChange();
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppDesign.buildBlueOutlinedButtonText(
          onPressed: () {
            // Handle cancel action, e.g., clear fields or navigate back
          },
          text: 'Cancel',
        ),
        const SizedBox(width: 8.0),
        AppDesign.buildBlueOutlinedButtonText(
          onPressed: () {
            widget.onCreate(_buildMenuPayload());
            // Optionally clear fields after creation
          },
          text: 'Create',
        ),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    titleSrcController.dispose();
    publicIdController.dispose();
    userIdController.dispose();
    super.dispose();
  }
}

// Assuming the MenuPayload, Menu, DesignPreset, and Position classes are defined elsewhere.

