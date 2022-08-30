
import 'package:books/domain/model.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/routesManager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_viewmodel.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {


PageController _pageController = PageController(initialPage: 0);

OnBoardingViewModel _viewModel = OnBoardingViewModel();

_bind(){
  _viewModel.start();
}

@override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context,snapshot){
        return _getContentWidget(snapshot.data);
      }
      );
    
  }

  Widget _getContentWidget(SlideViewObject? slideViewObject){
    if(slideViewObject==null){
    return Container();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        itemCount: slideViewObject.numberOfSlides,
        controller: _pageController,
        onPageChanged: (index){
         _viewModel.onPageChanges(index);
        },
        itemBuilder: (context, index){
          //return onBoarding
          return OnBoardingPage(slideViewObject.sliderObject);
      }),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: (){
                Navigator.pushReplacementNamed(context, Routes.bottomBarRoute);
              }, child: Text(
                AppStrings.skip,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.end,
              ),
              ),
            ),
            _getBottomSheetWidget(slideViewObject),
          ],
        ),
      ),
    );
  }
  Widget _getBottomSheetWidget(SlideViewObject? slideViewObject){
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: (){
                _pageController.animateToPage(_viewModel.goPrevious(), duration:Duration(milliseconds: DurationConstant.d300) , curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(Icons.arrow_back_ios,color: ColorManager.white,),
              ),
            ),
          ),

          //circles
            Row(
              children: [
                for(int i=0;i<slideViewObject!.numberOfSlides;i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i,slideViewObject.currentIndex),
                  ),
              ],
            ),

            //right arrow
           Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: (){
              _pageController.animateToPage(_viewModel.goNext(), duration:Duration(milliseconds: DurationConstant.d300) , curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(Icons.arrow_forward_ios,color: ColorManager.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _getProperCircle(int index, int _currentIndex){
    if(index == _currentIndex){
      return Icon(Icons.circle_outlined,color: ColorManager.white,size: IconSize.i14,);
    }
    return Icon(Icons.circle,color: ColorManager.white,size: IconSize.i14);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  
}

class OnBoardingPage extends StatelessWidget {

SliderObject _sliderObject;

OnBoardingPage( this._sliderObject,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s40,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
          SizedBox(height: AppSize.s60,),
          SizedBox(
            height: AppSize.s300,
            child: SvgPicture.asset(_sliderObject.image.toString())),
      ],
    );
  }
}
