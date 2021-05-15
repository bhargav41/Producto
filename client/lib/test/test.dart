import 'package:client/services/noteService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/services/tokenService.dart';

void main() {
  group('Token', () {
    test('validate token', () async {
      expectLater(await TokenService().verifyToken() is bool, true);
    });
  });
}
