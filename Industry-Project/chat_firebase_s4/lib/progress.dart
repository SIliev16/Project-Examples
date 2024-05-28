  import 'package:flutter/material.dart';
  import 'package:camera/camera.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter_image_compress/flutter_image_compress.dart';
  import 'dart:io';
  import  'SummaryScreen.dart';



  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    runApp(MyApp(camera: firstCamera));
  }

  class MyApp extends StatelessWidget {
    final CameraDescription camera;

    MyApp({required this.camera});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'CorpusVR - PhysioApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProgressPage(camera: camera),
      );
    }
  }

  class ProgressPage extends StatefulWidget {
    final CameraDescription camera;

    ProgressPage({required this.camera});

    @override
    _ProgressPageState createState() => _ProgressPageState();
  }
  class ProgressData {
    double painLevel;
    String condition;
    Map<String, bool> symptoms;
    File? image;
    String additionalDetails;
    String title;

    ProgressData({
      this.painLevel = 0.0,
      this.condition = '',
      this.symptoms = const {},
      this.image,
      this.additionalDetails = '',
      this.title = '',
    });
  }
  class _ProgressPageState extends State<ProgressPage> {
    List<ProgressData> progressList = [];
    double _painLevel = 0;
    String _condition = '';
    Map<String, bool> _symptoms = {};
    File? _image;
    String _additionalDetails = '';
    String _title = ''; // Variable to store the title

    void _showForm(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return YourFormWidget(
            camera: widget.camera,
            onSubmit: _updateProgress,
          );
        },
      );
    }

    void _updateProgress(double painLevel, String condition, Map<String, bool> symptoms, File? image, String additionalDetails, String title) {
      setState(() {
        progressList.add(ProgressData(
          painLevel: painLevel,
          condition: condition,
          symptoms: symptoms,
          image: image,
          additionalDetails: additionalDetails,
          title: title,
        ));
      });
      Navigator.pop(context); // This will close the modal bottom sheet
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'New Progress',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _showForm(context),
                          child: Text(
                            'Add new',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF15B0A9)),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Space after the row
                    Column(
                      children: progressList.map((progressData) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(bottom: 20), // Add space between boxes
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Background color for the box
                            borderRadius: BorderRadius.circular(10), // Rounded corners
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(progressData.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                              Text('Pain level - ${progressData.painLevel}'),
                              Text('Condition: ${progressData.condition}'),
                              Text('Symptoms: ${progressData.symptoms.keys.where((key) => progressData.symptoms[key]!).join(', ')}'),
                              if (progressData.image != null) Image.file(progressData.image!, height: 200, width: 300),
                              Text('Extra description: ${progressData.additionalDetails}'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    // Space after the row
                  ]),
            )),
      );
    }
  }

  class YourFormWidget extends StatefulWidget {
    final CameraDescription camera;
    final Function(double, String, Map<String, bool>, File?, String, String) onSubmit;
    YourFormWidget({required this.camera, required this.onSubmit});

    @override
    _YourFormWidgetState createState() => _YourFormWidgetState();
  }

  class _YourFormWidgetState extends State<YourFormWidget> {
    late CameraController _controller;
    late Future<void> _initializeControllerFuture;
    double _painLevel = 0;
    String _condition = '';
    Map<String, bool> _symptoms = {
      'No Symptom': false,
      'Swollen': false,
      'Redness': false,
      'Numbness': false,
      'Pain while moving': false,
    };
    File? _image;
    String _additionalDetails = '';
    String _title = '';
    @override
    void initState() {
      super.initState();
      _controller = CameraController(widget.camera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    Future<void> _takePicture() async {
      try {
        await _initializeControllerFuture;
        final image = await _controller.takePicture();
        File? resizedImage = await resizeImage(image.path);
        setState(() => _image = resizedImage);
      } catch (e) {
        print(e);
      }
    }

    Future<File?> resizeImage(String imagePath) async {
      // Compress and resize the image
      final String targetPath = imagePath.replaceAll('.jpg', '_compressed.jpg');
      var result = await FlutterImageCompress.compressAndGetFile(
          imagePath, targetPath, quality: 50, minWidth: 400, minHeight: 300);
      return result != null ? File(result.path) : null;
    }

    void _showSummary(BuildContext context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SummaryScreen(
            painLevel: _painLevel,
            condition: _condition,
            symptoms: _symptoms,
            image: _image,
            additionalDetails: _additionalDetails,
          ),
        ),
      );
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFC3E7E5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter more details here',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allows multiple lines
                  onChanged: (value) {
                    _additionalDetails = value; // Just set _additionalDetails
                  },
                ),
                SizedBox(height: 50),
                Text("Rate the pain you are feeling"),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    thumbColor: Colors.tealAccent,
                    overlayColor: Colors.teal.withAlpha(32),
                    activeTrackColor: Colors.teal,
                    inactiveTrackColor: Colors.grey,
                  ),
                  child: Slider(
                    value: _painLevel,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: '${_painLevel.round()}',
                    onChanged: (newValue) {
                      setState(() {
                        _painLevel = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('😃', style: TextStyle(fontSize: _painLevel.round() == 0 ? 24 : 20)),
                      Text('😖', style: TextStyle(fontSize: _painLevel.round() == 10 ? 24 : 20)),
                    ],
                  ),
                ),
                RadioListTile<String>(
                  title: Text('Getting better'),
                  value: 'Getting better',
                  groupValue: _condition,
                  onChanged: (value) {
                    setState(() {
                      _condition = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Still the same'),
                  value: 'Still the same',
                  groupValue: _condition,
                  onChanged: (value) {
                    setState(() {
                      _condition = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Getting worse'),
                  value: 'Getting worse',
                  groupValue: _condition,
                  onChanged: (value) {
                    setState(() {
                      _condition = value!;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _symptoms.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: _symptoms[key],
                        onChanged: (bool? value) {
                          setState(() {
                            _symptoms[key] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Make photo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      InkWell(
                        onTap: _takePicture,
                        child: _image == null
                            ? Icon(Icons.camera_alt, size: 50)
                            : Image.file(
                          _image!,
                          height: 300,
                          width: 400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Give us more details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter more details here',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allows multiple lines
                  onChanged: (value) {
                    setState(() {
                      _additionalDetails = value;
                      onChanged: (newValue) {
                        setState(() {
                          _title = newValue; // Update _title with the new value
                        });
                      };
                    });
                  },
                ),

                // Submit Button
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    widget.onSubmit(_painLevel, _condition, _symptoms, _image, _additionalDetails, _title);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

