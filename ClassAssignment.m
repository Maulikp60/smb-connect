//
//  ClassAssignment.m
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "ClassAssignment.h"
#import "custom.h"
#import "SVProgressHUD.h"
#import "Singleton.h"
#include "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#include "TLAlertView.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "TeacherDashboard.h"
#import "sendclassroommessage.h"
#import "Sendstudentmessage.h"
#import "Teachercontactus.h"
#import "Driverdashboard.h"
#import "MessageScreen.h"
#import "teacherdashboardmsg.h"
#import "parentprofile.h"
#import "parentcontactus.h"
#import "parentaboutus.h"
#import "ViewController.h"
#import "CDRViewController.h"
#import "getattendence.h"
#import "homeworkstatus.h"
#import "driverchangepassword.h"
@interface ClassAssignment ()<CDRTranslucentSideBarDelegate>
{
    UIButton *btnclk;
    NSString *Profile;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    NSMutableArray *arr,*arrimg;

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation ClassAssignment

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
   

    
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblobj.layer.borderWidth = 1;
    tblobj.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
     [self getClass];
}
-(void)getClass
{
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    arrimg=[[NSMutableArray alloc]init];
    arr=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@showteachersetting.php?branch_id=%@&teacher_id=%@",[[Singleton sharedSingleton] getBaseURL],branch_id,id1];
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
        
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for(int i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arr addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]]];
                [arrimg addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"value"]]];
            }
            NSLog(@"%@",arrimg);
            
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 valueForKey:@"Post"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
        }
        [SVProgressHUD dismiss];
        [tblobj reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClickedMenu:(id)sender {
    [viewPopupProfile setHidden:YES];
    [self.sideBar show];
    view1.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];
}
-(IBAction)aMethod:(id)sender
{
    view1.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
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

- (IBAction)btnClickedSubmit:(id)sender {
    NSMutableArray *sel=[[NSMutableArray alloc]init];
    
    for (int i=0; i<arrimg.count; i++) {
        if ([arrimg[i] isEqualToString:@"1"]) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:arr[i] forKey:@"class_id"];
            [sel addObject:dic];
            
        }
    }
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setObject:sel forKey:@"Post"];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSError *error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    NSLog(@"Selected  array%@",jsonString);
    
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@saveteachersetting.php?branch_id=%@&teacher_id=%@&class_id=%@",[[Singleton sharedSingleton] getBaseURL],branch_id,id1,jsonString];
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
        
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Settings Saved Successfully" confirmButtonTitle:NULL cancelButtonTitle:@"Ok"];
            
            [alertView handleCancel:^
             {
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 valueForKey:@"messege"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
            handleConfirm:^{
                          
                          
                      }];
            [alertView show];
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView==tblobj)
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
    if (tableView==tblobj)
    {
        return [[dictionary1 valueForKey:@"Post"]count];
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
    if (tableView==tblobj)
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
    if (tableView==tblobj)
    {
        return nil;
    }
    else if(tableView==tblProfile)
    {
        return nil;
    }

    else
    {
        /*
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
        return headerView;8*/
        
        
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
    if (tableView==tblobj)
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
    if (tableView==tblobj)
    {
        
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblname.text=[[[dictionary1 valueForKey:@"Post"]objectAtIndex:indexPath.row]valueForKey:@"name"];
       
        
      
        ce.tag=[[arrimg objectAtIndex:indexPath.row] integerValue];
        
        if (ce.tag==0)
        {
            
            [ce.img setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
        else
        {
            [ce.img setImage:[UIImage imageNamed:@"cheack.png"]];
        }
//        if (ce.tag==0)
//        {
//            [ce.btnObjCheck setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
//        }
//        else
//        {
//            [ce.btnObjCheck setImage:[UIImage imageNamed:@"cheack.png"] forState:UIControlStateNormal];
//        }

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
        else if (indexPath.row==6)
        {
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
   
    if (tableView==tblobj)
    {
        if ([[arrimg objectAtIndex:indexPath.row] isEqual:@"0"])
        {
            [arrimg replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        else //if([[arrimg objectAtIndex:tags] isEqual:@"1"])
        {
            [arrimg replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }    [tblobj reloadData];
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
        else if (indexPath.row==1)
        {
            getattendence *Markattendance=[self.storyboard instantiateViewControllerWithIdentifier:@"getattendence"];
            [self presentViewController:Markattendance animated:YES completion:nil];
            
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewPopupProfile setHidden:YES];
}
-(IBAction)btnProfileDetail:(id)sender{
    parentprofile *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentprofile"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
}
-(IBAction)btnContacUs:(id)sender{
    parentcontactus *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentcontactus"];
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
