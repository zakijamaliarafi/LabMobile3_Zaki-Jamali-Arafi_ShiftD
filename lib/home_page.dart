import 'package:flutter/material.dart';
import 'package:list_tugas/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Jadwal {
  String mataKuliah;
  String hari;
  TimeOfDay jamMulai;
  TimeOfDay jamBerakhir;
  String ruangan;

  Jadwal({
    required this.mataKuliah,
    required this.hari,
    required this.jamMulai,
    required this.jamBerakhir,
    required this.ruangan,
  });

  // Mengubah objek Jadwal menjadi JSON
  Map<String, dynamic> toJson() => {
    'mataKuliah': mataKuliah,
    'hari': hari,
    'jamMulai': '${jamMulai.hour}:${jamMulai.minute}',
    'jamBerakhir': '${jamBerakhir.hour}:${jamBerakhir.minute}',
    'ruangan': ruangan,
  };

  // Membuat objek Jadwal dari JSON
  factory Jadwal.fromJson(Map<String, dynamic> json) {
    List<String> jamMulaiParts = json['jamMulai'].split(':');
    List<String> jamBerakhirParts = json['jamBerakhir'].split(':');
    return Jadwal(
      mataKuliah: json['mataKuliah'],
      hari: json['hari'],
      jamMulai: TimeOfDay(hour: int.parse(jamMulaiParts[0]), minute: int.parse(jamMulaiParts[1])),
      jamBerakhir: TimeOfDay(hour: int.parse(jamBerakhirParts[0]), minute: int.parse(jamBerakhirParts[1])),
      ruangan: json['ruangan'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? namauser;
  List<Jadwal> jadwalList = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadJadwal();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = prefs.getString('username');
    });
  }

  void _loadJadwal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jadwalJson = prefs.getString('jadwal');
    if (jadwalJson != null) {
      List<dynamic> decodedJson = jsonDecode(jadwalJson);
      setState(() {
        jadwalList = decodedJson.map((item) => Jadwal.fromJson(item)).toList();
      });
    }
  }

  void _saveJadwal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jadwalJson = jsonEncode(jadwalList.map((jadwal) => jadwal.toJson()).toList());
    await prefs.setString('jadwal', jadwalJson);
  }

  void _tambahJadwal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String mataKuliah = '';
        String hari = '';
        TimeOfDay jamMulai = TimeOfDay.now();
        TimeOfDay jamBerakhir = TimeOfDay.now();
        String ruangan = '';

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Tambah Jadwal'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Mata Kuliah'),
                      onChanged: (value) {
                        mataKuliah = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Hari'),
                      onChanged: (value) {
                        hari = value;
                      },
                    ),
                    TextButton(
                      child: Text('Jam Mulai: ${jamMulai.format(context)}'),
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: jamMulai,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            jamMulai = selectedTime;
                          });
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Jam Berakhir: ${jamBerakhir.format(context)}'),
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: jamBerakhir,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            jamBerakhir = selectedTime;
                          });
                        }
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Ruangan'),
                      onChanged: (value) {
                        ruangan = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Simpan'),
                  onPressed: () {
                    this.setState(() {
                      jadwalList.add(Jadwal(
                        mataKuliah: mataKuliah,
                        hari: hari,
                        jamMulai: jamMulai,
                        jamBerakhir: jamBerakhir,
                        ruangan: ruangan,
                      ));
                    });
                    _saveJadwal();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editJadwal(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String mataKuliah = jadwalList[index].mataKuliah;
        String hari = jadwalList[index].hari;
        TimeOfDay jamMulai = jadwalList[index].jamMulai;
        TimeOfDay jamBerakhir = jadwalList[index].jamBerakhir;
        String ruangan = jadwalList[index].ruangan;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Jadwal'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Mata Kuliah'),
                      controller: TextEditingController(text: mataKuliah),
                      onChanged: (value) {
                        mataKuliah = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Hari'),
                      controller: TextEditingController(text: hari),
                      onChanged: (value) {
                        hari = value;
                      },
                    ),
                    TextButton(
                      child: Text('Jam Mulai: ${jamMulai.format(context)}'),
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: jamMulai,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            jamMulai = selectedTime;
                          });
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Jam Berakhir: ${jamBerakhir.format(context)}'),
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: jamBerakhir,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            jamBerakhir = selectedTime;
                          });
                        }
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Ruangan'),
                      controller: TextEditingController(text: ruangan),
                      onChanged: (value) {
                        ruangan = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Simpan'),
                  onPressed: () {
                    this.setState(() {
                      jadwalList[index] = Jadwal(
                        mataKuliah: mataKuliah,
                        hari: hari,
                        jamMulai: jamMulai,
                        jamBerakhir: jamBerakhir,
                        ruangan: ruangan,
                      );
                    });
                    _saveJadwal();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _hapusJadwal(int index) {
    setState(() {
      jadwalList.removeAt(index);
    });
    _saveJadwal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'),
      ),
      body: ListView.builder(
        itemCount: jadwalList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jadwalList[index].mataKuliah),
            subtitle: Text('${jadwalList[index].hari}, ${jadwalList[index].jamMulai.format(context)} - ${jadwalList[index].jamBerakhir.format(context)}, ${jadwalList[index].ruangan}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editJadwal(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _hapusJadwal(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwal,
        child: Icon(Icons.add),
      ),
      drawer: const Sidemenu(),
    );
  }
}