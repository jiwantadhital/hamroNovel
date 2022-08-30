import 'dart:async';

import 'package:books/domain/model.dart';
import 'package:books/presentation/base/baseViewModel.dart';
import 'package:books/presentation/resources/asset_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';


class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{

final StreamController _streamController = StreamController<SlideViewObject>();

int _currentIndex = 0;
late final List<SliderObject> _list;

@override
  void start() {
    _list = _getSliderData();
    _postDataToView();
    super.start();
  }

  @override
  void dispose() {
   _streamController.close();
    super.dispose();
  }

  @override
  int goNext() {
        int nextIndex = _currentIndex ++;
    if(nextIndex>= _list.length){
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
      int previousIndex = _currentIndex --;
    if(previousIndex==-1){
      _currentIndex = _list.length-1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanges(int index) {
    _currentIndex = index;
    _postDataToView();
  }

    @override
    Sink get inputSliderViewObject => _streamController.sink;


  @override
  Stream<SlideViewObject> get outputSliderViewObject => _streamController.stream.map((SlideViewObject) => SlideViewObject);

 List<SliderObject> _getSliderData() => [
  SliderObject(title: AppStrings.onBoardingTitle1,subTitle: AppStrings.onBoardingsubTitle1,image: ImageAssets.onBoarding1),
  SliderObject(title: AppStrings.onBoardingTitle2,subTitle: AppStrings.onBoardingsubTitle2,image: ImageAssets.onBoarding2),
  SliderObject(title: AppStrings.onBoardingTitle3,subTitle: AppStrings.onBoardingsubTitle3,image: ImageAssets.onBoarding3),
];

_postDataToView(){
  inputSliderViewObject.add(SlideViewObject(sliderObject: _list[_currentIndex], numberOfSlides: _list.length, currentIndex: _currentIndex));
}


}

abstract class OnBoardingViewModelInputs{
void goNext();
void goPrevious();
void onPageChanges(int index);

Sink get inputSliderViewObject;

}

abstract class OnBoardingViewModelOutputs{

  Stream<SlideViewObject> get outputSliderViewObject;
  
}

class SlideViewObject{
SliderObject sliderObject;
int numberOfSlides;
int currentIndex;

SlideViewObject({required this.sliderObject,required this.numberOfSlides,required this.currentIndex});

}