import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'DropDown.dart';
import 'package:path/path.dart' as path;
import 'dart:math';
import 'ComplaintDialog.dart';
import 'Complaint_Class.dart';
import 'AdminDialog.dart';
import 'ModeratorDialog.dart';

MailContent complaint;

class BackgroundMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: (4.3*MediaQuery.of(context).size.width)/8,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              //child: Compose(),
            ),
            ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  color: Color(0xFF181D3D),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                      child: Row(children: <Widget>[
                        SizedBox(height: 30.0),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/app_logo_final_jpg_ws.jpg'),
                          radius: (38*MediaQuery.of(context).size.height)/1000,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          'InstiComplaint',
                          style: TextStyle(
                            fontFamily: 'Amaranth',
                            color: Colors.white,
                            fontSize: (34*MediaQuery.of(context).size.height)/1000
                          ),
                        )
                      ],),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 24),
                    Text(
                      'File a Complaint',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (30*MediaQuery.of(context).size.height)/1000
                      )
                    ),
                    //SizedBox(height: MediaQuery.of(context).size.height / 12),
                  ]),
                )
              ),
          ],
        ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width/8, size.width / 2, size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2-size.width/8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2-size.width/8, size.width / 2,
              size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }
  @override
  bool shouldReclip(oldCliper) => false;
}



class ImageShow extends StatelessWidget {

  String name;
  Function delete;
  ImageShow({this.name,this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (3.5*MediaQuery.of(context).size.width)/6,
      margin: EdgeInsets.symmetric(vertical:5.0),
      padding: EdgeInsets.only(left:5.0),
      color: Colors.grey[300],      
      child: Row(
        children: <Widget>[
          Icon(Icons.image),
          SizedBox(width: 3.0,),
          Text(name.length>18 ? name.substring(0,6)+'...'+name.substring(name.length-5) :name),
          //SizedBox(width: 3.0,),
          new Spacer(),
          IconButton(
            padding: EdgeInsets.only(right:2.0),
            onPressed: delete,
            icon: Icon(Icons.delete), 
          ),
        ],
      ),
    );
  }
}



class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {

  List<File> imagesInComplaint = [];


  Future<void> _pickImage(ImageSource source) async {

    File selected = await ImagePicker.pickImage(source: source);
    
    setState(() {
      if(selected!=null){
        imagesInComplaint.add(selected);
      }
      print(imagesInComplaint.length.toString() + '\n\n\n' + selected.toString());
    });
  }

  final titleController = TextEditingController();
  final descripController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descripController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 29, 61,1),

      ),*/
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            BackgroundMaker(),
            Card(
              //shadowColor: Color.fromRGBO(24, 29, 61,1),
              margin: EdgeInsets.symmetric(horizontal:15.0),
              elevation: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CategoryDropdown(),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.only(left:10.0,right: 10.0),
                    width: 400.0,
                    constraints: BoxConstraints(
                      maxHeight: 200.0,
                      minHeight: 80.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.5),
                      child: TextField(
                        controller: titleController,
                        minLines: 1,
                        maxLines: 3,
                        maxLength: 80,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          height: 2.0,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Title:  ',   
                          alignLabelWithHint: true,                   
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(24, 51,98, 1),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ), 

                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.only(left:10.0,right: 10.0),
                    width: 400.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.8),                 
                      child: TextField(
                        controller: descripController,
                        minLines: 1,
                        maxLines: 12,
                        maxLength: 350,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(                     
                          height: 2.0,                      
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Description:  ',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(24, 51,98, 1),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    children: <Widget>[
                      IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Color.fromRGBO(24, 29, 61,1),
                          size: 40.0,
                        ),

                        color: Colors.blue,
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                      Text(
                        ':   ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.0),
                      ),
                      Column(
                        children: imagesInComplaint.map((imag) => ImageShow(
                          name: path.basename(imag.path),
                          delete: (){
                            setState(() {
                              imagesInComplaint.remove(imag);
                            });
                          }
                        )).toList(),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,)
                ],
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: RaisedButton(
                onPressed: () {
                  complaint = MailContent(titleController.text, selectedCategory, descripController.text, imagesInComplaint,DateTime.now(),"pending",[],"jain2305@gmail.com");
        
                  print(complaint.title + '\n' + complaint.category  + '\n' + complaint.description+'\n'+complaint.images.length.toString());
                  //Future.delayed(Duration(seconds: 10),(){imagesInComplaint.clear();});
                  //TODO: Add mail to database.
                  titleController.clear();
                  descripController.clear();
                  //imagesInComplaint.clear();
                  //TODO: Navigate to next page
                  /*showDialog(
                    context: context,
                    builder: (BuildContext context) => ModeratorDialog()
                  );*/
                },
                child: Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xFF181D3D),
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              child: Image(image: AssetImage('assets/app_logo_final0.png')),
              height: 120.0,
              width: 120.0,
            )
          ],
        )
      )
    );
  }
}