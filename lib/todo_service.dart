import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo_model.dart';

class TodoService {
  static const String url = 'https://jsonplaceholder.typicode.com/todos';

  // Fungsi mengambil data dari internet
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // Mengubah kumpulan JSON menjadi List data Todo untuk HP
      return body.map((dynamic item) => Todo.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mendownload data dari internet!');
    }
  }
}