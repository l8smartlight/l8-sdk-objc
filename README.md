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

```objective-c

#import <UIKit/UIKit.h>

#import "TIBLECBKeyfob.h"

@interface MainViewController : UIViewController<TIBLECBKeyfobDelegate>

@property (nonatomic,strong) NSArray *l8Array; //here we store L8 instances

@end


```

MainViewController.m

```objective-c

#import "MainViewController.h"
#import "l8_sdk_objc.h"
#import "ColorUtils.h"
#import "TIBLECBKeyfob.h"
#import "BluetoothL8.h"

@interface MainViewController ()

@property (nonatomic,strong) TIBLECBKeyfob *t; //We connect to l8 through TIBLECBKeyfob 

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.t = [[TIBLECBKeyfob alloc] init];   // Init TIBLECBKeyfob class.
    [self.t controlSetup:1];                 // Do initial setup of TIBLECBKeyfob class.
    self.t.delegate = self;                  // set delegate 

    [super viewDidLoad];
   
    [self initConnection];                  //We have to wait one second beacuse bluetooth must be ready before try to connect to l8 
}


@end

```


