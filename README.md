## ZZStringAnimation
*  String animation for UILabel text.

## Contents

* Currently contains these animations
	* [ZZLightAnimation]()
	* [ZZEnlargeAnimation]()
	* [ZZDrawAnimation]()
	* [ZZGradualAnimation]()

## Usage

* [LightAnimation]()

	```objc
	ZZLightAnimation *lightAnimation = [ZZLightAnimation new];
    lightAnimation.color = [UIColor whiteColor];
    lightAnimation.duration = 1;
    [self.label zz_startAnimation:lightAnimation];
    ```
* [EnlargeAnimation]()

	```objc
	ZZEnlargeAnimation *enlargeAnimation = [ZZEnlargeAnimation new];
    enlargeAnimation.duration = 5;
    enlargeAnimation.enlargeMultiple = 3;
    [self.label zz_startAnimation:enlargeAnimation];
    ```
* [DrawAnimation]()

	```objc
	ZZDrawAnimation *drawAnimation = [ZZDrawAnimation new];
    drawAnimation.duration = 5;
    [self.label zz_startAnimation:drawAnimation];
    ```
* [GradualAnimation]()

	```objc
	ZZGradualAnimation *gradualAnimation = [ZZGradualAnimation new];
    gradualAnimation.duration = 5;
    [self.label zz_startAnimation:gradualAnimation];
    ```


## Examples
![Examples](_Gifs/Example.gif)


