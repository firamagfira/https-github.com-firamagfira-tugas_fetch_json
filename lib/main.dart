import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'todo_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late Future<List<Todo>> _futureTodos;

  @override
  void initState() {
    super.initState();
    // Jalankan pengunduhan data internet saat aplikasi HP pertama kali terbuka
    _futureTodos = TodoService().fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas PPB - Fetch JSON (200 Data)'), 
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<List<Todo>>(
        future: _futureTodos,
        builder: (context, snapshot) {
          // 1. Tampilan saat HP sedang loading download data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Tunggu ya, lagi download 200 data...'),
                ],
              ),
            );
          } 
          // 2. Tampilan jika HP kamu tidak konek internet / error
          else if (snapshot.hasError) {
            return Center(child: Text('Error Jaringan: ${snapshot.error}'));
          } 
          // 3. Tampilan saat data BERHASIL didownload dan siap muncul di HP
          else if (snapshot.hasData) {
            final listTodos = snapshot.data!;
            return ListView.builder(
              itemCount: listTodos.length,
              itemBuilder: (context, index) {
                final todo = listTodos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo[100],
                      child: Text('${todo.id}', style: const TextStyle(fontSize: 12)),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
                        color: todo.completed ? Colors.grey : Colors.black87,
                      ),
                    ),
                    subtitle: Text('User ID: ${todo.userId}'),
                    trailing: Icon(
                      todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: todo.completed ? Colors.green : Colors.amber,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Tidak ada data.'));
        },
      ),
    );
  }
}