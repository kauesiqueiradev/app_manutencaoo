import 'package:app_manutencao/screens/calls/calls_completed_screens.dart';
import 'package:app_manutencao/screens/calls/open_calls_screen.dart';
import 'package:app_manutencao/screens/calls/paused_calls_screen.dart';
import 'package:app_manutencao/screens/calls/service_calls_screen.dart';
import 'package:app_manutencao/services/calls_service.dart';
import 'package:app_manutencao/theme/theme.dart';
import 'package:app_manutencao/widgets/paused_call_list_widget.dart';
import 'package:app_manutencao/widgets/service_call_details_widget.dart';
import 'package:flutter/material.dart';

class MaintencePredial extends StatefulWidget {
  const MaintencePredial({super.key});

  @override
  State<MaintencePredial> createState() => _MaintencePredialState();
}

class _MaintencePredialState extends State<MaintencePredial> {
  int openCallsCount = 0;
  int serviceCallsCount = 0;
  int pausedCallsCount = 0;
  int completedCallsCount = 0;

  final CallsService callsService = CallsService();

  @override
  void initState() {
    super.initState();
    _fetchCallsCount();
  }

  Future<void> _fetchCallsCount() async {
     try {
      List<dynamic> openCalls = await callsService.searchOpenCalls();
      List<dynamic> serviceCalls = await callsService.searchServiceCalls();
      List<dynamic> pausedCalls = await callsService.searchPausedCalls();
      List<dynamic> completedCalls = await callsService.searchCompletedCalls();
      
      setState(() {
        openCallsCount = openCalls.length;
        serviceCallsCount = serviceCalls.length;
        pausedCallsCount = pausedCalls.length;
        completedCallsCount = completedCalls.length;
      });
    } catch (e) {
      setState(() {
        openCallsCount = 0;
        openCallsCount = 0;
        serviceCallsCount = 0;
        pausedCallsCount = 0;
        completedCallsCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manutenção Predial', style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w700, color: Colors.white),),
        backgroundColor: blueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  _buildInfoBox(
                    context,
                    'Chamados Abertos',
                    openCallsCount,
                    const OpenCallsScreen(),
                  ),
                  _buildInfoBox(
                    context,
                    'Chamados Atendimento',
                    serviceCallsCount,
                    const ServiceCallsScreen(),
                  ),
                  _buildInfoBox(
                    context,
                    'Chamados Pausados',
                    pausedCallsCount,
                    const PausedCallsScreen(),
                  ),
                  _buildInfoBox(
                    context,
                    'Chamados Finalizados',
                    completedCallsCount,
                    const CallsCompletedScreens(),
                  ),
                  
                ],
              ),
            ),
        
            const SizedBox(height: 16),
        
            // Chamados em Atendimento
            _buildSectionHeader(context, 'Chamados em Atendimento', const ServiceCallsScreen()),
            const ServiceCallDetailsWidget( ),

            const SizedBox(height: 16),

            // Chamados Pausados   ------->>
            _buildSectionHeader(context, 'Chamados Pausados', const PausedCallsScreen()),
            const PausedCallListWidget( ),
          ]
        ),
      ),
    );
  }
}


  Widget _buildInfoBox(BuildContext context, String title, int count, Widget screen) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Center(
          child: Column(                    
            children: [
              Text(
                title, 
                textAlign: TextAlign.center, 
                style: const TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
              ),
              Text(count.toString(),
              style: const TextStyle(fontSize: 12, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildSectionHeader(BuildContext context, String title, Widget screen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: blueColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
            },
            child: const Text(
              'Ver Todos',
              style: TextStyle(fontSize: 10, fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
