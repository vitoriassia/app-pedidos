import 'package:flutter/material.dart';
import 'package:pedidos_app/core/state/ui_state.dart';
import 'package:pedidos_app/features/orders/model/create_order_model.dart';
import 'package:pedidos_app/shared/widgets/app_textfield.dart';
import 'package:pedidos_app/shared/widgets/title_widget.dart';
import 'package:pedidos_app/shared/widgets/ui_state_builder.dart';

class CreateOrderView extends StatefulWidget {
  final Future<UiState> Function(CreateOrderModel order) onSubmitForm;
  const CreateOrderView({super.key, required this.onSubmitForm});

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  UiState _submitState = InitialState();

  @override
  void dispose() {
    _customerController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final order = CreateOrderModel(
      description: _customerController.text.trim(),
      customerName: _productController.text.trim(),
    );

    setState(() => _submitState = LoadingState());

    final result = await widget.onSubmitForm(order);

    setState(() => _submitState = result);

    if (result is SuccessState) {
      _navigatePop();
    }
  }

  void _navigatePop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleWidget(title: 'Create Order'),

          const SizedBox(height: 16),
          UiStateBuilder(
            state: _submitState,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(controller: _customerController, label: 'Customer'),
                      const SizedBox(height: 16),
                      AppTextField(controller: _productController, label: 'Product'),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _quantityController,
                        label: 'Quantity',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter quantity';
                          final n = int.tryParse(value);
                          if (n == null || n <= 0) return 'Enter a valid quantity';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(onPressed: _submit, child: const Text('Submit')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
