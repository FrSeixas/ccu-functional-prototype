import 'package:ccu_proj/objectClasses/PollTypes.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';

class PollOption {
   late String title;
   late String description;
   late String endDate;
   late String group;
   late PollTypes pollType;
   late List <VoteOption> options;

  PollOption({ required String title, required String description, required String endDate, required String group, required PollTypes pollType, required List<VoteOption> options}) {
    this.title = title;
    this.description = description;
    this.endDate = endDate;
    this.group = group;
    this.pollType = pollType;
    this.options = options;
  }

  List<VoteOption> getOptions (){
    return this.options;
  }
}