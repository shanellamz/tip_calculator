// tip_calculator app
import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) => double.tryParse(input.trim());

({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController = TextEditingController();
  int _percent = 15;
  int _people = 1;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(_billController.text);
    final isValid = bill != null && bill >= 0;
    final result = isValid ? computeTip(bill, _percent) : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _billController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Bill amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 10, label: Text('10%')),
                ButtonSegment(value: 15, label: Text('15%')),
                ButtonSegment(value: 20, label: Text('20%')),
              ],
              selected: {_percent},
              onSelectionChanged: (selection) {
                setState(() => _percent = selection.first);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Split between'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed:
                      _people > 1 ? () => setState(() => _people--) : null,
                ),
                Text('$_people'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _people++),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (result == null)
              const Text('Enter a valid amount')
            else ...[
              Text(
                'Tip: ${result.tip.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Total: ${result.total.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Per person: ${(result.total / _people).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}