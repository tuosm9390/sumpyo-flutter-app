import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../providers/prescription_provider.dart";

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TextEditingController();
  String _selectedStyle = "F";

  @override
  Widget build(BuildContext context) {
    final prescriptionsAsync = ref.watch(prescriptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("숨표 AI"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "오늘의 고민을 들려주세요...",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _styleButton("공감형", "F"),
                    _styleButton("이성형", "T"),
                    _styleButton("온기형", "W"),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    if (_controller.text.isNotEmpty) {
                      ref.read(prescriptionNotifierProvider.notifier).generatePrescription(
                        _controller.text,
                        _selectedStyle,
                      );
                      _controller.clear();
                    }
                  },
                  child: const Text("처방전 조제하기"),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: prescriptionsAsync.when(
              data: (prescriptions) => ListView.builder(
                itemCount: prescriptions.length,
                itemBuilder: (context, index) {
                  final p = prescriptions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(p.title),
                      subtitle: Text(p.quote),
                      onTap: () {
                        HapticFeedback.selectionClick();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(p.title),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(p.content),
                                const SizedBox(height: 20),
                                Text(
                                  p.quote,
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("닫기"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("오류가 발생했습니다: $err")),
            ),
          ),
        ],
      ),
    );
  }

  Widget _styleButton(String label, String code) {
    final isSelected = _selectedStyle == code;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          HapticFeedback.selectionClick();
          setState(() {
            _selectedStyle = code;
          });
        }
      },
    );
  }
}
