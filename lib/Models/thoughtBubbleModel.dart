class PoemModel {
  static List<String> myPoems = [];
  static List<String> poemTitles = [];
  static List<String> poemAuthor = [];
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
