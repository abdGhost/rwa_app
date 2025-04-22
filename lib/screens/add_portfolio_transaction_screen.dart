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
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF348F6C),
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Transaction',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selected Coin",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              "${coin["name"]}/ ${coin["symbol"]}",
              style: const TextStyle(
                color: Color(0xFF111111),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Total Spent",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            const SizedBox(height: 6),
            TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        decoration: _inputDecoration(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price per Token",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        decoration: _inputDecoration(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Date",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _pickDate(context),
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: _inputDecoration().copyWith(
                hintText: "dd/mm/yyyy",
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const Spacer(),
            Center(
              child: Container(
                width: 372,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF348F6C),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A4937).withOpacity(0.2),
                      offset: const Offset(0, 3),
                      blurRadius: 1,
                    ),
                    BoxShadow(
                      color: const Color(0xFF1A4937).withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {
                      // Handle transaction submission
                    },
                    child: const Center(
                      child: Text(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey, width: 0.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey, width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey, width: 0.4),
      ),
    );
  }
}
