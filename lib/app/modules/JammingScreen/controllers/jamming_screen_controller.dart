import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class JammingScreenController extends GetxController {
  var selectedCategory = ''.obs;
  var selectedCategoryIndex = 0.obs;
  var selectedSong = ''.obs;
  var selectedSongIndex = (-1).obs;
  var isPlaying = false.obs;
  var isSearching = false.obs;
  var isLoading = true.obs;
  var spotifyTracks = [].obs;
  var categories = [].obs;
  var filteredTracks = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpotifyTracks();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      clearSearch();
    }
  }

  void clearSearch() {
    filteredTracks.assignAll(spotifyTracks.where((track) => track['category'] == selectedCategory.value).toList());
  }

  Future<void> filterSongs(String query) async {
    if (query.isEmpty) {
      clearSearch();
    } else {
      isLoading.value = true;

      final String url = 'https://meet-around-apis-production.up.railway.app/spotify/search?query=$query&limit=10';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);

          filteredTracks.assignAll(data.map((track) {
            return {
              'name': track['name'],
              'uri': track['url'],
              'images': [{'url': track['image']}],
              'artist': '', // Artist information is not in the response, so leaving it empty
              'album': '',  // Album information is not in the response, so leaving it empty
            };
          }).toList());

          print("Filtered tracks count: ${filteredTracks.length}");
        } else {
          Get.snackbar("Error", "Failed to load search results. Status code: ${response.statusCode}");
          print('Failed to load search results. Status code: ${response.statusCode}');
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred while searching: $e");
        print(e);
      } finally {
        isLoading.value = false; // Hide loading indicator after search
      }
    }
  }

  void setSelectedSong(String song) {
    selectedSong.value = song;
  }

  void togglePlaying() {
    isPlaying.value = !isPlaying.value;
  }

  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex.value = index;
    selectedCategory.value = categories[index];
    filteredTracks.assignAll(spotifyTracks.where((track) => track['category'] == selectedCategory.value).toList());
  }

  void setSelectedSongIndex(int index) {
    selectedSongIndex.value = index;
  }

  Future<void> openSpotifyTrack(String spotifyUri, {bool isArtist = false}) async {
    final Uri spotifyUrl = Uri.parse(spotifyUri);
    final Uri spotifyWebUrl = Uri.parse(spotifyUri);
    final Uri playStoreUrl = Uri.parse("https://play.google.com/store/apps/details?id=com.spotify.music");

    print("Spotify URI: $spotifyUri");
    print("Spotify web URL: $spotifyWebUrl");

    try {
      await launchUrl(
        spotifyWebUrl,
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      Get.snackbar("Error", "An error occurred while launching: $e");
      print(e);
    }
  }

  Future<void> fetchSpotifyTracks() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://meet-around-apis-production.up.railway.app/spotify/tracks'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        spotifyTracks.clear();
        categories.clear();
        for (var item in data) {
          spotifyTracks.add({
            'name': item['name'],
            'uri': item['url'],
            'images': [{'url': item['image']}],
            'category': item['category'],
          });

          if (!categories.contains(item['category'])) {
            categories.add(item['category']);
          }
        }

        // Set default category and playlists
        if (categories.isNotEmpty) {
          selectedCategory.value = categories[0];
          filteredTracks.assignAll(spotifyTracks.where((track) => track['category'] == selectedCategory.value).toList());
        }

        print('Number of categories fetched: ${categories.length}');
      } else {
        Get.snackbar("Error", "Failed to load tracks from Spotify. Status code: ${response.statusCode}");
        print('Failed to load tracks from Spotify. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching tracks: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
