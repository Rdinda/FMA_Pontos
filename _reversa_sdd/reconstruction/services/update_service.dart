import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:logger/logger.dart';

class UpdateInfo {
  final String version;
  final String url;
  final String changelog;
  final bool hasUpdate;
  final String? sha256;

  UpdateInfo({
    required this.version,
    required this.url,
    required this.changelog,
    required this.hasUpdate,
    this.sha256,
  });
}

class UpdateService {
  static const String _repoOwner = 'Rdinda';
  static const String _repoName = 'FMA_Pontos';

  static final Logger _logger = Logger();

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
          List<dynamic> assets = data['assets'] ?? [];
          
          dynamic apkAsset;
          for (var asset in assets) {
            if (asset['name'].toString().endsWith('.apk')) {
              apkAsset = asset;
              break;
            }
          }

          if (apkAsset != null) {
            downloadUrl = apkAsset['browser_download_url'];
          }

          _logger.i('Download URL: $downloadUrl');

          // Attempt to fetch SHA256 checksum
          String? sha256;

          // 1. Try to find a .sha256 asset
          dynamic sha256Asset;
          for (var asset in assets) {
            final name = asset['name'].toString().toLowerCase();
            if (name.endsWith('.sha256') || name.endsWith('.apk.sha256')) {
              sha256Asset = asset;
              break;
            }
          }

          if (sha256Asset != null) {
            try {
              final sha256Url = sha256Asset['browser_download_url'];
              _logger.i('Downloading SHA256 from asset: $sha256Url');
              final shaRes = await http.get(Uri.parse(sha256Url));
              if (shaRes.statusCode == 200) {
                final content = shaRes.body.trim();
                final match = RegExp(r'([a-fA-F0-9]{64})').firstMatch(content);
                if (match != null) {
                  sha256 = match.group(1);
                  _logger.i('SHA256 checksum found in asset: $sha256');
                }
              }
            } catch (e, stackTrace) {
              _logger.w('Failed to fetch SHA256 asset', error: e, stackTrace: stackTrace);
            }
          }

          // 2. Fallback: Parse release body (changelog) for SHA256 pattern
          if (sha256 == null && data['body'] != null) {
            final body = data['body'] as String;
            final regExp = RegExp(
              r'(?:SHA-256|SHA256|sha-256|sha256|hash|checksum)[\s:=]+([a-fA-F0-9]{64})',
              caseSensitive: false,
            );
            final match = regExp.firstMatch(body);
            if (match != null) {
              sha256 = match.group(1);
              _logger.i('SHA256 checksum parsed from release body: $sha256');
            }
          }

          return UpdateInfo(
            version: latestVersion,
            url: downloadUrl,
            changelog: data['body'] ?? '',
            hasUpdate: true,
            sha256: sha256,
          );
        }
      } else {
        _logger.w(
          'GitHub API request failed with status: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
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
