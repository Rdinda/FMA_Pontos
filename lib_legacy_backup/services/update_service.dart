import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import 'package:logger/logger.dart';

class UpdateInfo {
  final String version;
  final String url;
  final String changelog;
  final bool hasUpdate;

  UpdateInfo({
    required this.version,
    required this.url,
    required this.changelog,
    required this.hasUpdate,
  });
}

class UpdateService {
  static const String _repoOwner = 'Rdinda';
  static const String _repoName = 'FMA_Pontos';

  static final Logger _logger = Logger();

  // Use this for debugging/testing to force an update availability
  // static const String? _forceCurrentVersion = "0.0.1"; // TEMPORARY: Remove after testing

  static Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      _logger.i('Checking for updates - Current version: $currentVersion');

      final response = await http.get(
        Uri.parse(
          'https://api.github.com/repos/$_repoOwner/$_repoName/releases/latest',
        ),
      );

      _logger.i('GitHub API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String tagName = data['tag_name'];
        final String latestVersion = tagName.startsWith('v')
            ? tagName.substring(1)
            : tagName;

        _logger.i('Latest version from GitHub: $latestVersion');

        final hasUpdate = _compareVersions(currentVersion, latestVersion);
        _logger.i('Has update available: $hasUpdate');

        if (hasUpdate) {
          // Find the apk asset if available, or fall back to html_url
          String downloadUrl = data['html_url'];
          List<dynamic> assets = data['assets'];
          final apkAsset = assets.firstWhere(
            (asset) => asset['name'].toString().endsWith('.apk'),
            orElse: () => null,
          );

          if (apkAsset != null) {
            downloadUrl = apkAsset['browser_download_url'];
          }

          _logger.i('Download URL: $downloadUrl');

          return UpdateInfo(
            version: latestVersion,
            url: downloadUrl,
            changelog: data['body'] ?? '',
            hasUpdate: true,
          );
        }
      } else {
        _logger.w(
          'GitHub API request failed with status: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      // Log error using Logger
      _logger.e(
        'Error checking for updates: $e',
        error: e,
        stackTrace: stackTrace,
      );
    }
    return null;
  }

  static bool _compareVersions(String current, String latest) {
    try {
      List<int> c = current.split('.').map(int.parse).toList();
      List<int> l = latest.split('.').map(int.parse).toList();

      for (int i = 0; i < 3; i++) {
        int cVal = i < c.length ? c[i] : 0;
        int lVal = i < l.length ? l[i] : 0;
        if (lVal > cVal) return true;
        if (lVal < cVal) return false;
      }
    } catch (e, stackTrace) {
      _logger.w('Version comparison failed', error: e, stackTrace: stackTrace);
    }
    return false;
  }
}
