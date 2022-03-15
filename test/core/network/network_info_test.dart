import 'package:appsolute_news/core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test(
      'should forward the call to Connectivity.checkConnectivity',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => Future.value(ConnectivityResult.wifi));
        // act
        final result = networkInfo.isConnected;
        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(await result, await tHasConnectionFuture);
      },
    );
  });
}
