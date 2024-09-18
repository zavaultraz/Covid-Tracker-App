import 'dart:async';
import 'package:flutter/material.dart';

class HandWashScreen extends StatefulWidget {
  @override
  _HandWashScreenState createState() => _HandWashScreenState();
}

class _HandWashScreenState extends State<HandWashScreen> {
  final List<Map<String, String>> _steps = [
    {'text': 'Langkah 1: Basahi tangan Anda dengan air bersih yang mengalir (hangat atau dingin), matikan kran, dan aplikasikan sabun.', 'image': 'assets/images/step1.png'},
    {'text': 'Langkah 2: Berbusa dengan menggosokkan tangan Anda bersama dengan sabun. Berbusa di punggung tangan, di antara jari, dan di bawah kuku.', 'image': 'assets/images/step2.png'},
    {'text': 'Langkah 3: Gosok tangan Anda selama setidaknya 20 detik. Butuh timer? Nyanyikan lagu “Selamat Ulang Tahun” dari awal hingga akhir dua kali.', 'image': 'assets/images/step3.png'},
    {'text': 'Langkah 4: Bilas tangan Anda dengan air bersih yang mengalir.', 'image': 'assets/images/step4.png'},
    {'text': 'Langkah 5: Keringkan tangan Anda dengan handuk bersih atau biarkan udara kering.', 'image': 'assets/images/step5.png'},
  ];

  int _currentStep = 0;
  final int _stepDuration = 10; // durasi untuk setiap langkah dalam detik
  late Timer _stepTimer;
  int _remainingTime = 10;
  bool _isStarted = false;

  void _startGuide() {
    setState(() {
      _isStarted = true;
      _currentStep = 0;
      _remainingTime = _stepDuration;
    });

    _stepTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        if (_currentStep < _steps.length - 1) {
          setState(() {
            _currentStep++;
            _remainingTime = _stepDuration;
          });
        } else {
          timer.cancel();
          setState(() {
            _currentStep = _steps.length; // Untuk menampilkan tombol "Finish"
          });
        }
      }
    });
  }

  void _finish() {
    Navigator.pop(context); // Contoh aksi saat tombol "Finish" ditekan, bisa diubah sesuai kebutuhan
  }

  @override
  void dispose() {
    _stepTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Panduan Mencuci Tangan',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: !_isStarted
              ? Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/open.png', // Gambar intro
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                'Mari mencuci tangan',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _startGuide,
                child: Text('Mulai',style: TextStyle(color: Colors.white,fontSize: 50),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,

                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size(500, 40), // Ukuran tombol yang diperbesar
                ),
              ),
            ],
          )
              : _currentStep < _steps.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  _steps[_currentStep]['image']!,
                  width: 400,
                  height: 400,
                ),
              ),
              Text(
                _steps[_currentStep]['text']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.green,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Sisa waktu: $_remainingTime detik',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600],fontWeight: FontWeight.bold),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/close.png', // Gambar "Thank You"
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                'Tangan kamu sudah bersih sekarang!',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _finish,
                child: Text('Selesai',style: TextStyle(color: Colors.white,fontSize: 50)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,

                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size(400, 40), // Ukuran tombol yang diperbesar
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
