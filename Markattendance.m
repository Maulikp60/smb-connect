//
//  Markattendance.m
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "Markattendance.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "AFNetworking.h"
#import "DropDownListView.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "Singleton.h"
#import "SVProgressHUD.h"
#import "sendclassroommessage.h"
#import "ClassAssignment.h"
#import "Sendstudentmessage.h"
#import "TeacherDashboard.h"
#import "CDRTranslucentSideBar.h"
#import "MessageScreen.h"
#import "parentprofile.h"
#import "parentaboutus.h"
#import "parentfeedback.h"
#import "parentcontactus.h"
#import "ViewController.h"
#import "teacherdashboardmsg.h"
#import "getattendence.h"
#import "CDRViewController.h"
#import "homeworkstatus.h"
#import "driverchangepassword.h"
@interface Markattendance ()<CDRTranslucentSideBarDelegate>{
    NSString *Profile;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    
    NSMutableArray *arrclassname;
    NSMutableArray *arrimg;
    NSMutableArray *arryclassid;
    
    NSMutableArray *arrstudname;
    NSMutableArray *arrstdid;
    NSString *topid;
    int i;
    BOOL dropdown;
    UIButton *btnclk;

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation Markattendance

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
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self.sideBar setContentViewInSideBar:tableView];
    
    tblAttendance.layer.borderWidth = 1;
    tblAttendance.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    txtSelectClass.layer.borderWidth = 1;
    txtSelectClass.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
       txtSelectClass.leftView = paddingView;
    txtSelectClass.leftViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    
    
    [self getClass];
}
-(void)getClass
{
    
    arrclassname=[[NSMutableArray alloc]init];
    arryclassid=[[NSMutableArray alloc]init];
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@classdisplay.php?branch_id=%@&teacher_id=%@",[[Singleton sharedSingleton] getBaseURL],branch_id,id1];
    
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:myRequestString1]];
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
    NSLog(@"result%@",result);
    if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
    {
        NSArray *arr1=[result objectForKey:@"Post"];
        
        for (i=0; i<arr1.count; i++)
        {
            NSDictionary *dic1=[arr1 objectAtIndex:i];
            [arryclassid addObject:[dic1 objectForKey:@"class_id"]];
            [arrclassname addObject:[dic1 objectForKey:@"name"]];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     [Dropobj fadeOut];
    //[viewPopupProfile setHidden:YES];
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
    
    [KxMenu showMenuInView:view3 fromRect: btnObjToggle.frame menuItems:menuItems];
}

- (IBAction)btnClickedSelectClass:(id)sender {
   // dropdown=NO;
    [Dropobj fadeOut];
    
    [self showPopUpWithTitle:@"Select Class" withOption:arrclassname xy:CGPointMake(10, 150) size:CGSizeMake(self.view.frame.size.width-20, 280) isMultiple:NO];
}

- (IBAction)btnClickedSubmit:(id)sender {
    
    if([txtSelectClass.text isEqualToString:@""])
    {
        
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Class" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if ([arrimg containsObject:@"2"])
    {
        NSError *error;
        
        NSMutableArray * arr1 = [[NSMutableArray alloc] init];
        
        for (int k = 0; k<arrimg.count; k++)
        {
            
            if ([arrimg[k] isEqualToString:@"1"])
            {
                
            }
            else
            {
                NSString *attendence;
                if ([arrimg[k] isEqualToString:@"2"])
                {
                    attendence=@"present";
                }
                else
                {
                    attendence=@"absent";
                }
                
                NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                arrstdid[k], @"stud_id",
                                                attendence, @"attendance",
                                                nil];
                
                [arr1 addObject:jsonDictionary];
                
            }
        }
        NSString *branch_id = [prefs stringForKey:@"branch_id"];
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSDictionary *jsonDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys: arr1, @"post", nil];
        
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:jsonDictionary2 options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        
        NSString *appurl =[NSString stringWithFormat:@"%@take_attendance.php?",[[Singleton sharedSingleton] getBaseURL]];
        
        ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:appurl]];
        [requestsASI addPostValue:topid forKey:@"class_id"];
        [requestsASI addPostValue:branch_id forKey:@"branch_id"];
        [requestsASI addPostValue:id1 forKey:@"teacher_id"];
        [requestsASI addPostValue:jsonString forKey:@"data"];
        
        [requestsASI setDownloadProgressDelegate:self];
        [requestsASI setDelegate:self];
        [requestsASI startSynchronous];
        
        NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
        
        NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
        NSLog(@"result%@",result);
        
        if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
        {

            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[result valueForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                      }];
            [alertView show];
            [txtSelectClass setText:@""];
            arrstdid=[[NSMutableArray alloc]init];
            arrstudname=[[NSMutableArray alloc]init];
            arrimg=[[NSMutableArray alloc]init];
            [tblAttendance reloadData];
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[result valueForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                      }];
            [alertView show];
            
            
        }
        [SVProgressHUD dismiss];
    }
    else
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Student" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                  }];
        [alertView show];
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select Student" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil  , nil];
        [alert show];
    }

}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:109.0 G:160.0 B:172.0 alpha:1.00];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    if (dropdown==NO)
    {
        txtSelectClass.text=[arrclassname objectAtIndex:anIndex];
        topid=[arryclassid objectAtIndex:anIndex];
        [self studentdata];
    }
    else
    {
        Profile=[arryProfile objectAtIndex:anIndex];
        if ([Profile isEqual:@"Non Academic"])
        {
            Profile=@"nonacademic";
        }
        else
        {
            Profile=[[[Profile substringToIndex:1] lowercaseString] stringByAppendingString:[Profile substringFromIndex:1]];
        }
        if ([Profile isEqual:level])
        {
            
        }
        else
        {
            [self getAnotherProfile];
            if ([Profile isEqual:@"parent"])
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
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView==tblAttendance)
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tblAttendance)
    {
        return [arrstdid count];
    }
    else if (tableView==tblProfile)
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
    if (tableView==tblAttendance)
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
    if (tableView==tblAttendance)
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
    if (tableView==tblAttendance)
    {
        return 40;
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
    if (tableView==tblAttendance)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *cell = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        cell.lblStudentName.text=[arrstudname objectAtIndex:indexPath.row];
        cell.tag=[[arrimg objectAtIndex:indexPath.row] integerValue];
        
        if (cell.tag==3)
        {
            cell.lblStudentName.textColor=[UIColor darkGrayColor];
            [cell.img setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
        
        else if (cell.tag==1)
        {
            cell.lblStudentName.textColor=[UIColor redColor];
            [cell.img setImage:[UIImage imageNamed:@"leave.png"]];
        }
        
        else
        {
            cell.lblStudentName.textColor=[UIColor darkGrayColor];
            [cell.img setImage:[UIImage imageNamed:@"cheack.png"]];
        }
        
        return cell;
        
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
      UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==tblAttendance)
    {
        NSInteger tags = indexPath.row;
        
        
        if ([[arrimg objectAtIndex:tags] isEqual:@"2"])
        {
            [arrimg replaceObjectAtIndex:tags withObject:@"3"];
        }
        else if([[arrimg objectAtIndex:tags] isEqual:@"3"])
        {
            [arrimg replaceObjectAtIndex:tags withObject:@"2"];
        }
        else
        {
            
        }
        
        [tblAttendance reloadData];
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

-(void)studentdata
{
    arrstdid=[[NSMutableArray alloc]init];
    arrstudname=[[NSMutableArray alloc]init];
    arrimg=[[NSMutableArray alloc]init];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@studentattendance.php?class_id=%@",[[Singleton sharedSingleton] getBaseURL],topid];
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:myRequestString1]];
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
    NSLog(@"result%@",result);
    if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
    {
        NSArray *arr1=[result objectForKey:@"Post"];
        
        for (i=0; i<arr1.count; i++)
        {
            NSDictionary *dic1=[arr1 objectAtIndex:i];
            if ([[dic1 objectForKey:@"attendance"] isEqual:@"leave"])
            {
                [arrimg addObject:@"1"];
            }
            else  if ([[dic1 objectForKey:@"attendance"] isEqual:@"present"])
            {
                [arrimg addObject:@"2"];
            }
            else  if ([[dic1 objectForKey:@"attendance"] isEqual:@"absent"])
            {
                [arrimg addObject:@"3"];
            }
            else
            {
                [arrimg addObject:@"3"];
            }
            [arrstdid addObject:[dic1 objectForKey:@"stud_id"]];
            [arrstudname addObject:[dic1 objectForKey:@"name"]];
        }
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
    [tblAttendance reloadData];
    
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
            
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL cancelButtonTitle:@"Ok"];
            
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
        arryProfile=[[NSMutableArray
                      alloc]init];
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


@end
