import 'package:app_manutencao/services/calls_service.dart';
import 'package:app_manutencao/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ServiceCallDetailsWidget extends StatefulWidget {
  const ServiceCallDetailsWidget({super.key});

  @override
  State<ServiceCallDetailsWidget> createState() => _ServiceCallDetailsWidgetState();
}

class _ServiceCallDetailsWidgetState extends State<ServiceCallDetailsWidget> {
 void showPopup(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resultado'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {

    final CallsService callsService = CallsService();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          FutureBuilder<List<dynamic>>(
            future: callsService.searchServiceCalls(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black38, width: 2),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Loading...'),
                                    SizedBox(height: 8),
                                    Text('Loading...'),
                                    SizedBox(height: 8),
                                    Text('Loading...'),
                                    SizedBox(height: 8),
                                    Text('Loading...'),
                                    SizedBox(height: 8),
                                    Text('Loading...'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Sem chamados em Atendimento'));
              } else {
                final openCalls = snapshot.data!.take(5).toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: openCalls.length,
                    itemBuilder: (context, index) {
                      final call = openCalls[index];
                      return Container(
                        margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black38, width: 2),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 400,
                                color: Colors.amber,
                                child: Scaffold(
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Informações do Chamado Aberto', style: TextStyle(fontSize: 16, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              child: const Text('Pausar Chamado'),
                                              onPressed: () async {
                                                  try {
                                                    print("Chamado Aceitar clicado"); // Adicione esta linha
                                                    await callsService.putPausedCall(call['num   '] ?? '');
                                                    print("Chamado iniciado com sucesso"); // Adicione esta linha
                                                    showPopup(context, 'Chamado iniciado com sucesso.');
                                                  } catch (e) {
                                                    print("Erro ao iniciar o chamado: $e"); // Adicione esta linha
                                                    showPopup(context, 'Erro ao iniciar o chamado: $e');
                                                  }
                                                  Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('Finalizar Chamado'),
                                              onPressed: () async {
                                                  try {
                                                    print("Chamado Aceitar clicado"); // Adicione esta linha
                                                    await callsService.putCompletedCall(call['num   '] ?? '');
                                                    print("Chamado iniciado com sucesso"); // Adicione esta linha
                                                    showPopup(context, 'Chamado iniciado com sucesso.');
                                                  } catch (e) {
                                                    print("Erro ao iniciar o chamado: $e"); // Adicione esta linha
                                                    showPopup(context, 'Erro ao iniciar o chamado: $e');
                                                  }
                                                  Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 60),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Numero do Chamado: ${call['num   ']}',),
                                            Text('Setor: ${call['setor ']}'),
                                            Text('Soli: ${call['solict']}'),
                                            Text('Dt Soli: ${call['dtini ']}',),
                                            Text('Hora da Solicitação: ${call['hrini ']}'),
                                            Text('Problema: ${call['objeti']}'),
                                            Text('Observações: ${call['obs   ']}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${call['num   ']}',
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12
                                ),
                              ),
                              Text(
                                'Setor: ${call['setor ']}',
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12
                                ),
                              ),
                              Text(
                                'Soli: ${call['solict']}',
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12
                                ),
                              ),
                              Text(
                                'Dt Soli: ${call['dtini ']}',
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
//  @override
//   Widget build(BuildContext context) {
//     CallsService callsService = CallsService();
//     return FutureBuilder<List<dynamic>>(
//       future: searchServiceCalls(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Erro: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('Nenhum chamado em atendimento.'));
//         }

//         List<dynamic> serviceCalls = snapshot.data!;

//         return ListView.builder(
//           itemCount: serviceCalls.length,
//           itemBuilder: (context, index) {
//             final call = serviceCalls[index];
//             return ListTile(
//               title: Text('Chamado ${call['id']}'),
//               subtitle: Text('Descrição: ${call['description']}'),
//               trailing: Text('Status: ${call['status']}'),
//             );
//           },
//         );
//       },
//     );
//   }

