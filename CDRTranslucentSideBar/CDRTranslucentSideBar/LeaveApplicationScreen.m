//
//  LeaveApplicationScreen.m
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "LeaveApplicationScreen.h"
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
#import "CDRViewController.h"
#import "FeesScreen.h"
#import "StudentListScreen.h"
#import "Result.h"
#import "parentvideocallery.h"
#import "parentImagegallery.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "parentlocatebus.h"
#import "parentevent.h"
#import "parenthomework.h"
#import "parentattendencesheet.h"
#import "driverchangepassword.h"
@interface LeaveApplicationScreen ()<CDRTranslucentSideBarDelegate>
{
    BOOL test,chk;
    NSMutableArray *arrimg,*arrStudent,*arrStuid,*arrleave,*arrrootid;
    NSString *Profile;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *level,*setid,*stdname,*stdid,*root_id;
    NSMutableArray *arryProfile;
    UIButton *btnclk;
    NSString *PastDate,*angel,*myangel;
    int b1,c1,d1,e1,dropdowentag;
    NSInteger school;
    UITableView *tableView1;
    
    

    
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end
@implementation LeaveApplicationScreen

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
    

    txtSelectLeaveTemplates.layer.borderWidth = 1;
    txtSelectLeaveTemplates.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtFromDate.layer.borderWidth = 1;
    txtFromDate.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtToDate.layer.borderWidth = 1;
    txtToDate.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblLeaveTemplate.layer.borderWidth = 1;
    tblLeaveTemplate.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tvReason.layer.borderWidth=1;
    tvReason.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    btnname.layer.cornerRadius=5;
    btnname.layer.masksToBounds=YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }

    [viewPopupProfile setHidden:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    tvReason.text = @"Leave Reason";
    
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    NSDate *today = [NSDate date];
    //today=[today dateByAddingTimeInterval:60*60*24];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtFromDate.text=dateString;
    txtToDate.text=dateString;
    PastDate=dateString;
    chk=YES;
    test=YES;
    stdid=[prefs stringForKey:@"stdid"];
    stdname=[prefs stringForKey:@"stdname"];
    arrStuid=[prefs objectForKey:@"arrStudid"];
    arrStudent=[prefs objectForKey:@"arrStudent"];
    arrrootid=[prefs objectForKey:@"arrrootid"];
    root_id=[prefs objectForKey:@"root_id"];
    arrimg=[[NSMutableArray alloc]init];
    for (i=0; i<arrStudent.count; i++)
    {
        [arrimg addObject:@"0"];
    }
    
    [self getleave];
    [tblLeaveTemplate reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClickedMenu:(id)sender {
    
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

- (IBAction)btnClickedSubmit:(id)sender {
     NSError *error;
     NSString *branch_id1 = [prefs stringForKey:@"branch_id"];
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    [SVProgressHUD showProgress:0 status:@"Loading"];

    if (chk==YES)
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Please Enter Leave Reason." confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvReason becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([tvReason.text isEqual:@"Leave Reason"])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Please Enter Leave Reason." confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvReason becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([tvReason.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Please Enter Leave Reason." confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvReason becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if ([arrimg containsObject:@"1"])
    {
        for (i=0; i<arrimg.count; i++)
        {
            if ([arrimg[i] isEqualToString:@"1"]) {
                
                NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                arrStuid[i], @"student_id",
                                                nil];
                
                [arr1 addObject:jsonDictionary];
            }
        }
        NSDictionary *jsonDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys: arr1, @"post", nil];
        
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:jsonDictionary2 options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        
        NSString *appurl =[NSString stringWithFormat:@"%@leave_request.php?",[[Singleton sharedSingleton] getBaseURL]];
        
        ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:appurl]];
        
        [requestsASI addPostValue:jsonString forKey:@"stud_id"];
        [requestsASI addPostValue:id1 forKey:@"parent_id"];
        [requestsASI addPostValue:branch_id1 forKey:@"branch_id"];
        [requestsASI addPostValue:tvReason.text forKey:@"message"];
        
        NSString *str1 = txtToDate.text; /// here this is your date with format yyyy-MM-dd
        NSString *str2=txtFromDate.text;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
        
        NSDate *date1 = [dateFormatter dateFromString:str1];
        NSDate *date2 = [dateFormatter dateFromString:str2];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        angel = [dateFormatter stringFromDate:date1];
        myangel = [dateFormatter stringFromDate:date2];
        
        [requestsASI addPostValue:myangel forKey:@"leave_start_date"];
        [requestsASI addPostValue:angel forKey:@"leave_end_date"];
        
        [requestsASI setDownloadProgressDelegate:self];
        [requestsASI setDelegate:self];
        [requestsASI startSynchronous];
        
        NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
        NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
        NSLog(@"result%@",result);
        if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Sent Successfully." confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
            [tvReason setText:@"Leave Reason"];
            test=YES;
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Sent Unsuccessful" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
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
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Child Name." confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    [SVProgressHUD dismiss];

}

- (IBAction)btnClickedDate:(id)sender {
    [self.view endEditing:YES];
    UIButton *b1=sender;
    if(b1.tag==0){
        IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
        
        [picker setTag:1];
        [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
        [picker show];
    }
    else{
        IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
        
        [picker setTag:2];
        [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
        [picker show];
    }

}

- (IBAction)btnClickedTemplates:(id)sender {
    
    dropdowentag=2;
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Templates" withOption:arrleave xy:CGPointMake(10, 120) size:CGSizeMake(self.view.frame.size.width-20, 400) isMultiple:YES];

}

- (IBAction)btnback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
    Dropobj.tag=i;
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    if (dropdowentag==2)
    {
        school=[arrleave[anIndex]integerValue];
        txtSelectLeaveTemplates.text=arrleave[anIndex];
        tvReason.text=arrleave[anIndex];
    }
    else
    {
        stdname=[arrStudent objectAtIndex:anIndex];
        stdid=[arrStuid objectAtIndex:anIndex];
        [prefs setObject:stdid forKey:@"stdid"];
        [prefs setObject:stdname forKey:@"stdname"];
        root_id=[arrrootid objectAtIndex:anIndex];
        [prefs setObject:root_id forKey:@"root_id"];
        [prefs synchronize];
        [tableView1 reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [tvReason resignFirstResponder];
        //[scrLeave setTransform:CGAffineTransformMakeTranslation(0,0)];
        return NO;
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    if([tvReason.text isEqualToString:@"Leave Reason"])
    {
        tvReason.text=@"";
    }
    
    chk=NO;
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(tvReason.text.length == 0)
    {
        tvReason.text =@"Leave Reason";
        [tvReason resignFirstResponder];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tblLeaveTemplate)
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
    if (tableView==tblLeaveTemplate)
    {
        return arrStuid.count;
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
    if (tableView==tblLeaveTemplate)
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
    if (tableView==tblLeaveTemplate)
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
- (IBAction)headerTapped:(id)sender
{
    dropdowentag=1;
    [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==tblLeaveTemplate)
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
    if (tableView==tblLeaveTemplate)
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
            ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arrStudent[indexPath.row]];

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
        {
            
        }
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row is %@", indexPath);
    
    if(tableView==tblLeaveTemplate)
    {
        if ([[arrimg objectAtIndex:indexPath.row] isEqual:@"0"])
        {
            [arrimg replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        else //if([[arrimg objectAtIndex:tags] isEqual:@"1"])
        {
            [arrimg replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }
        [tblLeaveTemplate reloadData];
//        Stuid=indexPath.row;
//        [btnobjTrasparent setHidden:NO];
//        [viewModify setHidden:NO];
//        [btnObjAddStudent setHidden:YES];
//        CATransition *applicationLoadViewIn =[CATransition animation];
//        [applicationLoadViewIn setDuration:0.5];
//        [applicationLoadViewIn setType:kCATransitionReveal];
//        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//        [[viewModify layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
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
    

    else{
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
-(IBAction)btnCheckUncheck:(id)sender
{
    [tvReason resignFirstResponder];
    
    NSInteger tags = ((UIButton *)sender).tag;
    if ([[arrimg objectAtIndex:tags] isEqual:@"0"])
    {
        [arrimg replaceObjectAtIndex:tags withObject:@"1"];
    }
    else //if([[arrimg objectAtIndex:tags] isEqual:@"1"])
    {
        [arrimg replaceObjectAtIndex:tags withObject:@"0"];
    }
    [tblLeaveTemplate reloadData];
}

-(void)getleave
{
    arrleave=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@leave_type.php",[[Singleton sharedSingleton] getBaseURL]];
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
            for(i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arrleave addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"title"]]];
            }
            NSLog(@"%@",arrleave);
            
        }
        else
        {
            
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
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles{
    
    NSString *str1 = [titles componentsJoinedByString:@" - "]; /// here this is your date with format yyyy-MM-dd
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"MMM dd,yyyy"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date1 = [dateFormatter dateFromString:str1];
    
    // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];// here set format which you want...
    
    NSString *a = [dateFormatter stringFromDate:date1];
    switch (pickerView.tag){
            
    
        case 1: txtFromDate.text=a;
            txtToDate.text=a;break;
            
            //  case 1: [txtFromDate setTitle:[titles componentsJoinedByString:@" - "] forState:UIControlStateNormal]; break;
        case 2: txtToDate.text=a;break;
        default:
            break;
    }
    [self a];
    [self b];
    if (d1 < e1){
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"From Date Can't be Less Than Current Date" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvReason becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];

        
        txtFromDate.text=PastDate;
        txtToDate.text=PastDate;
        
    }
    else if(b1>c1){
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"To Date Can't be less than From Date" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [tvReason becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
        txtToDate.text=txtFromDate.text;
    }
}

-(void)a{
    NSString *str1 = txtToDate.text; /// here this is your date with format yyyy-MM-dd
    NSString *str2=txtFromDate.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date1 = [dateFormatter dateFromString:str1];
    NSDate *date2 = [dateFormatter dateFromString:str2];
    // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];// here set format which you want...
    
    NSString *a = [dateFormatter stringFromDate:date1];
    NSString *b = [dateFormatter stringFromDate:date2];
    
    a=[a stringByReplacingOccurrencesOfString:@"-" withString:@""];
    b=[b stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    b1=[b intValue];
    c1=[a intValue];
}

-(void)b{
    NSString *str1 = txtFromDate.text; /// here this is your date with format yyyy-MM-dd
    NSString *str2=PastDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date1 = [dateFormatter dateFromString:str1];
    NSDate *date2 = [dateFormatter dateFromString:str2];
    // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];// here set format which you want...
    
    NSString *a = [dateFormatter stringFromDate:date1];
    NSString *b = [dateFormatter stringFromDate:date2];
    
    a=[a stringByReplacingOccurrencesOfString:@"-" withString:@""];
    b=[b stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    d1=[a intValue];
    e1=[b intValue];
}



@end
