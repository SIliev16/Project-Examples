import 'package:chat_firebase_s4/figma_to_code_app_two.dart';
import 'package:flutter/material.dart';

import 'comments.dart';

void main() {
  runApp(const FigmaToCodeApp());
}


class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 36.0), // Adjust the value as needed
        child: ListView(
          children: const [
            AndroidSmall3(),
          ],
        ),
      ),
    );
  }
}

class AndroidSmall3 extends StatelessWidget {
  const AndroidSmall3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 640,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [


              Positioned(
                left: 0,
                top: 265,
                child: Container(
                  width: 360,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 428,
                child: Container(
                  width: 360,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 126,
                child: Container(
                  width: 361,
                  height: 138,
                  decoration: const BoxDecoration(color: Color(0xFF15B0A9)),
                ),
              ),
              const Positioned(
                left: 85,
                top: 160,
                child: Text(
                  'I have so much pain in my knees\n any help?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 80,
                top: 132,
                child: Text(
                  'Rob\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 141,
                child: Container(
                  width: 37,
                  height: 49,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/man-2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 19,
                top: 223,
                child: Container(
                  width: 328,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              const Positioned(
                left: 48,
                top: 231,
                child: Text(
                  'Comment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 265,
                top: 230,
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 1,
                top: 428,
                child: Container(
                  width: 360,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1,
                top: 289,
                child: Container(
                  width: 360,
                  height: 138,
                  decoration: const BoxDecoration(color: Color(0xFF15B0A9)),
                ),
              ),
              const Positioned(
                left: 86,
                top: 323,
                child: Text(
                  'I cant  move my neck all of sudden\nwhat should I do?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 81,
                top: 295,
                child: Text(
                  'Sam',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 386,
                child: Container(
                  width: 328,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              const  Positioned(
                left: 49,
                top: 394,
                child: Text(
                  'Comment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),

              const Positioned(
                left: 266,
                top: 393,
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 13,
                top: 315,
                child: Container(
                  width: 49,
                  height: 46,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/man-5.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 15,
                top: 509,
                child: Container(
                  width: 324,
                  height: 89,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 29,
                top: 540,
                child: Text(
                  'write your post .... ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 290,
                top: 541,
                child: Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.black, // Set the color you prefer
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}