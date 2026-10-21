
import 'package:flutter/material.dart';

class BoneLabPage extends StatefulWidget {
  const BoneLabPage({super.key});

  @override
  State<BoneLabPage> createState() => _BoneLabPageState();
}

class _BoneLabPageState extends State<BoneLabPage> {
  final List<String> bones = ['bone_Neck', 'bone_Hips'];
  final TextEditingController searchController =
      TextEditingController();
  final TextEditingController renameController =
      TextEditingController();

  int currentIndex = -1;
  String message = 'اختر اسم عظمة وابدأ البحث';

  void searchBone() {
    final query = searchController.text.trim();

    setState(() {
      currentIndex = bones.indexOf(query);
      message = currentIndex >= 0
          ? 'تم العثور على: ${bones[currentIndex]}'
          : 'لم يتم العثور على الاسم';
    });
  }

  void findNext() {
    if (bones.isEmpty) return;

    setState(() {
      currentIndex = (currentIndex + 1) % bones.length;
      message = 'العنصر المحدد: ${bones[currentIndex]}';
      searchController.text = bones[currentIndex];
    });
  }

  void renameBone() {
    if (currentIndex < 0 || currentIndex >= bones.length) {
      setState(() => message = 'ابحث عن عنصر أولًا');
      return;
    }

    final newName = renameController.text.trim();

    if (newName.isEmpty) {
      setState(() => message = 'اكتب الاسم الجديد أولًا');
      return;
    }

    setState(() {
      final oldName = bones[currentIndex];
      bones[currentIndex] = newName;
      message = 'تم تغيير $oldName إلى $newName في النموذج التجريبي';
      searchController.text = newName;
      renameController.clear();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    renameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bone Lab')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'بحث واستبدال أسماء العظام - نموذج تجريبي',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'اسم العظمة للبحث',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: searchBone,
            child: const Text('Search'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: findNext,
            child: const Text('Find Next'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: renameController,
            decoration: const InputDecoration(
              labelText: 'الاسم الجديد',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: renameBone,
            child: const Text('Rename'),
          ),
          const SizedBox(height: 20),
          const Text(
            'العناصر التجريبية',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...bones.asMap().entries.map(
            (entry) => ListTile(
              selected: entry.key == currentIndex,
              leading: const Icon(Icons.accessibility_new),
              title: Text(entry.value),
              onTap: () {
                setState(() {
                  currentIndex = entry.key;
                  searchController.text = entry.value;
                  message = 'تم تحديد: ${entry.value}';
                });
              },
            ),
          ),
          const Divider(),
          Text(message),
        ],
      ),
    );
  }
}
