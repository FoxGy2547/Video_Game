import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const VideoGameApp());
}

class VideoGame {
  final String title;
  final int rating;
  final DateTime releaseDate;
  final String genre;

  VideoGame({
    required this.title,
    required this.rating,
    required this.releaseDate,
    required this.genre,
  });
}

class VideoGameApp extends StatelessWidget {
  const VideoGameApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Game App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'วิดีโอเกม'),
    );
  }
}

// HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<VideoGame> games = [];

  IconData _getGenreIcon(String genre) {
    switch (genre) {
      case 'Action':
        return Icons.local_fire_department;
      case 'Adventure':
        return Icons.explore;
      case 'Sports':
        return Icons.sports_soccer;
      case 'Simulation':
        return Icons.computer;
      case 'Platformer':
        return Icons.run_circle;
      case 'RPG':
        return Icons.shield;
      case 'First Person Shooter':
        return Icons.remove_red_eye;
      case 'Action-Adventure':
        return Icons.directions_run;
      case 'Fighting':
        return Icons.sports_mma;
      case 'Real-Time Strategy':
        return Icons.hourglass_top;
      case 'Racing':
        return Icons.directions_car;
      case 'Shooter':
        return Icons.gps_fixed;
      case 'Puzzle':
        return Icons.extension;
      case 'Casual':
        return Icons.tag_faces;
      case 'Strategy':
        return Icons.account_tree;
      case 'MMORPG':
        return Icons.group;
      case 'Stealth':
        return Icons.visibility_off;
      case 'Party':
        return Icons.celebration;
      case 'Action RPG':
        return Icons.bolt;
      case 'Tactical RPG':
        return Icons.account_tree;
      case 'Survival':
        return Icons.health_and_safety;
      case 'Battle Royale':
        return Icons.person_pin_circle;
      default:
        return Icons.videogame_asset;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: games.isEmpty
          ? const Center(
              child:
                  Text('ยินดีต้อนรับเข้าสู่แอพวิดีโอเกม กรุณาเพิ่มข้อมูลเกม.'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  return Dismissible(
                    key: Key(game.title),
                    onDismissed: (direction) {
                      setState(() {
                        games.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${game.title} ถูกลบออกเรียบร้อย')),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(game.title),
                        subtitle: Text(
                            'คะแนนรีวิว: ${game.rating} | ประเภทของเกม: ${game.genre}'),
                        trailing: Icon(
                          _getGenreIcon(game.genre),
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newGame = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
          if (newGame != null) {
            setState(() {
              games.add(newGame);
            });
          }
        },
        tooltip: 'เพิ่มเกม',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _ratingController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedGenre;

  final List<String> genres = [
    'Action',
    'Adventure',
    'Sports',
    'Simulation',
    'Platformer',
    'RPG',
    'First Person Shooter',
    'Action-Adventure',
    'Fighting',
    'Real-Time Strategy',
    'Racing',
    'Shooter',
    'Puzzle',
    'Casual',
    'Strategy',
    'MMORPG',
    'Stealth',
    'Party',
    'Action RPG',
    'Tactical RPG',
    'Survival',
    'Battle Royale',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newGame = VideoGame(
        title: _titleController.text,
        rating: int.parse(_ratingController.text),
        releaseDate: _selectedDate!,
        genre: _selectedGenre!,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ยืนยันข้อมูลเกม'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ชื่อเกม: ${newGame.title}'),
                Text('คะแนนรีวิว: ${newGame.rating}'),
                Text(
                    'วันที่ออก: ${DateFormat.yMMMd().format(newGame.releaseDate)}'),
                Text('ประเภท: ${newGame.genre}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, newGame);
                },
                child: const Text('ยืนยัน'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มวิดีโอเกม'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'ชื่อเกม'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อเกม';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ratingController,
                decoration:
                    const InputDecoration(labelText: 'คะแนนรีวิว (0-10)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกคะแนนรีวิว';
                  }
                  final rating = int.tryParse(value);
                  if (rating == null || rating < 0 || rating > 10) {
                    return 'กรุณากรอกระหว่าง 0 กับ 10';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(_selectedDate == null
                    ? 'เลือก วัน/เดือน/ปี ที่เกมออก'
                    : 'วันที่เกมออก : ${DateFormat.yMMMd().format(_selectedDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGenre,
                decoration: const InputDecoration(labelText: 'ประเภทของเกม'),
                items: genres.map((String genre) {
                  return DropdownMenuItem<String>(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGenre = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'กรุณาเลือกประเภทของเกม';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('เพิ่มเกม'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
