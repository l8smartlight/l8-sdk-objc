![L8smartlight](http://corcheaymedia.com/l8/wp-content/plugins/wp-l8-styles/images/logo.png)
l8 smartlight objc SDK
========================

## 1. Installation:
1. Download the project.

2. Copy L8SDk folder in to your source code folder.

**Note** L8SDK includes some very commond libraries used in ios development and you could have some of them in to your project. All required libraries by L8SDK are included in /libraries folder.

## 2. Quick start:
With L8SDK installed in to your project you have to import l8_sdk_objc.h, TIBLECBKeyfob.h, BluetoothL8.h and ColorUtils.h in your main class in .h or .m, it depends of properties, vars and so on. We have chosen a UIViewController in this guide but you can use your UIApplicationDelegate or a singletone class for example, it depends of the design of your app.

In this way, in our MainViewController.h we have:

```smalltalk

#import <UIKit/UIKit.h>

#import "TIBLECBKeyfob.h"

@interface MainViewController : UIViewController<TIBLECBKeyfobDelegate>

@property (nonatomic,strong) NSArray *l8Array; //here we store L8 instances

@end


```
