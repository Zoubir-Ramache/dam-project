import 'package:flutter/material.dart';
import '../utils/getAllCategories.dart';

class Search extends StatefulWidget {
  const Search(this.handleSearchData, {super.key});
  final Function(String? name, String? category, String? place)
      handleSearchData;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? category, name, place;
  List data = [];

  void initData() async {
    final newData = await getAllCategories();
    setState(() {
      data = newData;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () {
              widget.handleSearchData(name, category, place);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                value: category,
                hint: const Text('category'),
                items: data
                    .map((e) => DropdownMenuItem(
                          value: e['category'].toString(),
                          child: Text('${e['category']}'),
                        ))
                    .toList(),
                onChanged: (s) {
                  setState(() {
                    category = s;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                hint: const Text('place'),
                value: place,
                items: const [
                  DropdownMenuItem(
                    value: 'fdsd',
                    child: Text('hello world '),
                  ),
                  DropdownMenuItem(
                      value: 'hhhhhhhhhhhhh', child: Text('towwwwwwww'))
                ],
                onChanged: (s) {
                  setState(() {
                    place = s;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(hintText: 'name'),
                onChanged: (s) {
                  setState(() {
                    name = s;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
