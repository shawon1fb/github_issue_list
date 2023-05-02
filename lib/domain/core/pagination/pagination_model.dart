class PaginationModel<T> {
  int page;
  int totalPages;
  List<T> list;

  int get nextPage {
    if (page == 0) {
      return 1;
    } else if (page >= totalPages) {
      return totalPages;
    } else if (page < totalPages) {
      return page + 1;
    } else if (list.isEmpty) {
      return page;
    }

    return page;
  }

  PaginationModel({
    required this.page,
    required this.totalPages,
    required this.list,
  });
}
