//
//  CDRAppDelegate.m
//  CDRTranslucentSideBar
//
//  Created by UetaMasamichi on 2014/06/02.
//  Copyright (c) 2014年 nscallop. All rights reserved.
//

#import "CDRAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "Singleton.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "Nonacademicdashboard.h"
#import "CDRViewController.h"
#import "DriverMessageScreen.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation CDRAppDelegate
{
    UIStoryboard *storyboard;
    NSTimer *mytimer;
    NSString *sendloc;
    int j;
    NSString *latitudehome;
    NSString *longitudehome;
    NSString *latitudeschool;
    NSString *longitudeschool;
    CLLocationManager *locationManager;
    NSString *routeid;
    NSString *branchid;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    
//    UIUserNotificationType types = UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//    
//    UIUserNotificationSettings *mySettings =
//    [UIUserNotificationSettings settingsForTypes:types categories:nil];
//    
//    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    locationManager = [[CLLocationManager alloc] init];
    
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *level= [prefs stringForKey:@"level"];
    
    
    NSString *id1 = [prefs stringForKey:@"id"];
    NSString *setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    
    if (id1 == nil)
    {
        UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        [self.window setRootViewController:initialVC];
        [self.window makeKeyAndVisible];
    }
    else
    {
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@validuser.php?user_id=%@&deviceid=%@&level=%@",[[Singleton sharedSingleton] getBaseURL],id1,setid,level];
        NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url];
        
        NSError * error;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        //  NSString *webStatus = [json objectForKey:@"status"];
        if ([[json valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            if ([level isEqual:@"teacher"])
            {
                UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"TeacherDashboard"];
                
                [self.window setRootViewController:initialVC];
                [self.window makeKeyAndVisible];
            }
            else if ([level isEqual:@"parent"])
            {
                UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"CDRViewController"];
                
                [self.window setRootViewController:initialVC];
                [self.window makeKeyAndVisible];
            }
            
            else if ([level isEqual:@"driver"])
            {
                UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                
                [self.window setRootViewController:initialVC];
                [self.window makeKeyAndVisible];
            }
            else if ([level isEqual:@"nonacademic"])
            {
                UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                
                [self.window setRootViewController:initialVC];
                [self.window makeKeyAndVisible];
            }
            else
            {
                
            }
            
        }
        
        else
        {
            UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            
            [self.window setRootViewController:initialVC];
            [self.window makeKeyAndVisible];
            TLAlertView *alertView = [TLAlertView showInView:self.window withTitle:@"SMBConnect" message:[json objectForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
            
        }
    }

	// Override point for customization after application launch.
	return YES;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *tokenString = [deviceToken description];
    tokenString = [tokenString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    tokenString = [tokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [prefs setValue:tokenString forKey:@"MyAppSpecificGloballyUniqueString"];
    NSLog(@"%@",tokenString);
}
- (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    UIUserNotificationType types = UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =[UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badge"] intValue];
    
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive) {
        
    
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        NSRange rangeValue0 = [message rangeOfString:@"©" options:NSCaseInsensitiveSearch];
        
        if (rangeValue0.length > 0)
        {
            
            NSArray *arr=[message componentsSeparatedByString:@"©"];
            
            NSString *msg1=[arr objectAtIndex:0];
            NSString *msg2=[arr objectAtIndex:1];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *level= [prefs stringForKey:@"level"];
            NSRange rangeValue = [message rangeOfString:@"PICKHOME" options:NSCaseInsensitiveSearch];
            NSRange rangeValue1 = [message rangeOfString:@"DROPHOME" options:NSCaseInsensitiveSearch];
            if (rangeValue.length > 0)
            {
                
                
                [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
                [NSThread sleepForTimeInterval:0.5];
                NSArray *arr1=[msg2 componentsSeparatedByString:@"~"];
                routeid=[arr1 objectAtIndex:1];
                branchid=[arr1 objectAtIndex:2];
                
                sendloc=@"pick_home";
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                latitudeschool = [prefs stringForKey:@"latschool"];
                longitudeschool = [prefs stringForKey:@"longschool"];
                
                CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[latitudeschool floatValue] longitude:[longitudeschool floatValue]];
                CLLocation *location2 = [[CLLocation alloc] initWithLatitude:[latitudehome floatValue] longitude:[longitudehome floatValue]];
                NSLog(@"Distance i meters: %f", [location1 distanceFromLocation:location2]);
            
                mytimer = [NSTimer scheduledTimerWithTimeInterval: 5.0 target: self
                                                             selector: @selector(callAfterFiveSecond124:) userInfo: nil repeats: YES];
    
            }
            else if (rangeValue1.length > 0)
            {
                
                [NSThread sleepForTimeInterval:0.5];
                NSArray *arr1=[msg2 componentsSeparatedByString:@"~"];
                routeid=[arr1 objectAtIndex:1];
                branchid=[arr1 objectAtIndex:2];
                sendloc=@"drop_home";
                
                [self start];
                mytimer = [NSTimer scheduledTimerWithTimeInterval: 5.0 target: self
                                                             selector: @selector(callAfterFiveSecond124:) userInfo: nil repeats: YES];
               
            }
            else if ([msg2 isEqual:@"DRIVERS_BUS_STOP"])
            {
                
                [mytimer invalidate];
            }
            else if ([msg2 isEqual:@"DROPSCHOOL_END"])
            {
                [self end];
                [mytimer invalidate];
            }
            
            else
            {
                
                if ([msg1 isEqual:@"deactivate"])
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSString *id1 = [prefs stringForKey:@"id"];
                    NSString *setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
                    
                    NSString *myRequestString1 = [NSString stringWithFormat:@"%@logout.php?level=teacher&user_id=%@&device=%@",[[Singleton sharedSingleton] getBaseURL],id1,setid];
                    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    NSURL *url = [NSURL URLWithString:str1];
                    NSData * data=[NSData dataWithContentsOfURL:url];
                    
                    NSError * error;
                    
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
                    NSLog(@"%@",json);
                    UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                    
                    [self.window setRootViewController:initialVC];
                    [self.window makeKeyAndVisible];
                }
                else if ([level isEqual:msg1])
                {
                    UIApplicationState state=[application applicationState];
                    if (state==UIApplicationStateActive)
                    {
                        TLAlertView *alertView = [TLAlertView showInView:self.window withTitle:@"SMBConnect" message:msg2 confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
                        
                        [alertView handleCancel:^
                         {
                             
                         }
                                  handleConfirm:^{
                                      
                                  }];
                        [alertView show];
                    }
                    else
                    {
                        
                    }
                }
                else
                {
                    TLAlertView *alertView = [TLAlertView showInView:self.window withTitle:@"SMBConnect" message:@"To view this message,Please login Currectly." confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
                    
                    [alertView handleCancel:^
                     {
                         
                     }
                              handleConfirm:^{
                                  
                                  
                              }];
                    [alertView show];
                    
                }
            }
        }
        else
        {
            
            TLAlertView *alertView = [TLAlertView showInView:self.window withTitle:@"SMBConnect" message:message confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            [alertView show];
        }
    }
    else
    {
        
    }
}

-(void)start
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *id1 = [prefs stringForKey:@"id"];
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    NSString *otherStr =[NSString stringWithFormat:@"%@driverstatusupdate.php?driver_id=%@&pick_start=&pick_end=&drop_start=%@&drop_end=&route_id=%@&branch_id=%@",[[Singleton sharedSingleton] getBaseURL],id1,resultString,routeid,branch_id];
    
    NSString *str1 = [otherStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                }];
    [operation1 start];
}

-(void)end
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *id1 = [prefs stringForKey:@"id"];
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    NSString *otherStr =[NSString stringWithFormat:@"%@driverstatusupdate.php?driver_id=%@&pick_start=&pick_end=%@&drop_start=&drop_end=&route_id=%@&branch_id=%@",[[Singleton sharedSingleton] getBaseURL],id1,resultString,routeid,branch_id];
    
    NSString *str1 = [otherStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    [operation1 start];
}

-(void) callAfterFiveSecond124:(NSTimer*) t
{
    if ([sendloc isEqual:@"drop_home"])
    {
        j=j+5;
    }
    
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if(IS_OS_8_OR_LATER){
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    CLLocation *location = [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    [locationManager startUpdatingLocation];
    
    /*
          
     */
    latitudehome = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longitudehome = [NSString stringWithFormat:@"%f", coordinate.longitude];
    // [self.window makeToast:[NSString stringWithFormat:@"Latitude%@Longitude%@",latitudehome,longitudehome]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *id1 = [prefs stringForKey:@"id"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@driverlocation.php?route_id=%@&latitude=%@&longitude=%@&direction=%@&branch_id=%@&driver_id=%@",[[Singleton sharedSingleton] getBaseURL],routeid,latitudehome,longitudehome,sendloc,branchid,id1];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url1 = [NSURL URLWithString:str1];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"%@",dictionary1);
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          
                                      }];
    [operation1 start];
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
