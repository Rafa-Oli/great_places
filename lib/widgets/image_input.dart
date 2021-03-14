import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker(); //acessando a camera
    PickedFile imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    //diretorio para armazenar a imagem
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    //pegando o nome da imagem
    String fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy(
      '${appDirectory.path}/$fileName',
    );

    widget.onSelectImage(savedImage); // salvando a imagem
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text("No image!"),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor)),
            label: Text('Take a picture'),
          ),
        )
      ],
    );
  }
}
