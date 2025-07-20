import 'package:flutter/material.dart';
import 'package:testing/userclass.dart';
import 'package:testing/userfunc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Variabel untuk menyimpan input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 32, 34),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            textt('ALL USER'),
            users.isEmpty
                ? CircularProgressIndicator()
                : Text(
                    users.length.toString(),
                    style: TextStyle(color: Colors.blueAccent, fontSize: 28),
                  ),
            textt('ONLINE USER'),
            useronline.isEmpty
                ? CircularProgressIndicator()
                : Text(
                    useronline.length.toString(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 90, 255, 68),
                        fontSize: 28),
                  ),
            textt('OFFLINE USER'),
            userofflineReal.isEmpty
                ? CircularProgressIndicator()
                : Text(
                    userofflineReal.length.toString(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 68, 68),
                        fontSize: 28),
                  ),
                  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: textt('~~~~~~hanya untuk userman ros V7~~~~~~~\nData yang diambil saya contohkan hanya user / nama, untuk codingan bisa dirubah untuk menampilkan atribut yang lain di class dan function\nuntuk menampilkan data bisa diambil dari list'),
                ),
            SizedBox(
              height: 150,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  await getUsers();
                  await getUserOnline();
                  await getUserOffline();
                  setState(() {});
                },
                label: Text('Get Data')),
                
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSettingDialog(context);
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _modernTextField({
    required TextEditingController controller,
    required String label,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        fillColor: const Color(0xFF23272A),
        filled: true,
      ),
    );
  }

  Widget textt(String value) {
    return Text(
      value,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  void showSettingDialog(BuildContext context) {
    // Controller input
    final ipController = TextEditingController(text: ipAddress);
    final userController = TextEditingController(text: username);
    final passController = TextEditingController(text: password);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C2F33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Pengaturan Router',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pastikan port HTTP aktif, atau isikan port jika menggunakan custom.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                _modernTextField(controller: ipController, label: 'IP Address'),
                const SizedBox(height: 10),
                _modernTextField(controller: userController, label: 'Username'),
                const SizedBox(height: 10),
                _modernTextField(
                  controller: passController,
                  label: 'Password',
                  obscure: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: textt('Tutup'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7289DA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  ipAddress = ipController.text;
                  username = userController.text;
                  password = passController.text;
                });
                print(ipAddress);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
