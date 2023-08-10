extension RemoveAll on String {
  String removeAll(Iterable<String> patternList) => patternList.fold(
        this,
        (previousValue, element) => previousValue.replaceAll(element, ''),
      );
}
