import 'package:dio/dio.dart';

class CallsService {
  Dio dio = Dio();

  final callApi = 'http://172.16.50.12:9002/rest/zws_zmp';

  Future<List<dynamic>> searchOpenCalls() async {
    try {
      final response = await dio.get(callApi + '/get_all?');
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
      final response = await dio.get(callApi + '/get_all?');
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
      final response = await dio.get(callApi + '/get_all?');
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
      final response = await dio.get(callApi + '/get_all?');
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
}