//
//  DriverMessageScreen.m
//  SmbConnect
//
//  Created by apple on 10/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "DriverMessageScreen.h"
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
#import "driverchangepassword.h"
#import "TeacherDashboard.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "UIView+Toast.h"

@interface DriverMessageScreen ()<CDRTranslucentSideBarDelegate>{
    UIButton *btnclk;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *Profile;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    NSMutableArray *arryList,*arryList1,*arrgmsg,*arrgmsgid,*arrgmsgdate,*arrgdescription,*arrgSchoolName,*arrflag;
    
    NSMutableArray *arrsearchgmsg,*arrsearchgmsgdate,*arrsearcgmsgid,*arrsearcgdescription,*arrsearcgdate,*arrsearchflag;
     NSString *Title,*Discription,*Date;
}

@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation DriverMessageScreen

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
    
    
    txtSearch.layer.borderWidth = 1;
    txtSearch.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    txtSearch.layer.cornerRadius=3;
    
    [txtSearch addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

    viewReadMore.layer.borderWidth = 1;
    viewReadMore.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    viewwebview.layer.borderWidth = 1;
    viewwebview.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
//    tblProfile.layer.borderWidth = 1;
//    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    prefs = [NSUserDefaults standardUserDefaults];
    txtSearch.text=@"";
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    Profile= [prefs stringForKey:@"level"];
    viewwebview.hidden=YES;
    [self getDriverMessage];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewPopupProfile setHidden:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClickedMenu:(id)sender {
    [viewReadMore setHidden:YES];
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];

}
-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
    
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
- (IBAction)btnClickedClose:(id)sender {
     [viewReadMore setHidden:YES];
}

- (IBAction)btnclknextview:(id)sender {
    [web1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[prefs stringForKey:@"upload_docs"]]]];
    viewwebview.hidden=NO;
}

- (IBAction)btnwebviewclose:(id)sender {
     [viewwebview setHidden:YES];
}

- (IBAction)btnclkdownload:(id)sender {
    [self saveFile];
}
- (void)saveFile {
    
    NSString *stringURL = [prefs stringForKey:@"upload_docs"];
    NSString *attachmenttitle = [prefs stringForKey:@"attachmenttitle"];
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,attachmenttitle];
        [urlData writeToFile:filePath atomically:YES];
    }
    [self.view makeToast:@"Your File Is Download"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tblDriverMessage)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==tblDriverMessage)
    {
        return arrsearchgmsg.count;
    }
    else if (tableView==tblProfile)
    {
        return arryProfile.count;
    }
    else
    {
        if ([Profile isEqual:@"driver"])
        {
            return 4;
        }
        else
        {
            return 2;
        }
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView==tblDriverMessage)
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView==tblDriverMessage)
    {
        return nil;
    }
    else  if(tableView==tblProfile)
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
return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==tblDriverMessage)
    {
        return 121;
    }
    else
    {
        return 44;
       
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==tblDriverMessage)
    {
        
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        //CustomcarCell *cell = (CustomcarCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.btnReadMore.tag=indexPath.row;
        
        [ce.btnReadMore addTarget:self
                           action:@selector(btnClickedReadMore:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        ce.lblTitle.text=[NSString stringWithFormat:@"%@",arrsearchgmsg[indexPath.row]];
        Title=[NSString stringWithFormat:@"%@",arrsearchgmsg[indexPath.row]];
            //        [ce.lbla setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
            //        ce.lbla.textColor=[UIColor blackColor];
        
        
        NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[indexPath.row]];
        NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
        NSString *date1 = components1[0];
        NSString *time1 = components1[1];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy HH:mm:ss"];
        
        NSDate *date = [dateFormatter dateFromString:myDateString];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
        
        NSInteger weekday = [components weekday];
        NSString *weekdayName = [dateFormatter weekdaySymbols][weekday - 1];
        
        NSLog(@"%@ is a %@", myDateString, weekdayName);
        
        
        ce.lblDescription.text=[NSString stringWithFormat:@"%@",arrsearcgdescription[indexPath.row]];
        Discription=[NSString stringWithFormat:@"%@",arrsearcgdescription[indexPath.row]];
        
       // ce.lblTime.text=[NSString stringWithFormat:@"%@",time1];
          ce.lblTime.text=[NSString stringWithFormat:@"%@:%@",[time1 componentsSeparatedByString:@":"][0],[time1 componentsSeparatedByString:@":"][1]];
        ce.lblDate.text=[NSString stringWithFormat:@"%@ %@",weekdayName,date1];
        
        Date=[NSString stringWithFormat:@"%@",arrsearchgmsgdate[indexPath.row]];
        if ([[arrsearchflag objectAtIndex:indexPath.row] isEqual:@"0"])
        {
            ce.lblDate.hidden=YES;
            ce.img.hidden=NO;
        }
        else
        {
            ce.lblDate.hidden=NO;
            ce.img.hidden=YES;
          
        }
            //        ce.lblb.textColor=[UIColor darkGrayColor];
            //        [ce.lblb setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
            
            // [lblTotal setText:[NSString stringWithFormat:@"%@",tableView.]]
        return ce;
    }

    else  if (tableView==tblProfile)
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
    if (tableView==tblDriverMessage)
    {
        
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
-(void)getDriverMessage
{
    arrgmsg=[[NSMutableArray alloc]init];
    arrgmsgdate=[[NSMutableArray alloc]init];
    arrgmsgid=[[NSMutableArray alloc]init];
    arrgdescription=[[NSMutableArray alloc]init];
    arrgSchoolName=[[NSMutableArray alloc]init];
    arrflag=[[NSMutableArray alloc]init];
    arrsearchflag=[[NSMutableArray alloc]init];
    arrsearchgmsg=[[NSMutableArray alloc]init];
    arrsearchgmsgdate=[[NSMutableArray alloc]init];
    arrsearcgmsgid=[[NSMutableArray alloc]init];
    arrsearcgdescription=[[NSMutableArray alloc]init];
    arrsearcgdate=[[NSMutableArray alloc]init];
    
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaults stringForKey:@"level"];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@school_general_message_title.php?user_id=%@&type=%@",[[Singleton sharedSingleton] getBaseURL],id1,myString];
    
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
                [arrgmsg addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"messege"]]];
                
                [arrgmsgid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes_id"]]];
                
                [arrgmsgdate addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes_date"]]];
                
                [arrgdescription addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"description"]]];
                
                [arrgSchoolName addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"school_name"]]];
            }
            [arrflag addObject:@"1"];
            [arrsearchgmsg addObjectsFromArray:arrgmsg];
            [arrsearchgmsgdate addObjectsFromArray:arrgmsgdate];
            [arrsearcgmsgid addObjectsFromArray:arrgmsgid];
            [arrsearcgdescription addObjectsFromArray:arrgdescription];
            [arrsearcgdate addObjectsFromArray:arrgSchoolName];
            for (i=0; i<arrsearchgmsgdate.count-1; i++)
            {
                NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[i]];
                NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                NSString *date1 = components1[0];
                
                NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[i+1]];
                NSArray *components11 = [myDateString1 componentsSeparatedByString:@" "];
                NSString *date11 = components11[0];
                
                if([date1 isEqualToString:date11])
                {
                    [arrflag addObject:@"0"];
                }
                else
                {
                    [arrflag addObject:@"1"];
                }
                
                
            }
            [arrsearchflag addObjectsFromArray:arrflag];
           
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
            

        }
         [tblDriverMessage reloadData];
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
        
      
    }];
    [operation1 start];
}
- (IBAction)btnClickedReadMore:(id)sender {
   // [btnObjTrasparent setHidden:NO];
    
    
    NSInteger tags = ((UIButton *)sender).tag;
    [viewReadMore setHidden:NO];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[viewReadMore layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    
    tvTitle.text=[arrsearchgmsg objectAtIndex:tags];
    tvDescription.text=[arrsearcgdescription objectAtIndex:tags];
    NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[tags]];
    NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
    lblDate.text=[NSString stringWithFormat:@"%@ %@",components1[0],components1[1]];
    
    NSString *otherStr =[NSString stringWithFormat:@"%@school_general_message_popup.php?mes_id=%@",[[Singleton sharedSingleton] getBaseURL],[arrsearcgmsgid objectAtIndex:tags]];
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:otherStr]];
    
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    
    NSDictionary *json  = [parser parse:nil ignoreNulls:NO];
    
    
    NSString *webStatus = [json objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"])
    {
        NSMutableArray *dataArr = [json objectForKey:@"Post"];
        
        for (i = 0; i< dataArr.count; i++)
        {
            NSDictionary *dic=[dataArr objectAtIndex:i];
            
            NSString *attechment=[dic objectForKey:@"attachmenttitle"];
            NSString *upload_docs = [dic objectForKey:@"upload_docs"];
            if([upload_docs isEqual:@""]){
                [btnname setTitle:@"" forState:UIControlStateNormal];
                btnname.titleLabel. numberOfLines = 2;
            }
            else{
                btnname.hidden=NO;
                [btnname setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
                btnname.titleLabel. numberOfLines = 2;
            }
            NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
            [prefs1 setObject:upload_docs forKey:@"upload_docs"];
            [prefs1 setObject:attechment forKey:@"attachmenttitle"];
        }
    }
    else
    {
        
    }

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
- (IBAction)textFieldDidChange:(id)sender
{
    arrsearchgmsg=[[NSMutableArray alloc]init];
    arrsearchgmsgdate=[[NSMutableArray alloc]init];
    arrsearcgmsgid=[[NSMutableArray alloc]init];
    arrsearcgdescription=[[NSMutableArray alloc]init];
    arrsearcgdate=[[NSMutableArray alloc]init];
    NSString *searchText=txtSearch.text;
    
    if ([txtSearch.text isEqual:@""])
    {
        txtSearch.placeholder=@"Search";
        [arrsearchgmsg addObjectsFromArray:arrgmsg];
        [arrsearchgmsgdate addObjectsFromArray:arrgmsgdate];
        [arrsearcgmsgid addObjectsFromArray:arrgmsgid];
        [arrsearcgdescription addObjectsFromArray:arrgdescription];
        [arrsearcgdate addObjectsFromArray:arrgSchoolName];
        [arrsearchflag addObjectsFromArray:arrflag];
    }
    else
    {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
        arrsearchgmsg = [[arrgmsg filteredArrayUsingPredicate:resultPredicate]mutableCopy];
        for (int i123=0; i123<arrgmsg.count; i123++)
        {
            if ([arrsearchgmsg containsObject:[arrgmsg objectAtIndex:i123]])
            {
                [arrsearchgmsgdate addObject:[arrgmsgdate objectAtIndex:i123]];
                [arrsearcgmsgid addObject:[arrgmsgid objectAtIndex:i123]];
                [arrsearcgdescription addObject:[arrgdescription objectAtIndex:i123]];
                [arrsearcgdate addObject:[arrgSchoolName objectAtIndex:i123]];
            }
            else
            {
                
            }
        }
        if (arrsearchgmsg.count>0)
        {
            [arrsearchflag addObject:@"1"];
            for (i=0; i<arrsearchgmsgdate.count-1; i++)
            {
                NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[i]];
                NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                NSString *date1 = components1[0];
                NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[i+1]];
                NSArray *components11 = [myDateString1 componentsSeparatedByString:@" "];
                NSString *date11 = components11[0];
                if([date1 isEqualToString:date11])
                {
                    [arrsearchflag addObject:@"0"];
                }
                else
                {
                    [arrsearchflag addObject:@"1"];
                }
            }
        }
        else
        {
        }
    }
    [tblDriverMessage reloadData];
}

@end
