import 'package:flutter_test/flutter_test.dart';
import 'package:share_and_open_url/share_and_open_url.dart';
import 'package:share_and_open_url/share_and_open_url_platform_interface.dart';

import 'mock_share_and_open_url_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockShareAndOpenUrlPlatform mockShareAndOpenUrlPlatform;
  late ShareAndOpenUrl shareAndOpenUrl;

  setUp(() {
    mockShareAndOpenUrlPlatform = MockShareAndOpenUrlPlatform();
    ShareAndOpenUrlPlatform.instance = mockShareAndOpenUrlPlatform;
    shareAndOpenUrl = ShareAndOpenUrl();
  });

  group('ShareAndOpenUrl Tests', () {
    const testText = 'Hello, this is a test!';
    const testUrl = 'https://example.com';

    test('shareText calls the platform interface with correct parameters',
        () async {
      await shareAndOpenUrl.shareText(testText);

      expect(mockShareAndOpenUrlPlatform.lastSharedText, equals(testText));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isA<String>());
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isNotNull);
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isNotEmpty);
      expect(mockShareAndOpenUrlPlatform.lastSharedText, contains('test'));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, startsWith('Hello'));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, endsWith('test!'));
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        hasLength(testText.length),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        matches(RegExp(r'^Hello,.*!$')),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        equalsIgnoringCase('hello, this is a test!'),
      );
    });

    test('openUrl calls the platform interface with correct parameters',
        () async {
      await shareAndOpenUrl.openUrl(testUrl);

      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, equals(testUrl));
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isA<String>());
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isNotNull);
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isNotEmpty);
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, startsWith('https://'));
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, endsWith('.com'));
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, contains('example'));
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        hasLength(testUrl.length),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        matches(RegExp(r'^https:\/\/example\.com$')),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        equalsIgnoringCase('HTTPS://EXAMPLE.COM'),
      );
    });

    test('shareText with different text values', () async {
      const anotherTestText = 'Sharing a different text!';
      await shareAndOpenUrl.shareText(anotherTestText);

      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        equals(anotherTestText),
      );
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isA<String>());
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isNotNull);
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isNotEmpty);
      expect(mockShareAndOpenUrlPlatform.lastSharedText, contains('different'));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, startsWith('Sharing'));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, endsWith('text!'));
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        hasLength(anotherTestText.length),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        matches(RegExp(r'^Sharing.*text!$')),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        equalsIgnoringCase('sharing a different text!'),
      );
    });

    test('openUrl with different URL values', () async {
      const anotherTestUrl = 'https://another-example.com';
      await shareAndOpenUrl.openUrl(anotherTestUrl);

      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, equals(anotherTestUrl));
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isA<String>());
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isNotNull);
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isNotEmpty);
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, startsWith('https://'));
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, endsWith('.com'));
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        contains('another-example'),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        hasLength(anotherTestUrl.length),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        matches(RegExp(r'^https:\/\/another-example\.com$')),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        equalsIgnoringCase('HTTPS://ANOTHER-EXAMPLE.COM'),
      );
    });

    test('shareText with special characters', () async {
      const specialText = '@@@!!!###';
      await shareAndOpenUrl.shareText(specialText);

      expect(mockShareAndOpenUrlPlatform.lastSharedText, equals(specialText));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isA<String>());
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isNotNull);
      expect(mockShareAndOpenUrlPlatform.lastSharedText, isNotEmpty);
      expect(mockShareAndOpenUrlPlatform.lastSharedText, contains('@@@'));
      expect(mockShareAndOpenUrlPlatform.lastSharedText, endsWith('###'));
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        hasLength(specialText.length),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastSharedText,
        matches(RegExp(r'^@@@!!!###$')),
      );
    });

    test('openUrl with query parameters', () async {
      const urlWithParams = 'https://example.com?param1=value1&param2=value2';
      await shareAndOpenUrl.openUrl(urlWithParams);

      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, equals(urlWithParams));
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isA<String>());
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isNotNull);
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, isNotEmpty);
      expect(mockShareAndOpenUrlPlatform.lastOpenedUrl, startsWith('https://'));
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        contains('param1=value1'),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        contains('param2=value2'),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        hasLength(urlWithParams.length),
      );
      expect(
        mockShareAndOpenUrlPlatform.lastOpenedUrl,
        matches(
          RegExp(
            r'^https:\/\/example\.com\?param1=value1&param2=value2$',
          ),
        ),
      );
    });
  });
}
