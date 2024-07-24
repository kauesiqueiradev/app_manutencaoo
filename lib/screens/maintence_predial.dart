import 'dart:ui';

import 'package:app_manutencao/screens/calls/calls_completed_screens.dart';
import 'package:app_manutencao/screens/calls/open_calls_screen.dart';
import 'package:app_manutencao/screens/calls/paused_calls_widget.dart';
import 'package:app_manutencao/screens/calls/service_calls_screen.dart';
import 'package:app_manutencao/theme/theme.dart';
import 'package:app_manutencao/widgets/info_call_details_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MaintencePredial extends StatelessWidget {
  const MaintencePredial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manutenção Predial', style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w700, color: Colors.white),),
        backgroundColor: blueColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          //usuario
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            // decoration: BoxDecoration(
            //   color: Colors.blue,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 30,),
                ),
                const SizedBox(width: 16),
                const Text('Usuário', style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Box Informações Chamados

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
           
            // decoration: BoxDecoration(
            //   color: Colors.black38,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OpenCallsScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal:2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Column(                    
                          children: [
                            Text(
                              'Chamados Abertos', 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
                            ),
                            Text('030'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceCallsScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Column(                    
                          children: [
                            Text(
                              'Chamados Atendimento', 
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
                            ),
                            Text('030'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PausedCallsWidget()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Column(                    
                          children: [
                            Text(
                              'Chamados Pausados',
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
                            ),
                            Text('030'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CallsCompletedScreens()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Column(                    
                          children: [
                            Text(
                              'Chamados Finalizados',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
                            ),
                            Text('030'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



          const SizedBox(height: 16),

          // Chamados em Aberto
          Container(

            margin: const EdgeInsets.symmetric(horizontal: 16),
            //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            // decoration: BoxDecoration(
            //   color: Colors.blue,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Chamados em Aberto', style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OpenCallsScreen()));
                   }, 
                  child: const Text('Lista', style: TextStyle(fontSize: 16, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ],
            ),
          ), 

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: blueColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('001'),
                      Text("Soli: Igor"),
                      Text('TI'),
                      Text("Data: 20/12/2022"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('001'),
                      Text("Soli: Igor"),
                      Text('TI'),
                      Text("Data: 20/12/2022"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('001'),
                      Text("Soli: Igor"),
                      Text('TI'),
                      Text("Data: 20/12/2022"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('001'),
                      Text("Soli: Igor"),
                      Text('TI'),
                      Text("Data: 20/12/2022"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('001'),
                      Text("Soli: Igor"),
                      Text('TI'),
                      Text("Data: 20/12/2022"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),


          // Chamados em Atendimento   ------->>
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Chamados em Atendimento', style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //fixedSize: const Size(80, 30),
                    padding: const EdgeInsets.symmetric(horizontal:10, vertical: 0),
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceCallsScreen()));
                  }, 
                  child: const Text('Ver Todos', style: TextStyle(fontSize: 10, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ],
            ),
          ), 

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: blueColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
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
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Informações do Chamado', style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),),
                                    ElevatedButton(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 60),
                              
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Wrap(
                  spacing: 8, // Espaçamento horizontal entre os containers
                  runSpacing: 8, // Espaçamento vertical entre as linhas
                  children: List.generate(6, (index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 70) / 3, // Tamanho do container
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Column(
                          children: [
                            Text(
                              '001',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Artes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Maquina',
                            textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Ini: 24/07/2024', style: TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}