

import 'package:flutter/material.dart';

import '../core/utils/helpers.dart';
import 'custom_textfeild.dart';

class DropDownKiller<T> extends StatefulWidget {
  const DropDownKiller({super.key, required this.data, required this.onSelected});

  final List<T> data;
  final Function(T result) onSelected;

  @override
  State<DropDownKiller<T>> createState() => _DropDownKillerState<T>();
}

class _DropDownKillerState<T> extends State<DropDownKiller<T>> {
  List<T> searchedList = [];

  TextEditingController textEditingController = TextEditingController();

  onSearched(String key) {
    searchedList.clear();
    for (var element in widget.data) {
      if (element.toString().toLowerCase().contains(key.toLowerCase())) {
        searchedList.add(element);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool searched = textEditingController.text.isNotEmpty;
    return Scaffold(
      //Appbar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: CustomTextField(
                hintText: "Search here",
                controller: textEditingController,
                prefixIcon: const Icon(Icons.search),
                onChanged: onSearched,
                type: CustomTextFieldType.text,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searched ? searchedList.length : widget.data.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      searched ? widget.onSelected(searchedList[index]) : widget.onSelected(widget.data[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),                      
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 12,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            searched ? searchedList[index].toString() : widget.data[index].toString(),
                            style: Helper(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
