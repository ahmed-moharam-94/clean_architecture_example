extension NonNullString on String? {
  String ifNullReturnEmpty() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int ifNullReturnZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
