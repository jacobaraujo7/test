Future<List<String>> getFutureList() async {
  await Future.delayed(Duration(milliseconds: 500));
  return ['masterclass', 'flutterando'];
}
