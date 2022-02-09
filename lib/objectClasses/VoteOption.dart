class VoteOption {

  late String title;
  late String description;
  late int total_tokens;

  VoteOption({ required String title, required String description}){
    this.title = title;
    this.description = description;
    total_tokens = 0;
  }

  int addToken() {
    total_tokens++;
    return total_tokens;
  }

  int removeToken() {
    total_tokens--;
    return total_tokens;
  }

  String getTotalTokens() {
    return total_tokens.toString();
  }

  void resetTokens() {
    total_tokens = 0;
  }
}