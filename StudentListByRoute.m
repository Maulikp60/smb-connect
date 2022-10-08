//
//  StudentListByRoute.m
//  SmbConnect
//
//  Created by apple on 10/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "StudentListByRoute.h"
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
#import "CDRViewController.h"
#import "ViewController.h"
#import "StudentListByRoute.h"
#import "BusRouteScreen.h"
#import "DriverMessageScreen.h"
#import "Driverdashboard.h"
#import "TeacherDashboard.h"
#import "driverchangepassword.h"


@interface StudentListByRoute ()<CDRTranslucentSideBarDelegate>{
    UIButton *btnclk;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *Profile;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    NSMutableArray *arryRootId,*arryRootName;
    NSMutableArray *arryname,*arrycontact,*arryparent_name;
    NSInteger rootname;
    NSString *Title,*Discription,*Date,*routename;
    CLLocationManager *locationManager;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation StudentListByRoute

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
    
    txtRoute.layer.borderWidth = 1;
    txtRoute.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    txtRoute.layer.cornerRadius=3;
    
    viewSelectRoute.layer.borderWidth = 1;
    viewSelectRoute.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];
    
    tblSee.layer.borderWidth = 1;
    tblSee.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    tblSee.layer.cornerRadius=3;
    
    tblListRoute.layer.borderWidth = 1;
    tblListRoute.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    tblListRoute.layer.cornerRadius=3;
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    Profile= [prefs stringForKey:@"level"];
    // Configure the new event with information from the location
//    droppedAt = [location coordinate];
    [self getRootName];
    [tblListRoute reloadData];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewSelectRoute setHidden:YES];
    [viewPopupProfile setHidden:YES];
}


- (IBAction)btnClickedMenu:(id)sender {
    [viewSelectRoute setHidden:YES];
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];

}

- (IBAction)btnClickedToggle:(id)sender {
    [viewSelectRoute setHidden:YES];
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

- (IBAction)btnClickedRoute:(id)sender {
  
    //[imgDrop setHidden:YES];
    //[btnObjDrop setHidden:YES];
    //[txtRoute setHidden:YES];
    //[tblListRoute setHidden:YES];
    
    [viewSelectRoute setHidden:NO];
    [tblListRoute reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tblListRoute)
    {
        return 1;
    }
    else if (tableView==tblSee)
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
    if (tableView==tblListRoute)
    {
        return arryname.count;
    }
    else if (tableView==tblSee)
    {
        return arryRootId.count;
    }
    else if (tableView==tblProfile)
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
    if (tableView==tblListRoute)
    {
        return 0;
    }
    else if (tableView==tblSee)
    {
        return 0;
    }
        else if (tableView==tblProfile)
        {
            return 0;
        }
    
    else
    {
        return 60;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView==tblListRoute)
    {
        return nil;
    }
    else if (tableView==tblSee)
    {
        return nil;
    }
    else if(tableView==tblProfile)
    {
        return nil;
    }
    
    else
    {
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==tblListRoute)
    {
        return 67;
    }
    else if (tableView==tblSee)
    {
        return 44;
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
    
    if (tableView==tblListRoute)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblname.text=[NSString stringWithFormat:@"%@",arryname[indexPath.row]];
        [ce.lblname setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        ce.lblname.textColor=[UIColor blackColor];
        
        ce.lblParentName.text=[NSString stringWithFormat:@"%@",arryparent_name[indexPath.row]];
        ce.lblParentName.textColor=[UIColor darkGrayColor];
        [ce.lblParentName setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
        
        ce.lblNo.text=[NSString stringWithFormat:@"%@",arrycontact[indexPath.row]];
        ce.lblNo.textColor=[UIColor darkGrayColor];
        [ce.lblNo setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
        return ce;
    }
    else if (tableView==tblSee)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arryRootName[indexPath.row]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row is %@", indexPath);
    
    if (tableView==tblListRoute)
    {
       
    }
    else if (tableView==tblSee)
    {
        rootname=[[arryRootId objectAtIndex:indexPath.row]integerValue];
        [self getRootDisplay];
        
        routename=[arryRootName objectAtIndex:indexPath.row];
        txtRoute.text=routename;
        [viewSelectRoute setHidden:YES];
        
        [txtRoute setHidden:NO];
        [imgDrop setHidden:NO];
        [btnObjDrop setHidden:NO];
        
        NSLog(@"%@",txtRoute.text);
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
         [prefs setValue:[NSString stringWithFormat:@"%ld",(long)rootname] forKey:@"setdriverrouteid"];
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
}
-(NSArray *)getRootName
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    arryRootId=[[NSMutableArray alloc]init];
    arryRootName=[[NSMutableArray alloc]init];
    
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@driverroutes.php?driver_id=%@",[[Singleton sharedSingleton] getBaseURL],id1];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arryRootId addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"root_id"]] ];
                [arryRootName addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"root_name"]] ];
                
            }
            if (arryRootId.count>1)
            {
                txtRoute.placeholder=@"Select Route";
            }
            else
            {
                txtRoute.text=[arryRootName objectAtIndex:0];
                rootname=[arryRootId[0]integerValue];
                  [self getRootDisplay];
            }
            
        }
        else
        {
          /*  TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];*/
            
        }
        [tblSee reloadData];
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
    return arryRootName;
}
-(void)getRootDisplay
{
    arryname=[[NSMutableArray alloc]init];
    arrycontact=[[NSMutableArray alloc]init];
    arryparent_name=[[NSMutableArray alloc]init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D droppedAt = [location coordinate];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@drivermap.php?driver_id=%@&latitude=%f&longitude=%f&route_id=%ld",[[Singleton sharedSingleton] getBaseURL],id1,droppedAt.latitude,droppedAt.longitude,(long)rootname];
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for(i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arryname addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                [arrycontact addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"contact"]]];
                [arryparent_name addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"parent_name"]]];
            }
            
        }
        else
        {
          /*  TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];*/

        }
        [tblListRoute reloadData];
        [SVProgressHUD dismiss];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Error Retrieving Data" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
    [alertView handleCancel:^
            {
                                               
                            }
                                    handleConfirm:^{
                                                        
                                            }];
                                    [alertView show];
                                          
                                          [SVProgressHUD dismiss];
        [tblListRoute reloadData];
    }];
    [operation1 start];
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
        
        [SVProgressHUD dismiss];
    }];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
