//
//  TeacherDashboard.m
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "TeacherDashboard.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "ClassAssignment.h"
#import "getattendence.h"
#import "sendclassroommessage.h"
#import "Sendstudentmessage.h"
#import "Teachercontactus.h"
#import "Driverdashboard.h"
#import "custom.h"
#import "SVProgressHUD.h"
#import "Singleton.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "AFNetworking.h"
#import "parentaboutus.h"
#import "parentcontactus.h"
#import "parentfeedback.h"
#import "parentprofile.h"
#import "CDRViewController.h"
#import "teacherdashboardmsg.h"
#import "ViewController.h"
#import "homeworkstatus.h"
#import "driverchangepassword.h"

@interface TeacherDashboard ()<CDRTranslucentSideBarDelegate>
{
    UIButton *btnclk;
    NSString *Profile;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    UITableView *tableView1;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation TeacherDashboard

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

    btnObjStudentMesage.layer.borderWidth = 2;
    btnObjStudentMesage.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    btnObjClassMessage.layer.borderWidth = 2;
    btnObjClassMessage.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    btnObjClassAssign.layer.borderWidth = 2;
    btnObjClassAssign.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    btnObjAttendance.layer.borderWidth = 2;
    btnObjAttendance.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
//    btnObjEvents.layer.borderWidth = 2;
//    btnObjEvents.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    [self validateuser];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewPopupProfile setHidden:YES];
}
-(void)validateuser
{
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@validuser.php?user_id=%@&deviceid=%@&level=%@",[[Singleton sharedSingleton] getBaseURL],id1,setid,level];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    if ([[json valueForKey:@"status"] isEqualToString:@"YES"] )
    {
        [self countingdata];
    }
    
    else
    {
        
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[json objectForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [prefs removePersistentDomainForName:appDomain];
        [prefs synchronize];
        ViewController *ViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self presentViewController:ViewController animated:YES completion:nil];
        
    }
}
-(void)countingdata
{
//http://admin.smbconnect.co.in/api/dashboardothers.php?

    NSString *myRequestString1 = [NSString stringWithFormat:@"%@dashboardothers.php?user_id=%@&type=teacher",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"]];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary  *dictionary2 = (NSMutableDictionary *)responseObject;
        
        if ([[dictionary2 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            NSMutableArray *arr=[dictionary2 valueForKey:@"Post"];
            //get=[[arr objectAtIndex:0]objectForKey:@"Calender"];
            if ([[[arr objectAtIndex:0]objectForKey:@"General"] integerValue]==0)
            {
                lblCount.hidden=YES;
            }
            else
            {
                lblCount.hidden=NO;
                lblCount.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:0]objectForKey:@"General"]];
            }
            
    
            
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClickedMenu:(id)sender {
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];

}

- (IBAction)btnClassRoomMessage:(id)sender {
}

- (IBAction)btnStudentMessage:(id)sender {
    
}
-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView==tblProfile)
    {
        return 1;
    }
    else{
        return 1;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView==tblProfile)
    {
        return arryProfile.count;
    }

    else
    {
        return 7;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (tableView==tblProfile)
    {
        return 44;
    }
    else
    {
        return 44;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==tblProfile)
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
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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
        if (indexPath.row == 0) {
            cell.textLabel.text = @"        Dashboard";
            
            img.image=[UIImage imageNamed:@"deshboard60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"        Class Messages";
            img.image=[UIImage imageNamed:@"classmessage60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 3) {
            cell.textLabel.text = @"        Student Messages";
            img.image=[UIImage imageNamed:@"studentmessage60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 4) {
            cell.textLabel.text = @"        Class Assignment";
            img.image=[UIImage imageNamed:@"classasign60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"        Attendance";
            img.image=[UIImage imageNamed:@"stendance60.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 5) {
            cell.textLabel.text = @"        Home Work";
            img.image=[UIImage imageNamed:@"hw-status.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 6) {
            cell.textLabel.text = @"        Change Password";
            img.image=[UIImage imageNamed:@"change-icon.png"];
            [cell addSubview:img];
        }
        else
        {
            
        }
        return cell;

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
            TeacherDashboard *TeacherDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"TeacherDashboard"];
            [self presentViewController:TeacherDashboard animated:YES completion:nil];
            
        }
        else if (indexPath.row==1)
        {
            getattendence *Markattendance=[self.storyboard instantiateViewControllerWithIdentifier:@"getattendence"];
            [self presentViewController:Markattendance animated:YES completion:nil];
            
        }
        else if (indexPath.row==2)
        {
            sendclassroommessage *sendclassroommessage=[self.storyboard instantiateViewControllerWithIdentifier:@"sendclassroommessage"];
            [self presentViewController:sendclassroommessage animated:YES completion:nil];
            
        }
        else if (indexPath.row==3)
        {
            Sendstudentmessage *Sendstudentmessage=[self.storyboard instantiateViewControllerWithIdentifier:@"Sendstudentmessage"];
            [self presentViewController:Sendstudentmessage animated:YES completion:nil];
            
        }
        else if (indexPath.row==4)
        {
            ClassAssignment *ClassAssignment=[self.storyboard instantiateViewControllerWithIdentifier:@"ClassAssignment"];
            [self presentViewController:ClassAssignment animated:YES completion:nil];
        }
        else if (indexPath.row==5)
        {
            homeworkstatus *homeworkstatus=[self.storyboard instantiateViewControllerWithIdentifier:@"homeworkstatus"];
            [self presentViewController:homeworkstatus animated:YES completion:nil];
            
        }
        else if (indexPath.row==6)
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
            for (int i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++)
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

- (IBAction)btnClassAssignment:(id)sender {
}

- (IBAction)btnMarkAttendance:(id)sender {
    
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
//      [KxMenuItem menuItem:@"    Feedback"
//                     image:nil
//                    target:self
//                    action:@selector(btnFeedback:)],
      
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

- (IBAction)btnClickedGeneral:(id)sender {
    teacherdashboardmsg *Markattendance=[self.storyboard instantiateViewControllerWithIdentifier:@"teacherdashboardmsg"];
    [self presentViewController:Markattendance animated:YES completion:nil];
    
}

- (IBAction)btnteachermsg:(id)sender {
    
    homeworkstatus *homeworkstatus=[self.storyboard instantiateViewControllerWithIdentifier:@"homeworkstatus"];
    [self presentViewController:homeworkstatus animated:YES completion:nil];
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
@end
