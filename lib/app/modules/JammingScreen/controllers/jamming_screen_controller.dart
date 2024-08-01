import 'package:get/get.dart';

class JammingScreenController extends GetxController {
  var selectedSong = ''.obs;
  var itemcount=7.obs;
  var isPlaying = false.obs;
  var selectedSongIndex = (-1).obs;

  void setSelectedSong(String song) {
    selectedSong.value = song;
  }

  void togglePlaying() {
    isPlaying.value = !isPlaying.value;
  }

  void setSelectedSongIndex(int index) {
    selectedSongIndex.value = index;
  }
}
