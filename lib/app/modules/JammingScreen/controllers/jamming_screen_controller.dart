import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JammingScreenController extends GetxController {
  var selectedSong = ''.obs;
  var itemCount = 7.obs;
  var isPlaying = false.obs;
  var selectedSongIndex = (-1).obs;
  var songs = <Map<String, dynamic>>[].obs;

  AudioPlayer audioPlayer = AudioPlayer();
  String apiKey = 'YOUR_FMA_API_KEY';

  @override
  void onInit() {
    super.onInit();
    fetchSongs();
  }

  void setSelectedSong(String song) {
    selectedSong.value = song;
    playSong(song);
  }

  void togglePlaying() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
    isPlaying.value = !isPlaying.value;
  }

  void setSelectedSongIndex(int index) {
    selectedSongIndex.value = index;
  }

  void playSong(String url) async {
    await audioPlayer.play(UrlSource(url));
    isPlaying.value = true;
  }

  void stopSong() {
    audioPlayer.stop();
    isPlaying.value = false;
  }

  void fetchSongs() async {
    final response = await http.get(Uri.parse(
        'https://freemusicarchive.org/api/get/tracks?api_key=$apiKey&limit=20'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['dataset'];
      songs.value = data.map((track) => {
        'title': track['track_title'],
        'artist': track['artist_name'],
        'url': track['track_file_url']
      }).toList();
    } else {
      // Handle the error
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
