import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthnowapp/src/data/data.dart';
import 'package:healthnowapp/src/data/messaging_provider.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final String img;
  final String name;
  final String senderId;
  final String receiverId;
  final String meetingLink;

  const ChatScreen({
    Key? key,
    required this.img,
    required this.name,
    required this.senderId,
    required this.receiverId,
    required this.meetingLink,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController msgController = TextEditingController();
  FocusNode msgFocusNode = FocusNode();
  late MessagingProvider messagingProvider;
  List<MessageModel> get msgListing=> messagingProvider.chats;
  var personName = 'Riri';

  @override
  void initState() {
    super.initState();
    
    init();
  }

  init() async {
    // Timer(Duration(seconds: 2), () async {
    //   var newMsg = await getNewMsg(widget.senderId,widget.receiverId);
    //   for (var msg in newMsg!) {
    //     print(msg.receiverId);
    //     setState(() {
    //       msgListing.insert(0, msg);
    //     });

    //   }
    // });
    Timer.periodic(new Duration(seconds: 3), (timer) async {
      var newMsg = await getNewMsg(widget.senderId, widget.receiverId);
      for (var msg in newMsg!) {
        print(msg.receiverId);
        await Provider.of<MessagingProvider>(context, listen: false)
          .addMessageToChat(msg);
       
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  sendClick() async {
    DateFormat formatter = DateFormat('hh:mm a');
    // init();
    Random random =Random();
    if (msgController.text.trim().isNotEmpty) {
      var msgModel = MessageModel(
        msgId: random.nextInt(1000),
        msg: msgController.text.toString(),
        receiverId: widget.receiverId,
        senderId: widget.senderId,
        // time: formatter.format(DateTime.now())
      );
      hideKeyboard(context);
      await Provider.of<MessagingProvider>(context, listen: false)
          .addMessageToChat(msgModel);
      sendMessage(
        widget.senderId,
        widget.receiverId,
        msgController.text.toString(),
      );

      msgController.text = '';

      if (mounted)
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      FocusScope.of(context).requestFocus(msgFocusNode);
      setState(() {});

      await Future.delayed(Duration(seconds: 1));

      if (mounted)
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
    } else {
      FocusScope.of(context).requestFocus(msgFocusNode);
    }

    setState(() {});
  }

  @override
  void didChangeDependencies() {
    messagingProvider = Provider.of<MessagingProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Row(
          children: <Widget>[
            CircleAvatar(backgroundImage: AssetImage(widget.img), radius: 16),
            SizedBox(width: 8),
            Text(widget.name,
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
        actions: [
          GestureDetector(
              child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.video_call, color: Colors.black, size: 25)),
              onTap: () {
                launch("${widget.meetingLink}");
              })
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            decoration: BoxDecoration(color: Colors.white),
            child: ListView.separated(
              separatorBuilder: (_, i) => Divider(color: Colors.transparent),
              shrinkWrap: true,
              reverse: true,
              controller: scrollController,
              itemCount: msgListing.length,
              padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 70),
              itemBuilder: (_, index) {
                MessageModel data = msgListing[index];
                var isMe = data.senderId == widget.senderId;
                print(isMe);
                return ChatMessageWidget1(isMe: isMe, data: data);
                //return ChatMessageWidget(isMe: isMe, data: data);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFF1D82FC),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      focusNode: msgFocusNode,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration.collapsed(
                        hintText: personName.isNotEmpty
                            ? 'Write here'
                            : 'Type a something...',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      onSubmitted: (s) {
                        sendClick();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, size: 20, color: Colors.white),
                    alignment: Alignment.center,
                    onPressed: () {
                      sendClick();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());
}

class ChatMessageWidget1 extends StatelessWidget {
  const ChatMessageWidget1({
    Key? key,
    required this.isMe,
    required this.data,
  }) : super(key: key);

  final bool isMe;
  final MessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe
              ? EdgeInsets.only(
                  top: 3.0,
                  bottom: 3.0,
                  right: 0,
                  left: (500 * 0.25).toDouble())
              : EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                  left: 0,
                  right: (500 * 0.25).toDouble()),
          decoration: BoxDecoration(
            color: !isMe ? Colors.red.withOpacity(0.85) : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
            border: Border.all(
                color:
                    isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(data.msg.toString(),
                      style: TextStyle(
                          color: !isMe ? Colors.white : Colors.black))),
              // Text(
              //   data.time.toString(),
              //     style: TextStyle(
              //         color: !isMe ? Colors.white : Colors.grey, fontSize: 12)
              //         )
            ],
          ),
        ),
      ],
    );
  }
}

// const widget.senderId = 1;
// const widget.recerverId = 2;