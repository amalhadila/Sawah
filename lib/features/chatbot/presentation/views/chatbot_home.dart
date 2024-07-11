import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/chatbot/presentation/manager/cubit/chatbotmessage_cubit.dart';
import 'package:sawah/features/chatbot/presentation/manager/cubit/deletechatbot_cubit.dart';
import 'package:sawah/features/chatbot/presentation/manager/cubit/sendmesage_cubit.dart';
import 'package:sawah/features/chatbot/presentation/views/widgets/mymessage.dart';
import 'package:sawah/features/chatbot/presentation/views/widgets/othermessage.dart';

class ChatbotHome extends StatefulWidget {
  @override
  _ChatbotHomeState createState() => _ChatbotHomeState();
}

class _ChatbotHomeState extends State<ChatbotHome> {
  final TextEditingController _textController = TextEditingController();
  List<Widget> _messages = [];

  @override
  void initState() {
    super.initState();
    context.read<ChatbotmessageCubit>().fetchChatbotMessages();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: kmaincolor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration.collapsed(
                    hintText: "ask me?",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                  onSubmitted: _handleSubmitted,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send, color: kmaincolor),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, MyMessage(message: text));
    });
    BlocProvider.of<SendmesageCubit>(context).SendMessageRequest(
      messsagetext: text,
    );
  }

  void _addResponseMessage(String text) {
    setState(() {
      _messages.insert(0, OtherMessage(message: text));
    });
  }

  List<Widget> _buildMessagesFromState(ChatbotmessageSuccess state) {
    List<Widget> messages = [];
    for (var conversation in state.chatbotconversation) {
      if (conversation != null && conversation.history != null) {
        for (var message in conversation.history!) {
          if (message != null &&
              message.parts != null &&
              message.parts!.isNotEmpty) {
            var text = message.parts![0].text;
            if (text != null) {
              messages.add(message.role == 'user'
                  ? MyMessage(message: text)
                  : OtherMessage(message: text));
            }
          }
        }
      }
    }
    return messages.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sawah",
          style: TextStyle(
              color: kmaincolor, fontSize: 19, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kbackgroundcolor,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.trash,
              color: kmaincolor,
            ),
            onPressed: () async {
              await BlocProvider.of<DeletechatbotCubit>(context)
                  .deletechatbot();
              BlocProvider.of<ChatbotmessageCubit>(context)
                  .fetchChatbotMessages();
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SendmesageCubit, SendmesageState>(
            listener: (context, state) {
              if (state is SendmesageSuccess) {
                context.read<ChatbotmessageCubit>().fetchChatbotMessages();
              }
            },
          ),
          BlocListener<ChatbotmessageCubit, ChatbotmessageState>(
            listener: (context, state) {
              if (state is ChatbotmessageSuccess) {
                setState(() {
                  _messages = _buildMessagesFromState(state);
                });
              }
            },
          ),
        ],
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: ksecondcolor2),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
