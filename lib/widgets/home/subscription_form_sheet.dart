import 'package:btg_bank/models/fund.dart';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:flutter/material.dart';

class SubscriptionFormData {
  const SubscriptionFormData({
    required this.notificationMethod,
    required this.destination,
  });

  final NotificationMethod notificationMethod;
  final String destination;
}

class SubscriptionFormSheet extends StatefulWidget {
  const SubscriptionFormSheet({super.key, required this.fund});

  final Fund fund;

  @override
  State<SubscriptionFormSheet> createState() => _SubscriptionFormSheetState();
}

class _SubscriptionFormSheetState extends State<SubscriptionFormSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _destinationController = TextEditingController();
  NotificationMethod _selectedMethod = NotificationMethod.email;

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + insets.bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Suscribirse a ${widget.fund.name}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<NotificationMethod>(
              initialValue: _selectedMethod,
              decoration: const InputDecoration(
                labelText: 'Metodo de notificacion',
                border: OutlineInputBorder(),
              ),
              items: const <DropdownMenuItem<NotificationMethod>>[
                DropdownMenuItem<NotificationMethod>(
                  value: NotificationMethod.email,
                  child: Text('Email'),
                ),
                DropdownMenuItem<NotificationMethod>(
                  value: NotificationMethod.sms,
                  child: Text('SMS'),
                ),
              ],
              onChanged: (NotificationMethod? value) {
                if (value == null) {
                  return;
                }
                setState(() => _selectedMethod = value);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: _selectedMethod == NotificationMethod.email
                    ? 'Correo electronico'
                    : 'Numero celular',
                border: const OutlineInputBorder(),
              ),
              validator: (String? value) {
                final String text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Este campo es obligatorio.';
                }
                if (_selectedMethod == NotificationMethod.email) {
                  const String emailPattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                  if (!RegExp(emailPattern).hasMatch(text)) {
                    return 'Ingresa un correo valido.';
                  }
                } else {
                  if (!RegExp(r'^\d{10,13}$').hasMatch(text)) {
                    return 'Ingresa un celular valido (10 a 13 digitos).';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  Navigator.of(context).pop(
                    SubscriptionFormData(
                      notificationMethod: _selectedMethod,
                      destination: _destinationController.text.trim(),
                    ),
                  );
                },
                child: const Text('Confirmar suscripcion'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
