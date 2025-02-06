import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.title});

  final String title;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  //creating an instance of ImagePicker class which enables us to access
  //device gallery and pick multiple images
  final ImagePicker picker = ImagePicker();

  //storing images in a list to be displayed in a ListView
  List<File> listOfImagesFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //displaying a default text in case of an empty images list
          //otherwise displaying the listView builder of picked images
          listOfImagesFiles.isEmpty
              ? Center(child: Text('Start Picking Images for your Gallery!'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: listOfImagesFiles.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 200,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Image.file(listOfImagesFiles[index]));
                    },
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FilledButton(
                onPressed: () async {
                  //requesting a multiple image selection process
                  //then looping through each selected image file and storing its path in the predefined
                  //images' files list
                  await picker.pickMultiImage().then(
                    (pickedImages) {
                      for (XFile image in pickedImages) {
                        listOfImagesFiles.add(File(image.path));
                      }
                    },
                  );
                  setState(() {});
                },
                child: Text('Pick Image')),
          )
        ],
      ),
    );
  }
}
