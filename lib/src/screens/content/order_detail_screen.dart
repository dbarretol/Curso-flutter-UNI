import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderDetailScreen extends StatefulWidget {
  final String idPedido;

  const OrderDetailScreen({super.key, required this.idPedido});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<dynamic> _orderDetails = [];

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    final response = await http.get(Uri.parse(
        'https://servicios.campus.pe/pedidosdetalle.php?idpedido=${widget.idPedido}'));

    if (response.statusCode == 200) {
      // Decodificar el cuerpo de la respuesta como UTF-8
      final decodedResponse = utf8.decode(response.bodyBytes);

      // Convertir la respuesta decodificada en JSON
      final List<dynamic> data = json.decode(decodedResponse);
      setState(() {
        _orderDetails = data;
      });
    } else {
      throw Exception('Error al cargar detalles del pedido');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Pedido ${widget.idPedido}'),
      ),
      body: _orderDetails.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Scroll horizontal
                    itemCount: _orderDetails.length,
                    itemBuilder: (context, index) {
                      final product = _orderDetails[index];

                      return Card(
                        margin: EdgeInsets.zero, // Eliminamos márgenes entre Cards
                        color: Colors.blueGrey[50], // Color de fondo del Card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Bordes redondeados
                        ),
                        child: Container(
                          width: screenWidth, // Ancho igual al de la pantalla
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://servicios.campus.pe/${product["imagenchica"]}',
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/nofoto.jpg', // Imagen de respaldo
                                    width: 250,
                                    height: 250,
                                  );
                                },
                              ),
                              const SizedBox(height: 10), // Separación entre imagen y texto
                              Text(
                                product["nombre"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Detalle: ${product["detalle"]}',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Cantidad: ${product["cantidad"]}',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Precio: S/ ${double.parse(product["precio"]).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
