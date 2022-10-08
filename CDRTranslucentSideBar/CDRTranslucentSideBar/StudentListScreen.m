//
//  StudentListScreen.m
//  CDRTranslucentSideBar
//
//  Created by apple on 19/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "StudentListScreen.h"
#import "custom.h"
#import "CDRTranslucentSideBar.h"
#import "Singleton.h"
#import "AFNetworking.h"
#import "KxMenu.h"
#import "parentaboutus.h"
#import "parentcontactus.h"
#import "parentfeedback.h"
#import "parentprofile.h"
#import "SVProgressHUD.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "CDRViewController.h"
#import "parentImagegallery.h"
#import "parentvideocallery.h"
#import "Result.h"
#import "FeesScreen.h"
#import "LeaveApplicationScreen.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "parentlocatebus.h"
#import "parentevent.h"
#import "parenthomework.h"
#import "parentattendencesheet.h"
#import "driverchangepassword.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface StudentListScreen ()<CDRTranslucentSideBarDelegate>
{
    UIButton *btnclk;
    NSMutableArray *arrStudent,*arrBranch,*arrClass,*arrStudid,*arryProfile,*arrySchool,*arryClass,*arryDivision,*arryRoot,*arrschoolid,*arrrootid,*arrdiviid,*arrgetrootid,*arrmaplisst;
    NSInteger Stuid,school,class,division,root;
    int i,flag,dropdown;
    NSString *branch_id,*UpdateName,*UpdateSchoolname,*Profile,*id1,*stdname,*stdid,*level,*setid,*getrootid;
    NSUserDefaults *prefs;
   UITableView *tableView1;
    MyAnnotation *myPin ;
    CLLocationManager *locationManager;
     CLLocationCoordinate2D droppedAt,currentloc;
    
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation StudentListScreen
@synthesize mapView;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.sideBar = [[CDRTranslucentSideBar alloc] init];
    self.sideBar.sideBarWidth = self.view.frame.size.width*0.75;
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;
    
    tableView1 = [[UITableView alloc] init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 30, tableView1.bounds.size.width, tableView1.bounds.size.height-30)];
    v.backgroundColor = [UIColor clearColor];
    [tableView1 setTableHeaderView:v];
    [tableView1 setTableFooterView:v];
    [tableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [self.sideBar setContentViewInSideBar:tableView1];

    tblStudentList.layer.borderWidth = 1;
    tblStudentList.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    viewModify.layer.borderWidth = 1;
    viewModify.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];
    
    viewAddStudent.layer.borderWidth = 1;
    viewAddStudent.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];
    
    viewUpdateStudent.layer.borderWidth = 1;
    viewUpdateStudent.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];

    txtName.layer.borderWidth = 1;
    txtName.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
     txtSelectClass.layer.borderWidth = 1;
    txtSelectClass.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
     txtSelectDivision.layer.borderWidth = 1;
    txtSelectDivision.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
     txtSelectRoute.layer.borderWidth = 1;
    txtSelectRoute.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
     txtSelectSchool.layer.borderWidth = 1;
    txtSelectSchool.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    
    txtUpdateName.layer.borderWidth = 1;
    txtUpdateName.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtUpdateSelectClass.layer.borderWidth = 1;
    txtUpdateSelectClass.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtUpdateSelectDivision.layer.borderWidth = 1;
    txtUpdateSelectDivision.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtUpdateSelectRoute.layer.borderWidth = 1;
    txtUpdateSelectRoute.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtUpdateSelectSchool.layer.borderWidth = 1;
    txtUpdateSelectSchool.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    mapView.showsUserLocation = YES;

    mapView.layer.borderWidth = 1;
    mapView.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)zoomIn:(id)sender {
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 23152,723350);
    [mapView setRegion:region animated:NO];
}

- (IBAction)changeMapType:(id)sender {
    if (mapView.mapType == MKMapTypeStandard)
        mapView.mapType = MKMapTypeSatellite;
    else
        mapView.mapType = MKMapTypeStandard;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation: (MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]])
    {
        [Dropobj fadeOut];
    }

    [viewPopupProfile setHidden:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    mapView.showsUserLocation=NO;
    myPin = [[MyAnnotation alloc] initWithCoordinate:self.mapView.centerCoordinate]; // Or whatever coordinates...
    [self.mapView addAnnotation:myPin];
    [self getChildList];
    stdid=[prefs stringForKey:@"stdid"];
    stdname=[prefs stringForKey:@"stdname"];
    getrootid=[prefs stringForKey:@"root_id"];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if(IS_OS_8_OR_LATER){
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    CLLocation *location = [locationManager location];
    // Configure the new event with information from the location
    droppedAt = [location coordinate];
    [locationManager startUpdatingLocation];
   
   
    arrmaplisst=[[NSMutableArray alloc]initWithObjects:@"Standard Map",@"Satellite Map",@"Hybrid Map", nil];
    txtmapname.text=@"Standard Map";
    
   // flag=0;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        currentloc = [currentLocation coordinate];

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tblStudentList)
    {
        return 1;
    }
    else if(tableView==tblProfile)
    {
        return 1;
    }

    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==tblStudentList)
    {
        return arrStudid.count;
    }
    else if (tableView==tblProfile)
    {
        return arryProfile.count;
    }

    else
    {
        return 11;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView==tblStudentList)
    {
        return 0;
    }
    else if (tableView==tblProfile)
    {
        return 0;
    }

    else
    {
        return 80;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView==tblStudentList)
    {
        return nil;
    }
    else if(tableView==tblProfile)
    {
        return nil;
    }
    else
    {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 80)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(54, 32, tableView.bounds.size.width - 50, 20)];
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
        img.image=[UIImage imageNamed:@"profile-avtar.png"];
        
        UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(10.0,60.0,140,20)];
        
        [button setTitle:@"Select Student" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:234.0/255.0 green:150.0/255.0 blue:94.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button addTarget: self action: @selector(headerTapped:)forControlEvents: UIControlEventTouchUpInside];
        [headerView addSubview:button];
        
        [tableView.tableHeaderView insertSubview:headerView atIndex:0];
        UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, tableView.bounds.size.width, 0.5f)];
        separatorLineView.backgroundColor = [UIColor blackColor];
        [headerView addSubview:separatorLineView];
        label.text = stdname;
        [headerView addSubview:label];
        [headerView addSubview:img];
        return headerView;


    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==tblStudentList)
    {
        return 58;
    }
    else if (tableView==tblProfile)
    {
        return 44;
    }
    else
    {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==tblStudentList)
    {
        
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        //CustomcarCell *cell = (CustomcarCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arrStudent[indexPath.row]];
        ce.lblStudentStd.text=[NSString stringWithFormat:@"%@",arrClass[indexPath.row]];
        ce.lblSchoolName.text=[NSString stringWithFormat:@"%@",arrBranch[indexPath.row]];
        return ce;
    }
    else if (tableView==tblProfile)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        //CustomcarCell *cell = (CustomcarCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arryProfile[indexPath.row]];
        return ce;
    }

    else
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        
        UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(44, 42, cell.frame.size.width-44, 2)];
        lblline.text=@"";
        lblline.backgroundColor=[UIColor colorWithRed:53.0/255.0 green:78.0/255.0 blue:111.0/255.0 alpha:1.0];
        
        UILabel *lbllinecolor=[[UILabel alloc]initWithFrame:CGRectMake(44,0, cell.frame.size.width-44,cell.frame.size.height)];
        lblline.text=@"";
        lbllinecolor.backgroundColor=[UIColor whiteColor];
        //[cell addSubview:lbllinecolor];
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [cell addSubview:lblline];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"        Dashboard";
            
            img.image=[UIImage imageNamed:@"deshboard60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"        Fees";
            img.image=[UIImage imageNamed:@"fee60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"        Student Info";
            img.image=[UIImage imageNamed:@"addstudent60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 3) {
            cell.textLabel.text = @"        Result";
            img.image=[UIImage imageNamed:@"result60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 4) {
            cell.textLabel.text = @"        Events";
            img.image=[UIImage imageNamed:@"event60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 5) {
            cell.textLabel.text = @"        Homework";
            img.image=[UIImage imageNamed:@"home60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 6) {
            cell.textLabel.text = @"        Leave Application";
            img.image=[UIImage imageNamed:@"leave60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 7) {
            cell.textLabel.text = @"        Tracking";
            img.image=[UIImage imageNamed:@"traking60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 8) {
            cell.textLabel.text = @"        Photo Gallery";
            img.image=[UIImage imageNamed:@"photo60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 9) {
            cell.textLabel.text = @"        Video Gallery";
            img.image=[UIImage imageNamed:@"video60.png"];
            [cell addSubview:img];
        }
        
        else if (indexPath.row == 10) {
            cell.textLabel.text = @"        Change Password";
            img.image=[UIImage imageNamed:@"change-icon.png"];
            [cell addSubview:img];
        }
        else
        {}

        
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row is %@", indexPath);
    if(tableView==tblStudentList)
    {
        Stuid=indexPath.row;
        [btnobjTrasparent setHidden:NO];
        [viewModify setHidden:NO];
       // [btnObjAddStudent setHidden:YES];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [[viewModify layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    }
    else if(tableView==tblProfile)
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
            if ([Profile isEqual:@"teacher"])
            {
                [prefs setObject:Profile forKey:@"level"];
                TeacherDashboard *TeacherDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"TeacherDashboard"];
                [self presentViewController:TeacherDashboard animated:YES completion:nil];
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
        if (indexPath.row==0)
        {
            CDRViewController *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"CDRViewController"];
            [self presentViewController:parentprofile animated:YES completion:nil];
            
        }
        else if (indexPath.row==1)
        {
            FeesScreen *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"FeesScreen"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==2)
        {
            StudentListScreen *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"StudentListScreen"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==3)
        {
            Result *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"Result"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==4)
        {
            parentevent *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"parentevent"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==5)
        {
            parenthomework *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"parenthomework"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==6)
        {
            parentattendencesheet *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"parentattendencesheet"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==7)
        {
            parentlocatebus *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"parentlocatebus"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==8)
        {
            parentImagegallery *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"parentImagegallery"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==9)
        {
            parentvideocallery *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"parentvideocallery"];
            [self presentViewController:FeesScreen animated:YES completion:nil];
            
        }
        else if (indexPath.row==10)
        {
            driverchangepassword *sendclassroommessage=[self.storyboard instantiateViewControllerWithIdentifier:@"driverchangepassword"];
            [self presentViewController:sendclassroommessage animated:YES completion:nil];
        }
        else
        {
            
        }

    }
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
            
            [SVProgressHUD dismiss];        }];
        [operation1 start];
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
            
            // 4
            //        [ILAlertView showWithTitle:@"Error Retrieving Data"
            //                           message:[error localizedDescription]
            //                  closeButtonTitle:@"OK"
            //                 secondButtonTitle:nil
            //                tappedSecondButton:nil];
        }];
        [operation1 start];
}

- (IBAction)btnselctmap:(id)sender {
    
    dropdown=100;
    [self showPopUpWithTitle:@"Select Maptype" withOption:arrmaplisst xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];

    
}

- (IBAction)btnmapsave:(id)sender {
    viewlocation.hidden=YES;
}

- (IBAction)btnClickedClose:(id)sender {
    [btnobjTrasparent setHidden:YES];
    [viewModify setHidden:YES];
     //[btnObjAddStudent setHidden:NO];
    
    
}

- (IBAction)btnClickedEdit:(id)sender {
    [btnobjTrasparent setHidden:NO];
    [viewUpdateStudent setHidden:NO];
   // [btnObjAddStudent setHidden:YES];
    //[tblStudentList setHidden:YES];
    [viewModify setHidden:YES];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[viewUpdateStudent layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    flag=1;
    [self display];
    
}
-(void)display
{
     NSString *delid=[arrStudid objectAtIndex:Stuid];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *otherStr =[NSString stringWithFormat:@"%@showstudentdetails.php?stud_id=%@",[[Singleton sharedSingleton] getBaseURL],delid];
    
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:otherStr]];
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    
    NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
    
    NSLog(@"reslt == %@",result);
    NSString *msg=[result objectForKey:@"status"];
    
    
    if ([msg isEqual:@"YES"])
    {
        NSArray *dic=[result objectForKey:@"Post"];
        for (int i1=0; i1<dic.count; i1++)
        {
            NSDictionary *dic1=[dic objectAtIndex:0];
            branch_id=[dic1 objectForKey:@"branch_id"];
            class=[[dic1 objectForKey:@"class_id"]intValue];
            division=[[dic1 objectForKey:@"div_id"] intValue];
            root=[[dic1 objectForKey:@"bus_id"]intValue];
            UpdateName=[dic1 objectForKey:@"name"];
            UpdateSchoolname=[dic1 objectForKey:@"school_name"];
            
            txtUpdateSelectDivision.text=[dic1 objectForKey:@"division"];
            txtUpdateSelectClass.text=[dic1 objectForKey:@"class"];
            txtUpdateSelectRoute.text=[dic1 objectForKey:@"root_name"];
            txtUpdateName.text=[dic1 objectForKey:@"name"];
            txtUpdateSelectSchool.text=[dic1 objectForKey:@"school_name"];
            
            droppedAt.latitude=[[dic1 objectForKey:@"latitude"]floatValue];
            droppedAt.longitude=[[dic1 objectForKey:@"longitude"]floatValue];
            
        }
        
    }
    else
    {
        
    }
    [SVProgressHUD dismiss];
    
}

- (IBAction)btnClickedDelete:(id)sender {
    NSString *delid=[arrStudid objectAtIndex:Stuid];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    
    NSString *appurl =[NSString stringWithFormat:@"%@deletestudent.php?",[[Singleton sharedSingleton] getBaseURL]];
    
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:appurl]];
    
    [requestsASI addPostValue:delid forKey:@"stud_id"];
    
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    
    NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
    
    NSLog(@"reslt == %@",result);
    [viewModify setHidden:YES];
    [self getChildList];
    [SVProgressHUD dismiss];
}
- (IBAction)btnClickedTrasparent:(id)sender {
    [btnobjTrasparent setHidden:YES];
    [viewModify setHidden:YES];
    [viewAddStudent setHidden:YES];
   // [btnObjAddStudent setHidden:NO];
    [viewUpdateStudent setHidden:YES];
}

- (IBAction)btnClickedClose1:(id)sender {
    [btnobjTrasparent setHidden:YES];
    [viewAddStudent setHidden:YES];
    //[btnObjAddStudent setHidden:NO];
    txtName.text=@"";
    txtSelectClass.text=@"";
    txtSelectDivision.text=@"";
    txtSelectRoute.text=@"";
    txtSelectSchool.text=@"";
   

}

- (IBAction)btnClickedSubmit:(id)sender {
    
    
    if([txtSelectSchool.text isEqualToString:@""] || [txtSelectClass.text isEqualToString:@""] || [txtSelectDivision.text isEqualToString:@""] || [txtName.text isEqualToString:@""])
    {
        
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Fillup All Information" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];    }
    else
    {

            [self submit];
    
        
    }

    
}
-(void)submit
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    
    if ([txtSelectRoute.text isEqualToString:@""])
    {
        root=0;
    }
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@addstudent.php?school_id=%ld&parent_id=%@&class_id=%ld&div_id=%ld&name=%@&latitude=%f&longitude=%f&bus_id=%ld",[[Singleton sharedSingleton] getBaseURL],(long)school,[prefs objectForKey:@"id"],(long)class,(long)division,txtName.text,droppedAt.latitude,droppedAt.longitude,(long)root];
    
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    // 2
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            [viewAddStudent setHidden:YES];
           
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
            
            txtSelectSchool.text=@"";
            txtSelectClass.text=@"";
            txtSelectDivision.text=@"";
            txtSelectRoute.text=@"";
            txtName.text=@"";
            [self getChildList];
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
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
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
    
}

- (IBAction)btnClickedAddStudent:(id)sender {
    [btnobjTrasparent setHidden:NO];
    [viewAddStudent setHidden:NO];
    //[btnObjAddStudent setHidden:YES];
    [lblAddEdit setText:[NSString stringWithFormat:@"Add Student"]];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[viewAddStudent layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    flag=0;
}

- (IBAction)btnClickedMenu:(id)sender {
    [self.sideBar show];
    view1.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
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
      
      [KxMenuItem menuItem:@"Contact Us"
                     image: nil
                    target:self
                    action:@selector(btnContacUs:)],
      [KxMenuItem menuItem:@"Feedback"
                     image:nil
                    target:self
                    action:@selector(btnFeedback:)],
      
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
    [KxMenu showMenuInView:view1 fromRect:btnObjToggle.frame menuItems:menuItems];

}

- (IBAction)btnClickedClose2:(id)sender {
    [btnobjTrasparent setHidden:YES];
    [viewUpdateStudent setHidden:YES];
  //  [btnObjAddStudent setHidden:NO];
    [viewModify setHidden:YES];
    [tblStudentList setHidden:NO];
}

- (IBAction)btnUpdateSubmit:(id)sender {
    
        NSString *delid=[arrStudid objectAtIndex:Stuid];
    
        [SVProgressHUD showProgress:0 status:@"Loading"];
        
        if ( [txtUpdateSelectRoute.text isEqualToString:@""] )
        {
            root=0;
        }
    if ((droppedAt.latitude==0.000) && (droppedAt.longitude == 0.000))
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        droppedAt=currentloc;
        //UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%f",currentloc.latitude] message:[NSString stringWithFormat:@"%f",currentloc.latitude] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      //  [alert show];
        // Configure the new event with information from the location
    
      
    }
    else
    {
        
    }
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@editstudent.php?stud_id=%@&div_id=%ld&name=%@&latitude=%f&longitude=%f&bus_id=%ld",[[Singleton sharedSingleton] getBaseURL],delid,(long)division,txtUpdateName.text,droppedAt.latitude,droppedAt.longitude,(long)root];
        
        NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        NSURL *url1 = [NSURL URLWithString:str];
        
        NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
        // 2
        AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
        operation1.responseSerializer = [AFJSONResponseSerializer serializer];
        operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            dictionary1 = (NSMutableDictionary *)responseObject;
            
            NSLog(@"%@",dictionary1);
            if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
            {
                [viewUpdateStudent setHidden:YES];
                [viewModify setHidden:YES];
                //[btnObjAddStudent setHidden:NO];
                

                TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Update Successful" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
                
                [alertView handleCancel:^
                 {
                     
                 }
                          handleConfirm:^{
                              
                          }];
                [alertView show];
                
                [SVProgressHUD dismiss];
                
                txtUpdateSelectSchool.text=@"";
                txtUpdateSelectClass.text=@"";
                txtUpdateSelectDivision.text=@"";
                txtUpdateSelectRoute.text=@"";
                txtUpdateName.text=@"";
                [self getChildList];
                [tblStudentList setHidden:NO];

            }
            else
            {

                TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
                
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
            
            [SVProgressHUD dismiss];
        }];
        [operation1 start];
    }

- (IBAction)btnclkmylocation:(id)sender {
    
    [viewlocation setHidden:NO];
    mapView.delegate=self;
    mapView.mapType = MKMapTypeStandard;
    MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
    MKCoordinateRegion region = {droppedAt, span};
    
    [mapView setRegion:region animated:YES];
    
    myPin.coordinate=droppedAt;
}


-(IBAction)aMethod:(id)sender
{
    view1.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    fortag=textField.tag;
    if(flag==0)
    {
        if (i==4) {
            i=0;
        }
        if(textField.tag==0)
        {
            //fortag=0;
            [self getSchool];
            [txtName resignFirstResponder];
            //        [txtSelectClass setEnabled:YES];
            //        [txtSelectDivision setEnabled:NO];
            return NO;
        }
        else if (textField.tag==1)
        {
            // fortag=1;
            [self getClass];
            
            [txtName resignFirstResponder];
            //        [txtSelectDivision setEnabled:YES];
            return NO;
        }
        else if (textField.tag==2)
        {
            // fortag=2;
            [self getDivision];
            [txtName resignFirstResponder];
            return NO;
        }
        else if (textField.tag==3)
        {
            // fortag=2;
            [self getSelectRoot];
            [txtName resignFirstResponder];
            
            return NO;
        }

    }
    else{
        if (i==4) {
            i=1;
        }
        if (textField.tag==1)
        {
            // fortag=1;
            [self getClass1];
            [txtUpdateName resignFirstResponder];
            
            //        [txtSelectDivision setEnabled:YES];
            return NO;
        }
        else if (textField.tag==2)
        {
            // fortag=2;
            [self getDivision];
            [txtUpdateName resignFirstResponder];
            
            return NO;
        }
        else if (textField.tag==3)
        {
            // fortag=2;
            [self getSelectRoot];
            [txtUpdateName resignFirstResponder];
            
            return NO;
        }
        return YES;

    }
   //    else
//    {
//        viewAddStudent.frame=CGRectMake(viewAddStudent.frame.origin.x,viewAddStudent.frame.origin.y-110,viewAddStudent.frame.size.width,viewAddStudent.frame.size.height+110);
//        
//    }
    return YES;
}
- (IBAction)headerTapped:(id)sender
{
    dropdown=10;
    [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
    
}


-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultipl{
    
    if (dropdown==10)
    {
            Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
            Dropobj.delegate = self;
            [Dropobj showInView:self.view animated:YES];
        
            /*----------------Set DropDown backGroundColor-----------------*/
             [Dropobj SetBackGroundDropDwon_R:12.0/255.0 G:158.0/255.0 B:239.0/255.0 alpha:1.0];
        
    }
    if (dropdown==100)
    {
        Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
        Dropobj.delegate = self;
        [Dropobj showInView:self.view animated:YES];
        
        /*----------------Set DropDown backGroundColor-----------------*/
        [Dropobj SetBackGroundDropDwon_R:12.0/255.0 G:158.0/255.0 B:239.0/255.0 alpha:1.0];
        
    }
    else
    {
        i++;
        Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
        Dropobj.tag=i;
        Dropobj.delegate = self;
        [Dropobj showInView:self.view animated:YES];
        
        /*----------------Set DropDown backGroundColor-----------------*/
        [Dropobj SetBackGroundDropDwon_R:12.0/255.0 G:158.0/255.0 B:239.0/255.0 alpha:1.0];
    }
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    if (dropdown==10)
    {
            stdname=[arrStudent objectAtIndex:anIndex];
            stdid=[arrStudid objectAtIndex:anIndex];
            [prefs setObject:stdid forKey:@"stdid"];
            [prefs setObject:stdname forKey:@"stdname"];
            getrootid=[arrgetrootid objectAtIndex:anIndex];
            [prefs setObject:getrootid forKey:@"root_id"];
            [prefs synchronize];
            [tableView1 reloadData];
        dropdown=11;
    }
    else if (dropdown==100)
    {
        txtmapname.text=[arrmaplisst objectAtIndex:anIndex];
        if(anIndex==0)
        {
            mapView.mapType=MKMapTypeStandard;
        }
        else if (anIndex==2)
        {
            mapView.mapType=MKMapTypeHybrid;
        }
        else
        {
            mapView.mapType=MKMapTypeSatellite;
        }

        dropdown=11;
    }
    else
    {
        if(flag==0)
        {
            if(fortag==0)
            {
                [txtName resignFirstResponder];
                school=[arrschoolid[anIndex]integerValue];
                //        pay=pay_school[anIndex];
                //        amount=pay_amount[anIndex];
                txtSelectSchool.text=arrySchool[anIndex];
                [txtSelectClass setEnabled:YES];
                [txtSelectDivision setEnabled:NO];
                [txtSelectRoute setEnabled:NO];
            }
            else if (fortag==1)
            {
                [txtName resignFirstResponder];
                class=[classId[anIndex]integerValue];
                txtSelectClass.text=arryClass[anIndex];
                // txtUpdateSelectClass.text=arryClass[anIndex];
                [txtSelectDivision setEnabled:YES];
                [txtSelectRoute setEnabled:YES];
            }
            else if (fortag==2)
            {
                [txtName resignFirstResponder];
                division=[arrdiviid[anIndex]integerValue];
                txtSelectDivision.text=arryDivision[anIndex];
                // txtUpdateSelectDivision.text=arryDivision[anIndex];
            }
            else
            {
                [txtName resignFirstResponder];
                root=[arrrootid[anIndex]integerValue];
                txtSelectRoute.text=arryRoot[anIndex];
                //txtUpdateSelectRoute.text=arryRoot[anIndex];
            }
            
        }
        else{
            if (fortag==1)
            {
                class=[classId[anIndex]integerValue];
                txtUpdateSelectClass.text=arryClass[anIndex];
                division=[@"" intValue];
                txtUpdateSelectDivision.text=@"";
            }
            else if (fortag==2)
            {
                division=[arrdiviid[anIndex]integerValue];
                txtUpdateSelectDivision.text=arryDivision[anIndex];
            }
            else
            {
                root=[arrrootid[anIndex]integerValue];
                txtUpdateSelectRoute.text=arryRoot[anIndex];
            }
            
        }

    }
}

-(void)getChildList
{
    //AppDelegate *app=[[UIApplication sharedApplication]delegate];
   [SVProgressHUD showProgress:0 status:@"Loading"];
    arrStudent=[[NSMutableArray alloc]init];
    arrBranch=[[NSMutableArray alloc]init];
    arrClass=[[NSMutableArray alloc]init];
    arrStudid=[[NSMutableArray alloc]init];
    arrgetrootid=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@showchild.php?parent_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"]];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",dictionary);
        
        if ([[dictionary valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for(i=0;i<[[dictionary valueForKey:@"Post"]count];i++)
            {
                [arrStudent addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"student"]]];
                
                [arrBranch addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"branch"]]];
                
                [arrClass addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class"]]];
                
                [arrStudid addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"stud_id"]]];
                 [arrgetrootid addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"root_id"]]];
            }
            [prefs setObject:arrStudid forKey:@"arrStudid"];
            [prefs setObject:arrStudent forKey:@"arrStudent"];
            [prefs setObject:arrgetrootid forKey:@"arrrootid"];
            
            if(arrStudid.count>0)
            {
                [prefs setObject:[arrgetrootid objectAtIndex:0] forKey:@"root_id"];
                [prefs setObject:[arrStudid objectAtIndex:0] forKey:@"stdid"];
                [prefs setObject:[arrStudent objectAtIndex:0] forKey:@"stdname"];
                
            }
            else
            {
                
            }
            [prefs synchronize];
            
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD dismiss];
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
        [tblStudentList reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Error Retrieving Data" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
        
        [SVProgressHUD dismiss];
        
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
-(NSArray *)getSchool
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    txtSelectClass.text=@"";
    txtSelectDivision.text=@"";
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectschool.php?parent_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"]];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arrySchool=[[NSMutableArray alloc]init];
        arrschoolid=[[NSMutableArray alloc]init];
        cmp_id=[[NSMutableArray alloc]init];

        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arrySchool addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]] ];
                [arrschoolid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"branch_id"]] ];
            }
           
            [Dropobj fadeOut];
            [self showPopUpWithTitle:@"Select School" withOption:arrySchool xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
        }
        else
        {
            arrySchool=Nil;
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
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
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
    return arrySchool;
}

-(NSArray *)getClass
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    txtSelectDivision.text=@"";
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectclass.php?branch_id=%ld",[[Singleton sharedSingleton] getBaseURL],(long)school];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        classId=[[NSMutableArray alloc]init];
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arryClass=[[NSMutableArray alloc]init];
        
        // cmp_id=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arryClass addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                [classId addObject:[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]] ;
                NSLog(@"class id:%@",classId);
                
                //   [cmp_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"user_id"]] ];
            }
            
            [Dropobj fadeOut];
            [self showPopUpWithTitle:@"Select Class" withOption:arryClass xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
        }
        else
        {
            arryClass=Nil;
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
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
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
    return arryClass;
}
-(NSArray *)getClass1
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectclass.php?branch_id=%@",[[Singleton sharedSingleton] getBaseURL],branch_id];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        classId=[[NSMutableArray alloc]init];
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arryClass=[[NSMutableArray alloc]init];
        
        // cmp_id=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arryClass addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                [classId addObject:[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]] ;
                NSLog(@"class id:%@",classId);
                
                //   [cmp_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"user_id"]] ];
            }
            
            [Dropobj fadeOut];
            [self showPopUpWithTitle:@"Select Class" withOption:arryClass xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
        }
        else
        {
            arryClass=Nil;
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
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
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
    return arryClass;
}

-(NSArray *)getDivision
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectdivision.php?class_id=%ld",[[Singleton sharedSingleton] getBaseURL],(long)class];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    // 2
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arryDivision=[[NSMutableArray alloc]init];
        arrdiviid=[[NSMutableArray alloc]init];
        cmp_id=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arryDivision addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]] ];
                [arrdiviid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]]];
                //[divId addObject:[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]];
                NSLog(@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]);
                
                //                [ cmp_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"user_id"]] ];
            }
            
            [Dropobj fadeOut];
            [self showPopUpWithTitle:@"Select Division" withOption:arryDivision xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
        }
        else {
            arryDivision=Nil;
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];

        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Error Retrieving Data" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
    
    return arryDivision;
}
-(NSArray *)getSelectRoot
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    //branch_id
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectroot.php?branch_id=%@",[[Singleton sharedSingleton] getBaseURL],id1];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    // 2
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arryRoot=[[NSMutableArray alloc]init];
        arrrootid=[[NSMutableArray alloc]init];
        cmp_id=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            // NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            // NSString *id1 = [prefs stringForKey:@"root_id"];
            
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arryRoot addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"root_name"]] ];
                [arrrootid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"root_id"]] ];
                
                //                [ cmp_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"user_id"]] ];
            }
           
            [Dropobj fadeOut];
            [self showPopUpWithTitle:@"Select Route" withOption:arryRoot xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
        }
        else {
            arryRoot=Nil;
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
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
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
    
    return arryRoot;
}
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier: @"myPin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"myPin"] ; // If you use ARC, take out 'autorelease'
    } else {
        pin.annotation = annotation;
    }
    pin.animatesDrop = YES;
    pin.draggable = YES;
    
    return pin;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        droppedAt  = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
       // self.mapView.centerCoordinate =droppedAt;
        
        //[self.mapView removeAnnotation:myPin];
        
    }
}


@end
