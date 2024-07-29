import 'dart:async';

import 'package:dio/dio.dart';

class CallsService {
  Dio dio = Dio();

  final callApi = 'http://172.16.50.12:9002/rest/zws_zmp';

  final StreamController<int> _openCallsController = StreamController<int>();
  final StreamController<int> _serviceCallsController = StreamController<int>();
  final StreamController<int> _pausedCallsController = StreamController<int>();
  final StreamController<int> _completedCallsController = StreamController<int>();

  Stream<int> get openCallsStream => _openCallsController.stream;
  Stream<int> get serviceCallsStream => _serviceCallsController.stream;
  Stream<int> get pausedCallsStream => _pausedCallsController.stream;
  Stream<int> get completedCallsStream => _completedCallsController.stream;

  String getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  Future<void> fetchCallsCount() async {
    try {
      List<dynamic> openCalls = await searchOpenCalls();
      List<dynamic> serviceCalls = await searchServiceCalls();
      List<dynamic> pausedCalls = await searchPausedCalls();
      List<dynamic> completedCalls = await searchCompletedCalls();

      _openCallsController.add(openCalls.length);
      _serviceCallsController.add(serviceCalls.length);
      _pausedCallsController.add(pausedCalls.length);
      _completedCallsController.add(completedCalls.length);
    } catch (e) {
      _openCallsController.add(0);
      _serviceCallsController.add(0);
      _pausedCallsController.add(0);
      _completedCallsController.add(0);
    }
  }

  void dispose() {
    _openCallsController.close();
    _serviceCallsController.close();
    _pausedCallsController.close();
    _completedCallsController.close();
  }

  Future<List<dynamic>> searchOpenCalls() async {
    try {
      final response = await dio.get("$callApi/get_all?");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['objects'];
        return data
          .where((status) => status['status'] == '1')
          .toList();
      }
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> searchServiceCalls() async {
    try {
      final response = await dio.get("$callApi/get_all?");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['objects'];
        return data
          .where((status) => status['status'] == '3')
          .toList();

        // criar a validação de só exibir os chamados atendimento do usuario logado
      }
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> searchPausedCalls() async {
    try {
      final response = await dio.get("$callApi/get_all?");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['objects'];
        return data
          .where((status) => status['status'] == '2')
          .toList();

        // criar a validação de só exbir os chamados pausados do usuario logado 
      }
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> searchCompletedCalls() async {
    try {
      final response = await dio.get("$callApi/get_all?");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['objects'];
        return data
          .where((status) => status['status'] == '4')
          .toList();

        // criar a validação de só exibir os chamados finalizados do usuario logado
      }
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> putServiceCall(String num) async {
    try {
      final response = await dio.put(
        '$callApi/update' , 
        data: {
          'num': num, // NUMERO DO CHAMADO
          'status': '3', // ALTERAR O STATUS DO CHAMADO PARA 3
          'mecani': '020201',
          'dtini': getFormattedDate(), // SALVAR A DATA ATUAL
          'hrini': "${DateTime.now().hour}:${DateTime.now().minute}" // SALVAR A HORA ATUAL
        }
      );
      if (response.statusCode != 200) {
        throw Exception('Falha ao atualizar o chamado');
      }
      else {
        
      }
    } catch (e) {
      throw Exception('Erro ao realizar PUT request: $e');
    }
  }

// para pausar o chamado
  Future<void> putPausedCall(String num) async {
    try {
      final response = await dio.put(
        '$callApi/update' , 
        data: {
          'num': num, // NUMERO DO CHAMADO
          'status': '2', // ALTERAR O STATUS DO CHAMADO PARA 3
          'dtipsa': getFormattedDate(), // SALVAR A DATA ATUAL
          'hripsa': "${DateTime.now().hour}:${DateTime.now().minute}" // SALVAR A HORA ATUAL
        }
      );
      if (response.statusCode != 200) {
        throw Exception('Falha ao Pausar o chamado');
      }
      else {
        return response.data;
      }
    } catch (e) {
      throw Exception('Erro ao realizar PUT request: $e');
    }
  }

// para finalizar a pausa do chamado
  Future<void> putPausedFinishedCall(String num) async {
    try {
      final response = await dio.put(
        '$callApi/update' , 
        data: {
          'num': num, // NUMERO DO CHAMADO
          'status': '3', // ALTERAR O STATUS DO CHAMADO PARA 3
          'dtfpsa': getFormattedDate(), // SALVAR A DATA ATUAL
          'hrfpsa': "${DateTime.now().hour}:${DateTime.now().minute}" // SALVAR A HORA ATUAL
        }
      );
      if (response.statusCode != 200) {
        throw Exception('Falha ao Pausar o chamado');
      }
      else {
        return response.data;
      }
    } catch (e) {
      throw Exception('Erro ao realizar PUT request: $e');
    }
  }

  Future<void> putCompletedCall(String num) async {
    try {
      final response = await dio.put(
        '$callApi/update' , 
        data: {
          'num': num, // NUMERO DO CHAMADO
          'status': '4', // ALTERAR O STATUS DO CHAMADO PARA 3
          'dtfim': getFormattedDate(), // SALVAR A DATA ATUAL
          'hrfim': "${DateTime.now().hour}:${DateTime.now().minute}" // SALVAR A HORA ATUAL
        }
      );
      if (response.statusCode != 200) {
        throw Exception('Falha ao Pausar o chamado');
      }
      else {
        
      }
    } catch (e) {
      throw Exception('Erro ao realizar PUT request: $e');
    }
  }
}