enum ErrorCode {
  unknown(1),
  phoneExists(2);

  const ErrorCode(this.code);

  final int code;

  static ErrorCode fromInt(int value) => ErrorCode.values.firstWhere(
        (element) => element.code == value,
        orElse: () => unknown,
      );

  @override
  String toString() => 'ErrorCode: $code $name';
}
