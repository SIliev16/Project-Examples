import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeAppTwo ());
}


class FigmaToCodeAppTwo extends StatelessWidget {
  const FigmaToCodeAppTwo ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
          AndroidSmall4(),
        ]),
      );

  }
}

class AndroidSmall4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 636,
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
                top: 126,
                child: Container(
                  width: 361,
                  height: 510,
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
                    color: Color(0xFF13CCCC),
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
                      image: AssetImage('assets/boy-2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 18,
                top: 229,
                child: Container(
                  width: 328,
                  height: 364,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              const Positioned(
                left: 85,
                top: 409,
                child: Text(
                  'Call me after 10 minutes\nI can help.',
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
                left: 83,
                top: 279,
                child: Text(
                  'Use Paracetamol ',
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
                left: 29,
                top: 247,
                child: Container(
                  width: 35,
                  height: 54,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/girl-4.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              const Positioned(
                left: 79,
                top: 246,
                child: Text(
                  'Dr.Nancy',
                  style: TextStyle(
                    color: Color(0xFF13CCCC),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 389,
                child: Container(
                  width: 42,
                  height: 55,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/boy.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              const Positioned(
                left: 77,
                top: 375,
                child: Text(
                  'Dr.John',
                  style: TextStyle(
                    color: Color(0xFF13CCCC),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 366,
                child: Container(
                  width: 334,
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
                left: 46,
                top: 321,
                child: Container(
                  width: 290,
                  height: 32,
                  decoration: const BoxDecoration(color: Color(0xFF13CCCC)),
                ),
              ),
              const Positioned(
                left: 64,
                top: 328,
                child: Text(
                  'Reply',
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
                left: 263,
                top: 328,
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
                left: 46,
                top: 468,
                child: Container(
                  width: 290,
                  height: 32,
                  decoration: const BoxDecoration(color: Color(0xFF13CCCC)),
                ),
              ),
              const Positioned(
                left: 65,
                top: 475,
                child: Text(
                  'Reply',
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
                left: 263,
                top: 475,
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
                left: 18,
                top: 521,
                child: Container(
                  width: 328,
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
            ],
          ),
        ),
      ],
    );
  }
}