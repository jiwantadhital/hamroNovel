import 'package:books/controller/novel_controller.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/main/details/chapters/page_color.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SavedChapters extends StatefulWidget {
    int pageI;
    var chapterIndex;
SavedChapters({required this.pageI,required this.chapterIndex});

  @override
  State<SavedChapters> createState() => _SavedChaptersState();
}

class _SavedChaptersState extends State<SavedChapters>{
  int changeNumber = 2;

  bool show = true;
  Color pageColor = Colors.white;
  Color textColor = Colors.black;
  double textSize = 20;
  String dropdownValue = 'Normal';
  var list = <String>['Normal', 'Montserrat','Baskerville'];
  void _incrementCounter() async {
                final prefs = await SharedPreferences.getInstance();
                  setState(() {
                            prefs.setInt('changNo',changeNumber);
                            prefs.setDouble('textSize', textSize);
                            prefs.setString('dropdown', dropdownValue);
                     });
                    }

                    void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      changeNumber = prefs.getInt('changNo')!.toInt();
      textSize =prefs.getDouble('textSize')!.toDouble();
      dropdownValue =prefs.getString('dropdown').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
    pageColor=Colors.white;
    textColor = Colors.black;
    textSize = 20;
    show = true;

  }

  // @override
  // void dispose() {
  //   show;
  //   textColor;
  //   textSize;
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
        NovelModel childrenClass = NovelModel.fromJson(widget.chapterIndex);

    if(changeNumber == 1){
          pageColor = Colors.black;
        textColor = Colors.white;
    }
    else if(changeNumber == 2){
        pageColor = Colors.white;
      textColor = Colors.black;
    }
    else if(changeNumber == 3){
               pageColor = Color.fromARGB(255,224,200,167);
            textColor = Colors.black;
    }
    else if(changeNumber == 4){
            pageColor = Colors.grey;
          textColor = Colors.white;
    }
      PageController _chapterController = PageController(initialPage: widget.pageI);
    // var chapter = context.read<NovelController>().novelList[widget.pageI];
    var pageColors = Container(
                  padding: EdgeInsets.only(right: 20),
                  height: 75,
                  width: MediaQuery.of(context).size.width/2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                          changeNumber = 1;
                          _incrementCounter();
                          });
                        },
                        child: PageColor(color: Colors.black,border: textColor)),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                           changeNumber = 2;
                            _incrementCounter();
                          });
                        },
                        child: PageColor(color: Colors.white,border: textColor)),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                          changeNumber = 3;
                           _incrementCounter();
                          });
                        },
                        child: PageColor(color: Color.fromARGB(255,224,200,167),border: textColor)),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                        changeNumber = 4;
                         _incrementCounter();
                          });
                        },
                        child: PageColor(color: Colors.grey,border: textColor)),

                    ],
                  ),
                );
     var pageFont = Container(
                  padding: EdgeInsets.only(right: 20,left: 20),
                  height: 75,
                  width: MediaQuery.of(context).size.width/2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              textSize = 15;
                              _incrementCounter();
                            });
                          },
                          child: PageFont(text: "S")),
                          GestureDetector(
                          onTap: (){
                            setState(() {
                              textSize = 20;
                              _incrementCounter();
                            });
                          },
                          child: PageFont(text: "M")),
                          GestureDetector(
                          onTap: (){
                            setState(() {
                              textSize = 25;
                              _incrementCounter();
                            });
                          },
                          child: PageFont(text: "L")),
                    ],
                  ),
                );
    var dropdownButton = DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          _incrementCounter();
        });
      },
      items: list
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _chapterController,
          itemCount: childrenClass.chapters!.length,
          itemBuilder: (context,index) {
            return Scaffold(
            
              body:  Scrollbar(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                         show = false;
                      });
                    },
                    icon: const Icon(Icons.settings)),
                const SizedBox(
                  width: 12,
                ),
              ],
              floating: true,
              centerTitle: true,
              elevation: 0,
              backgroundColor: ColorManager.primary,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      childrenClass.chapters![index].name.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text("Chapter ${childrenClass.chapters![index].number.toString()}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto')),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: pageColor,
                padding: EdgeInsets.only(left: 10,right: 10,),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 20,bottom: 10),
                          height: 20,
                          
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            show = true;
                          });
                        },
                        child: Text( "The sudden change in face color of Ye Wuchen had caused Lin Yan to laugh grimly, he lowered his tone while laughing: “Well, you speak very well, how can I not do it! Haha haha!”Lin Yan’s voice dropped. Because he had taken the bet, there was wild uproar within the audience. Lin Yan was the strongest fire wizard in the whole Tian Long nation, there’s no way a youngster would be able to resist him. It would be fine if it were just a simple competition, at most he will just be simply defeated by Lin Yan and get burnt in a battered and exhausted manner, but in no way would he get murdered because Lin Yan wouldn’t dare do this. Even if he defeated his opponent it would be just an everyday experience; on the contrary, Lin Yan will get despised by other people if he lost. This idea had been suggested by Ye Wuchen, but in any case he would just suffer from the consequences of his actions and be consigned to his eternal damnation.Could it be that this astonishing genius of the Ye family would just like that get destroyed by the hands of Lin Yan? Anyway, the Ye family wouldn’t allow this kind of thing to happen. After a while, there would be an unavoidable episode of riot.Ye Wuchen turned around, facing towards Ye Nu and Ye Wei he revealed a relaxed smile but quickly concealed it. Ye Nu and Ye Wei simultaneously took it all in, and then glanced at each other’s face. Don’t tell me he is luring Lin Yan into something? Although they could tell what method would be used, the two men calmed down at long last. Ye Wei patted Wang Wenshu to calm down her nerves, and signaled her not to panic. Ye Wuchen suddenly clenched his teeth fiercely and turned around as though he weren’t afraid of dying. Facing the location where the emperor was seated, he yelled every word solemnly: “We, the Ye family, are absolutely not ones who would break our promise. Since I, Ye Wuchen, have already agreed on this bet, then there’s no way I’m backing out. Let Your Majesty and all the friends and elders seated here be my witnesses. If I lose, I will be punished by Clan Head Lin without any resistance. But If I luckily defeat Head Lin, then he should call me “grandpa” three times whenever we met. After a moment of silence, a flat powerful voice echoed: “Fine! Since you’ve insisted, then I am going to be your witness,. You started this bet, have you pondered on the outcome if you are defeated?” “We from the Ye family, when we lose, we lose with dignity and fairness. Absolutely we never grow fat eating our word else we would be ridiculed by other people.” Ye Wuchen remarked in a serious tone. TL: Idiom alert, grow fat eating our words means not to live up to one’s promises. Long Yin nodded his head: “Now we begin... but... I really hate seeing a talented young man get ruined by this. Sometimes admitting one’s defeat is not a shameful thing - to blindly pursue one’s dignity is a behaviour of an impertinent person. “Wuchen thanks Your Majesty for the concern.” Ye Wuchen turned to face Lin Yan, his face is calm and his attitude that of facing death with equanimity: “Superior Lin, please go ahead. Just like we agreed, you can only use flame to attack, or else you lose, and I cannot evade, or else I’ll lose.” “Hmp! I don’t need your reminders!” Lin Yan let out a cold groan of disdain, then his expression turned to sorrow. He firmly believes that Ye Wuchen’s power would never be able to resist his flames. He lifted both of his hands, and then both palms ignited a red colored flame. The flame color went from a red-yellow hue and gradually turned to a dark scarlet red. A small portion of heat became stronger and stronger starting from his palm then quickly spreading to all the directions.."
                        ,textAlign: TextAlign.justify
                        ,style: TextStyle(
                          height: 1.5,
                          fontSize: textSize,
                          color: textColor,
                          fontFamily: dropdownValue,
                        ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SmallText(text: "End Of Chapter",color: Colors.red,),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                          _chapterController = PageController(initialPage: widget.chapterIndex+1);

                          });
                        },
                        child: SmallText(text: "NextPage",color: Colors.red,)),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
            );
          }
            ),
        
      ),
      bottomNavigationBar: show? Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        height: 5,
        decoration: BoxDecoration(
          color: ColorManager.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
          ],
        ),
      ):Container(
        height: 150,
        color: Colors.black87,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pageFont,
                pageColors,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: MediaQuery.of(context).size.width/2.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1
                    ,color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: dropdownButton),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(text: "Download",color: ColorManager.white,),
                    SizedBox(width: AppWidth.w8,),
                    Container(
                      margin: EdgeInsets.only(right: AppSize.s40),
                  width: AppWidth.w30,
                  height: AppHeight.h30,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: ColorManager.primary,
                  ),
                  child: const Icon(
                    Icons.download,
                    color: Colors.white,
                    ),
                ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

