import 'package:ccu_proj/screens/popUpPollOptionInfo.dart';
import 'package:flutter/material.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';

class TokensVoteOptionCard extends StatefulWidget {

  late VoteOption option;
  late Key key;
  final Function remove_token_left;
  final Function add_token_left;

  TokensVoteOptionCard({required this.option, required this.key, required this.remove_token_left, required this.add_token_left});

  @override
  State<TokensVoteOptionCard> createState() => _TokensVoteOptionCardState();
}

class _TokensVoteOptionCardState extends State<TokensVoteOptionCard> {

  int nr_tokens = 0;
  late popUpVoteOptionInfo optionInfo = popUpVoteOptionInfo(option: widget.option);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { optionInfo.addPollOptionsDialog(context);},
      child: Card(
        key: widget.key,
        child: Container(
          width: 1000,
          height: 70,
          decoration: BoxDecoration(
            color:Colors.lightBlue[50],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.option.title,
                style:const TextStyle(
                  fontSize: 20,),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 50,
                      onPressed: () {
                        widget.add_token_left();
                      }
                  ),
                  Text(
                      widget.option.getTotalTokens(),
                      style:const TextStyle(
                        fontSize: 35,)
                  ),
                  IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 50,
                      onPressed: () {
                        widget.remove_token_left();
                      }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}