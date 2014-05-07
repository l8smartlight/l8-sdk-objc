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
   
    [self initConnection];                  //We have to wait one second beacuse CoreBluetooth must be ready before try to connect to l8 device
}

-(void)initConnection{                      //you can wait one secand in this way
    double delayInSeconds = 1.0; 
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self connectToL8];     //connect to L8
    });

}

//we have to implement the following delegate methods

-(void)connectToL8{
    NSLog(@"Connecting with l8...");
    if (self.t.activePeripheral)                                                   //Checks if we have already any connection
        if(self.t.activePeripheral.isConnected)
            [[self.t CM] cancelPeripheralConnection:[self.t activePeripheral]];   //We cancel any previous connection
    if (self.t.peripherals)
        self.t.peripherals = nil;
    [self.t findBLEPeripherals:10];                                              //Scans during 10 seconds for L8 devices
    BluetoothL8 *l8Bluetooth=[[BluetoothL8 alloc]init];                          //Instantiates a BluetoothL8 and set TIBLECBKeyfob
    l8Bluetooth.t=self.t;
    self.l8Array=[[NSMutableArray alloc] initWithObjects:l8Bluetooth, nil];     //at this point we are not connected to an L8 device, we have to wait for keyfobReady invocation
}

-(void) keyfobReady{
    NSLog(@"bt ready");
    id<L8> l8=[self.l8Array lastObject];
    [l8 clearMatrixWithSuccess:^{NSLog(@"matrix cleared");} failure:^(NSMutableDictionary *result) {
        NSLog(@"Error matrix cleared");
    }];                                                  //this is a clear matrix operation.  
    for(int i=0;i<[[self.t userPeripherals] count];i++){
        
        
        if([[[[self.t userPeripherals] objectAtIndex:i] valueForKey:@"isUserChecked"] isEqualToString:@"YES"]){         //by default all detected device are select
            CBPeripheral * activePeripheralUser = [[[self.t userPeripherals] objectAtIndex:i] valueForKey:@"peripheral"];
            [self.t L8SL_PrepareForReceiveDataFromL8SL:activePeripheralUser];             //Prepares to receive from L8 device
            
            usleep(800);
        }
        
    }
    self.t.delegate=self;
    //At this point we are ready to operate with our L8 device
}

-(void)configUpdated:(NSData *)config{
    
}


-(void)TXPwrLevelUpdated:(char)TXPwr{
    
}

-(void)notificationRcvd:(Byte)not1{
    
}

-(void)keyValuesUpdated:(char)sw{
    
}

-(void)accelerometerValuesUpdated:(char)x y:(char)y z:(char)z{
    
}

-(void)batteryLevelRcvd:(Byte)batLvl{
    
}

-(void)processDataFromPeripheral:(NSData *)data{
    NSLog(@"data l8: %@",data);
}

@end

```

## 3. Interact with L8:

The followig examples are based on code above. We need a delegate of L8, it could be BluetoothL8 or RestfulL8 (simulator), in this case our example use a real L8 device:

```objective-c

id<L8> l8=[self.l8Array lastObject];

```

#### Set Super led:

```objective-c

//All code block types are defined in l8_sdk_objc.h

  L8VoidOperationHandler v = ^() {
            NSLog(@"success");
        };

L8JSONOperationHandler f = ^(NSMutableDictionary *r) {
            NSLog(@"failure: %@", r);
        };

 [l8 setSuperLED:[UIColor yellowColor] withSuccess:v failure:f];


```
#### Set led (x,y)

```objective-c

 [self.l8 setLED:CGPointMake(0, 0) color:[UIColor cyanColor] withSuccess:v failure:f];

```

#### Clear led (x,y)

```objective-c

[l8 clearLED:CGPointMake(7, 7) withSuccess:v failure:f];

```

#### Read led (x,y)

```objective-c

 L8ColorOperationHandler c = ^(UIColor *result) {
            NSLog(@"success: %@", [result stringValue]);
        };

  [l8 readLED:CGPointMake(2, 3) withSuccess:c failure:f];

```

#### Read superLed 

```objective-c

 L8ColorOperationHandler c = ^(UIColor *result) {
            NSLog(@"success: %@", [result stringValue]);
        };
        
     [l8 readSuperLEDWithSuccess:c failure:f];
     
```

#### Clear matrix

```objective-c

[l8 clearMatrixWithSuccess:v failure:f];

```

#### Set matrix

```objective-c

 NSString *check = @"#5cff5c-#60f83f-#5cff5c-#5cff5c-#5cff5c-#5cff5c-#5cff5c-#5cff5c-#00ff00-#60f83f-#60f83f-#60f83f-#00ff00-#00ff00-#ffffff-#ffffff-#60f83f-#60f83f-#60f83f-#00ff00-#ffffff-#ffffff-#ffffff-#ffffff-#34b918-#34b918-#34b918-#34b918-#ffffff-#ffffff-#34b918-#34b918-#ffffff-#ffffff-#34b918-#ffffff-#ffffff-#ffffff-#34b918-#34b918-#34b918-#ffffff-#ffffff-#ffffff-#ffffff-#34b918-#34b918-#03a603-#03a603-#03a603-#ffffff-#ffffff-#03a603-#03a603-#03a603-#03a603-#017001-#017001-#017001-#ffffff-#017001-#017001-#017001-#017001-#3dfa3d";
    NSArray *subStrings = [check componentsSeparatedByString:@"-#"];
    
    [l8  setMatrix:subStrings withSuccess:^{NSLog(@"send Ok");} failure:^(NSMutableDictionary *result) {
        NSLog(@"set Matrix ERROR");
    }];


```

#### Create animations

```objective-c

       NSMutableArray *colorMatrix1 = [NSMutableArray arrayWithCapacity:8];
        for (int i = 0; i < 8; i++) {
            [colorMatrix1 addObject:[NSMutableArray arrayWithCapacity:8]];
            for (int j = 0; j < 8; j++) {
                [[colorMatrix1 objectAtIndex:i] addObject:[UIColor redColor]];
            }
        }
        L8Frame *frame1 = [[L8Frame alloc] init];
        [frame1 setColorMatrix:colorMatrix1];
        [frame1 setDuration:100];
        
        NSMutableArray *colorMatrix2 = [NSMutableArray arrayWithCapacity:8];
        for (int i = 0; i < 8; i++) {
            [colorMatrix2 addObject:[NSMutableArray arrayWithCapacity:8]];
            for (int j = 0; j < 8; j++) {
                [[colorMatrix2 objectAtIndex:i] addObject:[UIColor blueColor]];
            }
        }
        L8Frame *frame2 = [[L8Frame alloc] init];
        [frame2 setColorMatrix:colorMatrix2];
        [frame2 setDuration:100];
        
        NSMutableArray *colorMatrix3 = [NSMutableArray arrayWithCapacity:8];
        for (int i = 0; i < 8; i++) {
            [colorMatrix3 addObject:[NSMutableArray arrayWithCapacity:8]];
            for (int j = 0; j < 8; j++) {
                [[colorMatrix3 objectAtIndex:i] addObject:[UIColor yellowColor]];
            }
        }
        L8Frame *frame3 = [[L8Frame alloc] init];
        [frame3 setColorMatrix:colorMatrix3];
        [frame3 setDuration:200];
        
        L8Animation *animation = [[L8Animation alloc] init];
        animation.frames = [NSMutableArray arrayWithObjects:frame1, frame2, frame3, nil];
        [l8 setAnimation:animation withSuccess:v failure:f];

```

#### Read L8 data (battery level, memory and so on)

```objective-c

        L8IntegerOperationHandler i = ^(NSInteger result) {
            NSLog(@"success: %d", result);
        };
        L8BooleanOperationHandler b = ^(BOOL result) {
            NSLog(@"success: %@", result? @"Y": @"N");
        };
        L8VersionOperationHandler r = ^(L8Version *result) {
            NSLog(@"success: %d %d", result.hardware, result.software);
        };

        [l8 readBatteryStatusWithSuccess:i failure:f];
        [l8 readButtonWithSuccess:i failure:f];
        [l8 readMemorySizeWithSuccess:i failure:f];
        [l8 readFreeMemoryWithSuccess:i failure:f];
        
        [l8 readBluetoothEnabledWithSuccess:b failure:f];
        
        [l8 readVersionWithSuccess:r failure:f];

```

#### Read data from sensors

```objective-c

        [l8 readSensorsStatusWithSuccess:^(NSArray *result) {
            NSLog(@"sensors %@", result);
        }
                                      failure:f];
        
        
        [l8 readSensorStatus:[L8Sensor temperatureSensor]
                      withSuccess:^(L8SensorStatus *result) {
                          L8TemperatureStatus *status = (L8TemperatureStatus *)result;
                          NSLog(@"temperature: %@", status);
                      }
                          failure:f];
        [l8 readSensorStatus:[L8Sensor proximitySensor]
                      withSuccess:^(L8SensorStatus *result) {
                          L8ProximityStatus *status = (L8ProximityStatus *)result;
                          NSLog(@"proximity: %@", status);
                      }
                          failure:f];
        [l8 readSensorStatus:[L8Sensor accelerationSensor]
                      withSuccess:^(L8SensorStatus *result) {
                          L8AccelerationStatus *status = (L8AccelerationStatus *)result;
                          NSLog(@"acceleration: %@", status);
                      }
                          failure:f];


```

## 4. Examples:

There is a complete application in [Countdown](https://github.com/l8smartlight/Countdown-for-ios) repository



