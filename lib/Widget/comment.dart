import 'package:dam_project/utils/addComment.dart';
import 'package:dam_project/utils/getAllcomments.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  const Comment(this.userId, this.postId, {super.key});
  final String userId, postId;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List data = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final newData = await getAllComments(widget.postId);
    setState(() {
      data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController newCommentController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(10),
      height: double.infinity,
      child: Column(
        children: [
          Flexible(
              flex: 6,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (data.isEmpty) {
                    return const Text('there is no comments here  !');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data[index]['name']} ${data[index]['lastname']} : ",
                        style: const TextStyle(fontWeight: FontWeight.bold , decoration: TextDecoration.underline , fontSize: 26),
                      ),
                      Text("${data[index]['content']}")
                    ],
                  );
                },
                itemCount: data.isEmpty ? 1 : data.length,
              )),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newCommentController,
                    decoration:
                        const InputDecoration(label: Text("add new comment ")),
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      addComment(widget.postId, widget.userId,
                          newCommentController.text);
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      'send ',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
