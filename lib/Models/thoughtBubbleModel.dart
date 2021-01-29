class PoemModel {
  static List<String> myPoems = [];
  static List<String> poemAuthor = [];
  static List<String> poemTitles = [];
  void addAuthor(String author) {
    poemAuthor.add(author);
  }

  void addPoem(String poem) {
    myPoems.add(poem);
  }

  void addTitle(String poemTitle) {
    poemTitles.add(poemTitle);
  }
}
