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

