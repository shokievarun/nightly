import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final MainController _mainController = Get.find();

  PaymentSelectionScreen({Key? key}) : super(key: key);
  void handlePaymentSelection(BuildContext context, String paymentType) {
    _mainController.saveLastSelectedPaymentType(paymentType);
    // Handle the selected payment type here
    Navigator.pop(context, paymentType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaymentOptionCard(
            paymentType: 'UPI',
            onPressed: () => handlePaymentSelection(context, 'UPI'),
          ),
          const SizedBox(height: 16),
          PaymentOptionCard(
            paymentType: 'Google Pay',
            onPressed: () => handlePaymentSelection(context, 'Google Pay'),
          ),
          const SizedBox(height: 16),
          PaymentOptionCard(
            paymentType: 'PhonePe',
            onPressed: () => handlePaymentSelection(context, 'PhonePe'),
          ),
          const SizedBox(height: 16),
          PaymentOptionCard(
            paymentType: 'Paytm',
            onPressed: () => handlePaymentSelection(context, 'Paytm'),
          ),
        ],
      ),
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final String paymentType;
  final VoidCallback onPressed;

  const PaymentOptionCard({
    Key? key,
    required this.paymentType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            paymentType,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
