import 'package:app_manutencao/services/calls_service.dart';
import 'package:app_manutencao/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PausedCallsWidget extends StatelessWidget {
  const PausedCallsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CallsService callsService = CallsService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chamados Pausados', style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w700, color: Colors.white),),
        backgroundColor: blueColor,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: callsService.searchPausedCalls(),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: const Color.fromARGB(255, 119, 119, 119),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No open calls found'));
          } else {
            final openCalls = snapshot.data!;
            return ListView.builder(
              itemCount: openCalls.length,
              itemBuilder: (context, index) {
                final call = openCalls[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Num: ${call['num   ']}',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Status: ${call['status']}',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),),
                      const SizedBox(height: 8),
                      Text(
                        'Setor: ${call['setor ']}',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'solicitante: ${call['solict']}',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Data Solicitação: ${call['dtsoli']}',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Adicione mais campos conforme necessário
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
