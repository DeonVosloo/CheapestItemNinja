class Test
{
  String testing;

  Test({required this.testing});

  Test.fromMap(Map<String, dynamic> result)
      : testing = result["testing"];

  Map<String, Object> toMap() {
    return
      {
        'testing': testing,
      };
  }

}