import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'sender': 'admin', 'text': 'Selamat datang di chat COVID Tracker!'},
  ];

  void _sendMessage() {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'text': messageText});
        _controller.clear();

        // Automatic responses
        String response = '';
        if (messageText.toLowerCase() == 'halo') {
          response = 'Halo! Ada yang bisa saya bantu?';
        } else if (messageText.toLowerCase() == 'info') {
          response = 'Informasi COVID-19: Tetap jaga jarak dan pakai masker.';
        } else if (messageText.toLowerCase() == 'ambulance') {
          response = 'Ambulance telah dikirim. Harap tunggu sebentar.';
        }

        if (response.isNotEmpty) {
          // Simulate delay for response
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              _messages.add({'sender': 'admin', 'text': response});
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Chat Admin',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green[800], // Warna header yang lebih gelap
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isAdmin = message['sender'] == 'admin';
                final avatarUrl = isAdmin
                    ? 'assets/images/admi.png' // Admin avatar
                    : 'assets/images/jon.png'; // User avatar

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: isAdmin
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: <Widget>[
                      if (isAdmin) // Avatar admin
                        CircleAvatar(
                          backgroundImage: AssetImage(avatarUrl),
                        ),
                      if (isAdmin) SizedBox(width: 8.0),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isAdmin
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: <Widget>[
                            if (isAdmin || !isAdmin) // Nama pengirim
                              Text(
                                isAdmin ? 'Admin' : 'You',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            SizedBox(height: 4.0),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.75, // Max width for bubble chat
                              ),
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: isAdmin ? Colors.green[100] : Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4.0,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                message['text']!,
                                style: TextStyle(
                                  color: isAdmin ? Colors.black : Colors.green[800],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, // Limit text to 2 lines
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isAdmin) SizedBox(width: 8.0),
                      if (!isAdmin) // Avatar user
                        CircleAvatar(
                          backgroundImage: AssetImage(avatarUrl),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      focusColor: Colors.green,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1)
                      ),
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Kirim',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700], // Warna tombol kirim
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
