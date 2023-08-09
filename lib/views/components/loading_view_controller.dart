typedef RemoveLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

class LoadingViewController {
  final RemoveLoadingScreen onRemove;
  final UpdateLoadingScreen onUpdate;

  LoadingViewController({
    required this.onRemove,
    required this.onUpdate,
  });
}
