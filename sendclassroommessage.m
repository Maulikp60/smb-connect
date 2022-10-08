//
//  sendclassroommessage.m
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "sendclassroommessage.h"
#import "custom.h"
#import "SVProgressHUD.h"
#import "Singleton.h"
#include "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#include "TLAlertView.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "parentaboutus.h"
#import "parentcontactus.h"
#import "parentfeedback.h"
#import "parentprofile.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "ViewController.h"
#import "sendclassroommessage.h"
#import "ClassAssignment.h"
#import "Markattendance.h"
#import "Sendstudentmessage.h"
#import "MessageScreen.h"
#import "teacherdashboardmsg.h"
#import "getattendence.h"
#import "CDRViewController.h"
#import "homeworkstatus.h"
#import "driverchangepassword.h"
@interface sendclassroommessage ()<CDRTranslucentSideBarDelegate>
{
    BOOL test,chk;
    NSMutableArray *arrStudent,*arrStuid,*arrleave;
    NSString *Profile;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    UIButton *btnclk;
    NSMutableArray *arrclass,*arrimg,*arrClick,*arr,*arrclassid,*arrclassname;
    
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation sendclassroommessage

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
    
    
    tblSendMessage.layer.borderWidth = 1;
    tblSendMessage.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tvSendMessage.layer.borderWidth=1;
    tvSendMessage.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
   // tvSendMessage.textColor=[UIColor lightGrayColor];
    //tvSendMessage.font=[UIFont fontWithName:@"RawengulkBold" size:22];
    tvSendMessage.text = @"Enter Message";

    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    chk=YES;
    test=YES;
    [self getClass];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewPopupProfile setHidden:YES];
}


- (IBAction)btnClickedSend:(id)sender {
    
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    NSMutableArray * arr1 = [[NSMutableArray alloc] init];
    
    if (chk==YES)
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Enter Message" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvSendMessage becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([tvSendMessage.text isEqual:@"Enter Message"])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Enter Message" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvSendMessage becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([tvSendMessage.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Enter Message" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvSendMessage becomeFirstResponder];
             
         }
                  handleConfirm:^{
                  }];
        [alertView show];
    }
    else if ([arrimg containsObject:@"1"])
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSError *error;
        for (int k = 0; k<arrclassid.count; k++)
        {
            
            if ([arrimg[k] isEqualToString:@"1"])
            {
                
                
                NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                arrclassid[k], @"class_id",
                                                nil];
                
                [arr1 addObject:jsonDictionary];
            }
        }
        NSDictionary *jsonDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys: arr1, @"Post", nil];
        
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:jsonDictionary2 options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSString *appurl =[NSString stringWithFormat:@"%@classsendpush.php?",[[Singleton sharedSingleton] getBaseURL]];
        ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:appurl]];
        [requestsASI addPostValue:branch_id forKey:@"branch_id"];
        [requestsASI addPostValue:id1 forKey:@"teacher_id"];
        [requestsASI addPostValue:jsonString forKey:@"class_id"];
        [requestsASI addPostValue:tvSendMessage.text forKey:@"message"];
        
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
            arrimg=[[NSMutableArray alloc]init];
            for (int j=0; j<arrclassid.count; j++)
            {
                [arrimg addObject:@"0"];
            }
            [tblSendMessage reloadData];
            
            [tvSendMessage setText:@"Enter Message"];
            
            test=YES;
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
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"Select Class Room" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvSendMessage becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
    }
    [SVProgressHUD dismiss];
}

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
    
    [KxMenu showMenuInView:view3 fromRect:btnObjToggle.frame menuItems:menuItems];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [tvSendMessage resignFirstResponder];
        //[scrLeave setTransform:CGAffineTransformMakeTranslation(0,0)];
        return NO;
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:0.1];
    //    [scrLeave setTransform:CGAffineTransformMakeTranslation(0,-80)];
    if (test==YES)
    {
        tvSendMessage.text = @"";
        test=NO;
    }
    else if([tvSendMessage.text isEqualToString:@"Enter Message"])
    {
        tvSendMessage.text=@"";
    }
    //    [FromDate setHidden:YES];
    //    [ToDate setHidden:YES];
    
    tvSendMessage.textColor = [UIColor darkGrayColor];
    chk=NO;
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(tvSendMessage.text.length == 0)
    {
        tvSendMessage.textColor = [UIColor lightGrayColor];
        tvSendMessage.text =@"Enter Message";
        [tvSendMessage resignFirstResponder];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tblSendMessage)
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
    if (tableView==tblSendMessage)
    {
        return arrclassid.count;
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
    if (tableView==tblSendMessage)
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
    if (tableView==tblSendMessage)
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
    if (tableView==tblSendMessage)
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
    if (tableView==tblSendMessage)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        //CustomcarCell *cell = (CustomcarCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.btnObjCheck.tag = indexPath.row;
        ce.tag=[[arrimg objectAtIndex:indexPath.row] integerValue];
        if (ce.tag==0)
        {
            [ce.btnObjCheck setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        else
        {
            [ce.btnObjCheck setImage:[UIImage imageNamed:@"cheack.png"] forState:UIControlStateNormal];
        }
        [ce.btnObjCheck addTarget:self action:@selector(btnCheckUncheck:)forControlEvents:UIControlEventTouchUpInside];
        ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arrclassname[indexPath.row]];
        //        ce.lblStudentStd.text=[NSString stringWithFormat:@"%@",arrClass[indexPath.row]];
        //        ce.lblSchoolName.text=[NSString stringWithFormat:@"%@",arrBranch[indexPath.row]];
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
    NSLog(@"Selected row is %@", indexPath);
    if(tableView==tblSendMessage)
    {
        if ([[arrimg objectAtIndex:indexPath.row] isEqual:@"0"])
        {
            [arrimg replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        else //if([[arrimg objectAtIndex:tags] isEqual:@"1"])
        {
            [arrimg replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }
        [tblSendMessage reloadData];
        
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

    else{
        
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
        
        // 4
        //        [ILAlertView showWithTitle:@"Error Retrieving Data"
        //                           message:[error localizedDescription]
        //                  closeButtonTitle:@"OK"
        //                 secondButtonTitle:nil
        //                tappedSecondButton:nil];
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

-(IBAction)btnCheckUncheck:(id)sender
{
    [tvSendMessage resignFirstResponder];
    
    NSInteger tags = ((UIButton *)sender).tag;
    if ([[arrimg objectAtIndex:tags] isEqual:@"0"])
    {
        [arrimg replaceObjectAtIndex:tags withObject:@"1"];
    }
    else //if([[arrimg objectAtIndex:tags] isEqual:@"1"])
    {
        [arrimg replaceObjectAtIndex:tags withObject:@"0"];
    }
    [tblSendMessage reloadData];
}
-(void)getClass
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@classdisplay.php?branch_id=%@&teacher_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"branch_id"],id1];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arrclassname=[[NSMutableArray alloc]init];
        arrclassid=[[NSMutableArray alloc]init];
        arrimg=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for (int i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++)
            {
                [arrclassname addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]] ];
                [arrclassid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]] ];
            }
            
            for (int j=0; j<arrclassid.count; j++)
            {
                [arrimg addObject:@"0"];
            }
            [tblSendMessage reloadData];
        }
        else
        {
            arrclass=Nil;
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"Error Retrieving Data" message:[error localizedDescription] confirmButtonTitle:NULL cancelButtonTitle:@"Ok"];
        
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

@end
