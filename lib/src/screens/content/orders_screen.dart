import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/order_detail_screen.dart';
import 'package:myapp/utils/app_colors.dart';
//import 'order_detail_screen.dart'; // pantalla del detalle

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<dynamic> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final response =
        await http.get(Uri.parse('https://servicios.campus.pe/pedidos.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _orders = data;
      });
    } else {
      throw Exception('Error al cargar pedidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: _orders.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  color: AppColors.primaryVariant,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'Pedido: ${order["idpedido"]}',
                      style: const TextStyle(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha: ${order["fechapedido"]}',
                            style: const TextStyle(color: AppColors.onPrimary)),
                        Text('Usuario: ${order["usuario"]}',
                            style: const TextStyle(color: AppColors.onPrimary)),
                        Text('Cliente: ${order["nombres"]}',
                            style: const TextStyle(color: AppColors.onPrimary)),
                        Text(
                            'Total: S/ ${double.parse(order["total"]).toStringAsFixed(2)}',
                            style: const TextStyle(color: AppColors.onPrimary)),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailScreen(idPedido: order["idpedido"]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
