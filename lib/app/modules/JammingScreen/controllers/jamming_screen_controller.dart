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
  var spotifyPlaylists = [].obs;
  var categories = [].obs;
  var filteredTracks = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpotifyCategoriesWithPlaylists();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      clearSearch();
    }
  }

  void clearSearch() {
    filteredTracks.assignAll(spotifyPlaylists[selectedCategoryIndex.value]['playlists']);
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

          // Update the filteredTracks list with the search results
          filteredTracks.assignAll(data.map((track) {
            return {
              'name': track['name'],
              'uri': track['uri'],
              'images': track['album']['images'],
              'artist': track['artists'][0]['name'],
              'album': track['album']['name'],
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
    filteredTracks.assignAll(spotifyPlaylists[index]['playlists']);
  }

  void setSelectedSongIndex(int index) {
    selectedSongIndex.value = index;
  }

  Future<void> openSpotifyTrack(String spotifyUri, {bool isArtist = false}) async {
    final Uri spotifyUrl = Uri.parse(spotifyUri);
    final Uri spotifyWebUrl = isArtist
        ? Uri.parse("https://open.spotify.com/artist/${spotifyUri.split(':').last}")
        : Uri.parse("https://open.spotify.com/playlist/${spotifyUri.split(':').last}");
    final Uri playStoreUrl = Uri.parse("https://play.google.com/store/apps/details?id=com.spotify.music");

    print("Spotify URI: $spotifyUri");
    print("Spotify web URL: $spotifyWebUrl");

    try {
      // if (await canLaunch(spotifyUrl.toString())) {
      //   await launch(spotifyUrl.toString(), forceSafariVC: false, forceWebView: false);
      // } else {
      //   await launch(spotifyWebUrl.toString(), forceSafariVC: false, forceWebView: false);
      // }
      await launchUrl(
        spotifyWebUrl,
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      // if (await canLaunch(playStoreUrl.toString())) {
      //   await launch(playStoreUrl.toString());
      // } else {
      //   Get.snackbar("Error", "Could not launch Spotify, web link, or Play Store");
      // }
      // print(e);
      Get.snackbar("Error", "An error occurred while launching: $e");
      print(e);
    }
  }


  Future<void> fetchSpotifyCategoriesWithPlaylists() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://meet-around-apis-production.up.railway.app/spotify/categories-with-playlists'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        spotifyPlaylists.clear();
        categories.clear();
        for (var item in data) {
          categories.add(item['categoryName']);
          spotifyPlaylists.add(item);
        }

        // Set default category and playlists
        if (categories.isNotEmpty) {
          selectedCategory.value = categories[0];
          filteredTracks.assignAll(spotifyPlaylists[0]['playlists']);
        }

        print('Number of categories fetched: ${categories.length}');
      } else {
        Get.snackbar("Error", "Failed to load categories from Spotify. Status code: ${response.statusCode}");
        print('Failed to load categories from Spotify. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching categories: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
