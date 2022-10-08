//
//  BusRouteScreen.m
//  SmbConnect
//
//  Created by apple on 10/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "BusRouteScreen.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "parentaboutus.h"
#import "parentcontactus.h"
#import "parentfeedback.h"
#import "parentprofile.h"
#import "ViewController.h"
#import "CDRViewController.h"
#import "custom.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "StudentListByRoute.h"
#import "BusRouteScreen.h"
#import "DriverMessageScreen.h"
#import "Driverdashboard.h"
#import "Pin.h"
#import <MapKit/MapKit.h>
#import "JPSThumbnailAnnotation.h"
#import "driverchangepassword.h"

@interface BusRouteScreen ()<CDRTranslucentSideBarDelegate,MKMapViewDelegate>
{
    UIButton *btnclk;
    NSUserDefaults *prefs;
    NSString *id1,*level,*setid;
    NSMutableArray *arryProfile;
    CLLocationManager *locationManager;
    NSTimer *myTimer;
    int i,h;
    NSMutableArray *arryList,*arryList1;
    NSMutableArray *arrtitle;
    NSMutableArray *arrParentname;
    NSMutableArray *arrsunbtitle;
    NSString *Profile;

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *allPins;
@property (nonatomic, strong) MKPolylineView *lineView;
@property (nonatomic, strong) MKPolyline *polyline;
- (IBAction)drawLines:(id)sender;
- (IBAction)undoLastPin:(id)sender;
@end

@implementation BusRouteScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sideBar = [[CDRTranslucentSideBar alloc] init];
    self.sideBar.sideBarWidth = self.view.frame.size.width*0.75;
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;
    
    UITableView *tableView = [[UITableView alloc] init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 30, tableView.bounds.size.width, tableView.bounds.size.height-30)];
    v.backgroundColor = [UIColor clearColor];
    [tableView setTableHeaderView:v];
    [tableView setTableFooterView:v];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    tableView.dataSource = self;
    tableView.delegate = self;
    [self.sideBar setContentViewInSideBar:tableView];

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    
    [mapview1 setCenterCoordinate:location.coordinate animated:NO];
    [UIView commitAnimations];
    dic=[[NSMutableDictionary alloc]init];
    mapview1.delegate = self;
    //[self.mapView addAnnotations:[self annotations]];
    [self getLat];
    // [self.view addSubview:map1];
    
    // Annotations
    [mapview1 addAnnotations:[self annotations]];
    mapview1.layer.borderWidth = 1;
    mapview1.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewPopupProfile setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    Profile = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    
}
-(CLLocationCoordinate2D) getLocation{
    CLLocationManager *locationManager1 = [[CLLocationManager alloc] init];
    locationManager1.delegate = self;
    locationManager1.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager1.distanceFilter = kCLDistanceFilterNone;
    [locationManager1 startUpdatingLocation];
    CLLocation *location = [locationManager1 location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}
- (NSArray *)annotations {
    
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"bus100.png"];
    empire.title = @"Alman School";
    empire.subtitle = @"Bus Is Here";
    CLLocationCoordinate2D coordinate = [self getLocation];
    
    empire.coordinate = coordinate;
    if(h==0)
    {
        MKCoordinateSpan span = {.latitudeDelta =  0.015, .longitudeDelta =  0.015};
        MKCoordinateRegion region = {empire.coordinate, span};
        [mapview1 setRegion:region animated:YES];
        h++;
    }
    else
    {
        
    }
    empire.disclosureBlock = ^{ NSLog(@"Location");
    };
    
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
    
}
-(void) callAfterFiveSecond1:(NSTimer*) t

{
    [self annotations];
}




#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
-(void)getLat
{
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *long1 = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    // Configure the new event with information from the location
    NSString *myRequestString1;
    
    if([prefs stringForKey:@"setdriverrouteid"]==NULL)
    {
        myRequestString1 = [NSString stringWithFormat:@"%@drivermap.php?driver_id=%@&latitude=%@&longitude=%@&route_id=",[[Singleton sharedSingleton] getBaseURL],id1,lat,long1];
    }
    else
    {
        myRequestString1 = [NSString stringWithFormat:@"%@drivermap.php?driver_id=%@&latitude=%@&longitude=%@&route_id=%@",[[Singleton sharedSingleton] getBaseURL],id1,lat,long1,[prefs stringForKey:@"setdriverrouteid"]];
    }
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",dictionary1);
        arryList=[[NSMutableArray alloc]init];
        arrsunbtitle=[[NSMutableArray alloc]init];
        arrtitle=[[NSMutableArray alloc]init];
        arrParentname=[[NSMutableArray alloc]init];
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                dic=[[NSMutableDictionary alloc]init];
                
                [dic setValue:[[[dictionary1 valueForKey:@"Post"] objectAtIndex:i] valueForKey:@"latitude"] forKey:@"Latitute"];
                [dic setValue:[[[dictionary1 valueForKey:@"Post"] objectAtIndex:i] valueForKey:@"longitude"] forKey:@"Longitute"];
                [arrtitle addObject:[[[dictionary1 valueForKey:@"Post"] objectAtIndex:i] valueForKey:@"name"]];
                [arrsunbtitle addObject:[[[dictionary1 valueForKey:@"Post"] objectAtIndex:i] valueForKey:@"contact"]];
                [arryList addObject:dic];
            }
            
            self.allPins = [[NSMutableArray alloc]init];
            
            NSLog(@"%@",arryList);
            for (i=0; i<arryList.count; i++) {
                [self addPinLatitute:[[[arryList objectAtIndex:i] valueForKey:@"Latitute"] floatValue] Longitute:[[[arryList objectAtIndex:i] valueForKey:@"Longitute"] floatValue] title:[arrtitle objectAtIndex:i] subtitle:[arrsunbtitle objectAtIndex:i]];
            }
        }
        else
        {
           /*
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];*/
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Error Retrieving Data" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
    }];
    [operation1 start];
    
}

- (void)addPinLatitute:(float)lat Longitute:(float)longi title:(NSString*)tle subtitle:(NSString*)stle{
    CLLocationCoordinate2D myCoordinate1 = {lat, longi};
    
    
    //Create your annotation
    
    Pin *newPin = [[Pin alloc]initWithCoordinate:myCoordinate1];
    newPin.title=tle;
    newPin.subtitle=stle;
    [mapview1 addAnnotation:newPin];
    [self.allPins addObject:newPin];
    // [self drawLines:self];
    
}


- (IBAction)btnClickedMenu:(id)sender {
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];

}

- (IBAction)btnClickedToggle:(id)sender {
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"Profile"
                     image: nil
                    target:self
                    action:@selector(btnProfileDetail:)],
      
      [KxMenuItem menuItem:@"About us"
                     image:nil
                    target:self
                    action:@selector(btnAbvoutUs:)],
      
      [KxMenuItem menuItem:@"Change User"
                     image:nil
                    target:self
                    action:@selector(btnChangeUser:)],
      
      [KxMenuItem menuItem:@"Logout"
                     image:nil
                    target:self
                    action:@selector(btnLogOut:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:view3 fromRect:btnObjToggle.frame menuItems:menuItems];
}
-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==tblProfile)
    {
        return arryProfile.count;
    }
    else
    {
        return 4;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView==tblProfile)
    {
        return 0;
    }
    else
    {
        return 60;
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(tableView==tblProfile)
    {
        return nil;
    }
    
    else  {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(54, 30, tableView.bounds.size.width - 50, 20)];
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 48,48)];
        img.image=[UIImage imageNamed:@"profile-avtar.png"];
        
        UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, tableView.bounds.size.width, 0.5f)];
        separatorLineView.backgroundColor = [UIColor blackColor];
        [headerView addSubview:separatorLineView];
        label.text = [NSString stringWithFormat:@"Welcome %@",[prefs objectForKey:@"name"]];
        [headerView addSubview:label];
        [headerView addSubview:img];
        return headerView;
        
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tblProfile)
    {
        return 44;
    }
    else
    {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tblProfile)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arryProfile[indexPath.row]];
        return ce;
    }
  else{
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
      if (cell == nil)
      {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
          cell.backgroundColor = [UIColor clearColor];
      }
      UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(44, 42, cell.frame.size.width-44, 2)];
      lblline.text=@"";
      lblline.backgroundColor=[UIColor colorWithRed:53.0/255.0 green:78.0/255.0 blue:111.0/255.0 alpha:1.0];
      
      [cell addSubview:lblline];
      UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,44,44)];
      if ([Profile isEqual:@"driver"])
      {
          if (indexPath.row == 0) {
              cell.textLabel.text = @"        Dashboard";
              img.image=[UIImage imageNamed:@"deshboard60.png"];
              [cell addSubview:img];
          }
          else if (indexPath.row == 1) {
              cell.textLabel.text = @"        Student By Route";
              img.image=[UIImage imageNamed:@"std_route.png"];
              [cell addSubview:img];
          }
          else if (indexPath.row == 2) {
              cell.textLabel.text = @"        Road Map";
              img.image=[UIImage imageNamed:@"tracking-bus-icon.png"];
              [cell addSubview:img];
          }
          else if (indexPath.row == 3) {
              cell.textLabel.text = @"        Change Password";
              img.image=[UIImage imageNamed:@"change-icon.png"];
              [cell addSubview:img];
          }
          
          return cell;
      }
      else
      {
          if (indexPath.row == 0) {
              cell.textLabel.text = @"        Dashboard";
              img.image=[UIImage imageNamed:@"deshboard60.png"];
              [cell addSubview:img];
          }
          else if (indexPath.row == 1) {
              cell.textLabel.text = @"        Change Password";
              img.image=[UIImage imageNamed:@"change-icon.png"];
              [cell addSubview:img];
          }
          return cell;
      }
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // you can use "indexPath" to know what cell has been selected as the following
    NSLog(@"Selected row is %@", indexPath);
    if(tableView==tblProfile)
    {
        Profile=[arryProfile objectAtIndex:indexPath.row];
        
        if ([Profile isEqual:@"Non Academic"])
        {
            Profile=@"nonacademic";
        }
        else
        {
            Profile=[[[Profile substringToIndex:1] lowercaseString] stringByAppendingString:[Profile substringFromIndex:1]];
        }
        
        
        if ([Profile isEqual:level])    {
            [viewPopupProfile setHidden:YES];
            
        }
        else
        {
            [self getAnotherProfile];
            if ([Profile isEqual:@"parent"])
            {
                [prefs setObject:Profile forKey:@"level"];
                CDRViewController *TeacherDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"CDRViewController"];
                [self presentViewController:TeacherDashboard animated:YES completion:nil];
            }
            else if ([Profile isEqual:@"teacher"])
            {
                [prefs setObject:Profile forKey:@"level"];
                TeacherDashboard *Driverdashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"TeacherDashboard"];
                [self presentViewController:Driverdashboard animated:YES completion:nil];
            }
            else
            {
                [prefs setObject:Profile forKey:@"level"];
                Driverdashboard *Driverdashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                [self presentViewController:Driverdashboard animated:YES completion:nil];
            }
        }
        
    }
    else
    {
        if ([Profile isEqual:@"driver"])
        {
            if (indexPath.row==0)
            {
                Driverdashboard *TeacherDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                [self presentViewController:TeacherDashboard animated:YES completion:nil];
                
            }
            else if (indexPath.row==1)
            {
                StudentListByRoute *sendclassroommessage=[self.storyboard instantiateViewControllerWithIdentifier:@"StudentListByRoute"];
                [self presentViewController:sendclassroommessage animated:YES completion:nil];
                
            }
            else if (indexPath.row==2)
            {
                BusRouteScreen *Sendstudentmessage=[self.storyboard instantiateViewControllerWithIdentifier:@"BusRouteScreen"];
                [self presentViewController:Sendstudentmessage animated:YES completion:nil];
                
            }
            else if (indexPath.row==3)
            {
                driverchangepassword *ClassAssignment=[self.storyboard instantiateViewControllerWithIdentifier:@"driverchangepassword"];
                [self presentViewController:ClassAssignment animated:YES completion:nil];
                
            }
        }
        else
        {
            if (indexPath.row==0)
            {
                Driverdashboard *TeacherDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                [self presentViewController:TeacherDashboard animated:YES completion:nil];
                
            }
            else if (indexPath.row==1)
            {
                driverchangepassword *sendclassroommessage=[self.storyboard instantiateViewControllerWithIdentifier:@"driverchangepassword"];
                [self presentViewController:sendclassroommessage animated:YES completion:nil];
            }

    }
}
}
-(void)getAnotherProfile
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@toggle.php?user_id=%@&profile=%@&deviceid=%@&devicetype=iphone",[[Singleton sharedSingleton] getBaseURL],id1,Profile,setid];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arryProfile=[[NSMutableArray alloc]init];
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            
        }
        else
        {
            
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [operation1 start];
}

-(IBAction)btnProfileDetail:(id)sender{
    parentprofile *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentprofile"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
}
-(IBAction)btnContacUs:(id)sender{
    parentcontactus *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentcontactus"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
}
-(IBAction)btnFeedback:(id)sender{
    parentfeedback *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentfeedback"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
}
- (IBAction)btnAbvoutUs:(id)sender{
    parentaboutus *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentaboutus"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
}
-(IBAction)btnChangeUser:(id)sender{
   [self getChangeUser];
}
-(void)getChangeUser
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@profile.php?user_id=%@&profile=%@",[[Singleton sharedSingleton] getBaseURL],id1,level];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arryProfile=[[NSMutableArray alloc]init];
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++)
            {
                NSString *text = [NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"profile"]];
                NSString *capitalized;
                if ([text isEqual:@"nonacademic"])
                {
                    capitalized=@"Non Academic";
                }
                else
                {
                    capitalized = [[[text substringToIndex:1] uppercaseString] stringByAppendingString:[text substringFromIndex:1]];
                }
                [arryProfile addObject:capitalized];
            }
            [tblProfile reloadData];
            [viewPopupProfile setHidden:NO];

        }
        else
        {
            
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Error Retrieving Data" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
    }];
    [operation1 start];
}
-(IBAction)btnLogOut:(id)sender{
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@logout.php?level=%@&user_id=%@&device=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"level"],[prefs stringForKey:@"id"],[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"]];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    if ([[json valueForKey:@"status"] isEqualToString:@"YES"] )
    {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [prefs removePersistentDomainForName:appDomain];
        [prefs synchronize];
        ViewController *ViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self presentViewController:ViewController animated:YES completion:nil];
    }
    else
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[json objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];

    }
    
}

@end
