import 'package:dam_project/Widget/dashboard/edit_post.dart';
import 'package:flutter/material.dart';
import 'comment.dart';
import '../utils/likePost.dart';
import 'package:flutter/services.dart' show rootBundle;

class Post extends StatefulWidget {
  const Post(this.postInfo, this.role, this.userId, {super.key});
  final String userId;
  final String role;
  final Map<String, dynamic> postInfo;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool imageExists=false;
  @override
  void initState() {
    
    super.initState();
    checkImageExistence();

  }
   Future<void> checkImageExistence() async {
    try {
      await rootBundle.load('${widget.postInfo["name"]}.jpeg');
      setState(() {
        imageExists = true;
      });
    } catch (error) {
      setState(() {
        imageExists = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Card(
      color: const Color.fromARGB(79, 96, 125, 139),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            padding: const EdgeInsets.only(left: 20, right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.postInfo["name"]}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    if (widget.role == "admin")
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => EditPost(widget.postInfo)));
                        },
                        icon: const Icon(Icons.edit),
                      )
                  ],
                ),
                Text(
                  'place : ${widget.postInfo["place"]}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text('category : ${widget.postInfo["category"]}',
                    style: const TextStyle(fontSize: 18)),
                Text(' description ${widget.postInfo["description"]}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),

          imageExists ?
          Center(
              child: Image.asset(
            '${widget.postInfo["name"]}.jpeg',
            
          )): const Center(child: Text("this post does not have an image"),),
          
          Container(
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    likePost(widget.userId, widget.postInfo['id']);
                  },
                  icon: const Icon(Icons.save),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: (_) =>  Comment(widget.userId ,widget.postInfo['id'] ));
                  },
                  icon: const Icon(Icons.comment),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
