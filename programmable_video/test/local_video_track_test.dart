import 'package:flutter_test/flutter_test.dart';
import 'package:twilio_programmable_video/src/parts.dart';
import 'package:twilio_programmable_video_platform_interface/twilio_programmable_video_platform_interface.dart';

import 'mock_platform_interface.dart';

void main() {
  MockInterface? mockInterface;
  setUpAll(() {
    mockInterface = MockInterface();
    ProgrammableVideoPlatform.instance = mockInterface!;
  });

  group('LocalVideoTrack()', () {
    test('should not construct without enabled', () async {
      expect(
        () => LocalVideoTrack(
          null,
          CameraCapturer(const CameraSource('BACK_CAMERA', false, false, false)),
        ),
        throwsAssertionError,
      );
    });
  });

  group('.enable()', () {
    test('should call interface code to enable the track', () async {
      final localVideoTrack = LocalVideoTrack(
        true,
        CameraCapturer(const CameraSource('BACK_CAMERA', false, false, false)),
      );
      await localVideoTrack.enable(false);

      expect(mockInterface!.enableVideoTrackWasCalled, true);
    });
  });

  group('.isEnabled()', () {
    test('should return correct value', () async {
      const constructionBool = true;
      final localVideoTrack = LocalVideoTrack(
        constructionBool,
        CameraCapturer(const CameraSource('BACK_CAMERA', false, false, false)),
      );
      expect(localVideoTrack.isEnabled, constructionBool);
      await localVideoTrack.enable(!constructionBool);
      expect(localVideoTrack.isEnabled, !constructionBool);
    });
  });
}
