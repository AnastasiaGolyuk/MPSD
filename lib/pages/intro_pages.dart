import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({Key? key}) : super(key: key);

  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
          title: "Feed the cat",
          description: "Press the \"Feed!\" button to feed the cat",
          pathImage: "assets/first_slide_image.png"),
    );
    slides.add(
      Slide(
          title: "Save results",
          description: "Press the button with star to save your result",
          pathImage: "assets/second_slide_image.png"),
    );
    slides.add(
      Slide(
          title: "Achievements",
          description: "Keep feeding the cat to get achievements",
          pathImage: "assets/third_slide_image.png"),
    );
    slides.add(
      Slide(
          title: "Colored buttons",
          description:
              "Press on the button below with the same color displayed above them to reset satiety",
          pathImage: "assets/fourth_slide_image.png"),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    int length = slides.length;
    for (int i = 0; i < length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: const EdgeInsets.only(bottom: 150, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    currentSlide.pathImage.toString(),
                    width: 250,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      currentSlide.title.toString(),
                      style: const TextStyle(color: Colors.pink, fontSize: 25),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      currentSlide.description.toString(),
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: Colors.white,
      renderSkipBtn:
          const Text("Skip", style: TextStyle(color: Colors.deepOrangeAccent)),
      renderNextBtn: const Text("Next", style: TextStyle(color: Colors.pink)),
      renderDoneBtn: const Text("Done", style: TextStyle(color: Colors.pink)),
      colorActiveDot: Colors.pink,
      sizeDot: 8,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: renderListCustomTabs(),
      scrollPhysics: const BouncingScrollPhysics(),
      onDonePress: () {
        Navigator.pop(context);
      },
    );
  }
}
