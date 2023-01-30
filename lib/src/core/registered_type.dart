/// A data holder for Type-registered objects.
class RegisteredType<O> {
  RegisteredType({
    this.decode,
    this.encode,
  });

  final O Function(Map<String, dynamic> jsonData)? decode;
  final Map<String, dynamic> Function(O object)? encode;
}
