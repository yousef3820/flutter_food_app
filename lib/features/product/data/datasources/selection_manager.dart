// selection_manager.dart
class SelectionManager {
  final List<int> selectedToppingIds = [];
  final List<int> selectedSideOptionIds = [];
  double spicyLevel = 0.0;

  void toggleTopping(int id) {
    if (selectedToppingIds.contains(id)) {
      selectedToppingIds.remove(id);
    } else {
      selectedToppingIds.add(id);
    }
  }

  void toggleSideOption(int id) {
    if (selectedSideOptionIds.contains(id)) {
      selectedSideOptionIds.remove(id);
    } else {
      selectedSideOptionIds.add(id);
    }
  }

  void setSpicyLevel(double level) {
    spicyLevel = level;
  }

  void clearSelections() {
    selectedToppingIds.clear();
    selectedSideOptionIds.clear();
    spicyLevel = 0.0;
  }

  bool isToppingSelected(int id) => selectedToppingIds.contains(id);
  bool isSideOptionSelected(int id) => selectedSideOptionIds.contains(id);
}