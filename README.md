## ZZStringAnimation
*  String animation for UILabel text.
*  It is currently in the development.
*  Welcome to fork and submit pull requests.


## Contents

* Currently contains these animations

	* **ZZLightAnimation**
	* **ZZEnlargeAnimation**
	* **ZZDrawAnimation**
	* **ZZGradualAnimation**
	* **ZZWaveAnimation**
	* **ZZPathAnimation**
* These animations in development
	* **ZZArcAnimation**


## Example usage
    
* **EnlargeAnimation**

	```objc
	ZZEnlargeAnimation *enlargeAnimation = [ZZEnlargeAnimation new];
    enlargeAnimation.duration = 5;
    enlargeAnimation.enlargeMultiple = 3;
    [self.label zz_startAnimation:enlargeAnimation];
    ```
* **DrawAnimation**

	```objc
	ZZDrawAnimation *drawAnimation = [ZZDrawAnimation new];
    drawAnimation.duration = 5;
    [self.label zz_startAnimation:drawAnimation];
    ```
* **GradualAnimation**

	```objc
	ZZGradualAnimation *gradualAnimation = [ZZGradualAnimation new];
    gradualAnimation.duration = 5;
    [self.label zz_startAnimation:gradualAnimation];
    ```
* **ZZWaveAnimation**

	```objc
	ZZWaveAnimation *waveAnimation = [ZZWaveAnimation new];
    waveAnimation.duration = 5;
    [self.label zz_startAnimation:waveAnimation];
    ```


