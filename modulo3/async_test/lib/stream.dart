Stream<String> getStreamList() async* {
  yield 'masterclass';
  await Future.delayed(Duration(milliseconds: 500));
  yield 'flutterando';
}
