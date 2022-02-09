import 'package:ccu_proj/objectClasses/PollOption.dart';

class PollList {
  late List <PollOption> options;

  PollList( {required List <PollOption> options}){
    this.options = options;
  }

  void addoptions(PollOption op) {
    options.add(op);
  }
}