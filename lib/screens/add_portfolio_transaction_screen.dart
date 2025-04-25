import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPortfolioTransactionScreen extends StatefulWidget {
  final Map<String, dynamic> coin;

  const AddPortfolioTransactionScreen({super.key, required this.coin});

  @override
  State<AddPortfolioTransactionScreen> createState() =>
      _AddPortfolioTransactionScreenState();
}

class _AddPortfolioTransactionScreenState
    extends State<AddPortfolioTransactionScreen> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: const Color(0xFF348F6C)),
            ),
            child: child!,
          ),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Transaction', style: theme.textTheme.titleMedium),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Selected Coin", theme),
            const SizedBox(height: 4),
            Text(
              "${coin["name"]}/ ${coin["symbol"]}",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            _label("Total Spent", theme),
            const SizedBox(height: 6),
            _inputField(theme),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Quantity", theme),
                      const SizedBox(height: 6),
                      _inputField(theme),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Price per Token", theme),
                      const SizedBox(height: 6),
                      _inputField(theme),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _label("Date", theme),
            const SizedBox(height: 6),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _pickDate(context),
              style: theme.textTheme.bodyMedium,
              cursorColor: theme.primaryColor,
              decoration: _inputDecoration(theme).copyWith(
                hintText: "dd/mm/yyyy",
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF348F6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    // Handle transaction submission
                  },
                  child: const Text(
                    "Add Transaction",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),
    );
  }

  TextField _inputField(ThemeData theme) {
    return TextField(
      keyboardType: TextInputType.number,
      style: theme.textTheme.bodyMedium,
      cursorColor: theme.primaryColor,
      decoration: _inputDecoration(theme),
    );
  }

  InputDecoration _inputDecoration(ThemeData theme) {
    return InputDecoration(
      filled: true,
      fillColor: theme.cardColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 0.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade600, width: 0.6),
      ),
    );
  }
}
