//
//  driverchangepassword.m
//  SmbConnect
//
//  Created by apple on 28/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "driverchangepassword.h"
#import "SVProgressHUD.h"
#import "Singleton.h"
#import "AFNetworking.h"
#import "parentcontactus.h"
#import "parentaboutus.h"
#import "parentfeedback.h"
#import "parentprofile.h"
#import "StudentListByRoute.h"
#import "BusRouteScreen.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "CDRTranslucentSideBar.h"
#import "custom.h"
#import "CDRViewController.h"
#import "ViewController.h"
#import "sendclassroommessage.h"
#import "Sendstudentmessage.h"
#import "ClassAssignment.h"
#import "getattendence.h"
#import "homeworkstatus.h"
#import "FeesScreen.h"
#import "StudentListScreen.h"
#import "Result.h"
#import "parentevent.h"
#import "parenthomework.h"
#import "parentattendencesheet.h"
#import "parentImagegallery.h"
#import "parentlocatebus.h"
#import "parentvideocallery.h"
@interface driverchangepassword ()<CDRTranslucentSideBarDelegate>
{
    NSUserDefaults *prefs;
    UIButton *btnclk;
    NSString *Profile;
    NSString *id1;
    NSString *level,*setid;
    
    UITableView *tableView1;
    NSString*stdname,*stdid,*root_id;
    NSMutableArray *arryProfile,*arrStudent,*arrStudid,*arrrootid;

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end
@implementation driverchangepassword

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
    
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    
    txtConfirmPass.layer.borderWidth = 1;
    txtConfirmPass.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtNewPass.layer.borderWidth = 1;
    txtNewPass.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtOldPass.layer.borderWidth = 1;
    txtOldPass.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
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
- (IBAction)btnClickedMenu:(id)sender {
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    Profile = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    stdid=[prefs stringForKey:@"stdid"];
    stdname=[prefs stringForKey:@"stdname"];
    arrStudid=[prefs objectForKey:@"arrStudid"];
    arrStudent=[prefs objectForKey:@"arrStudent"];
    arrrootid=[prefs objectForKey:@"arrrootid"];
    root_id=[prefs objectForKey:@"root_id"];
    
    
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
        if ([Profile isEqual:@"driver"])
        {
            return 4;
        }
        else if ([Profile isEqual:@"parent"])
        {
            return 11;
        }
        else if  ([Profile isEqual:@"teacher"])
        {
            return 7;
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
    
    if (tableView==tblProfile)
    {
        return 0;
    }
    else
    {
        if ([Profile isEqual:@"parent"])
        {
            return 80;
        }
        else
        {
           return 60;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(tableView==tblProfile)
    {
        return nil;
    }
    
    
    else
    {
        if ([Profile isEqual:@"parent"])
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
        
   
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arryProfile[indexPath.row]];
        return ce;
    }
    else
    {
        
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
        else if ([Profile isEqual:@"parent"])
        {
            
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
        else if  ([Profile isEqual:@"teacher"])
        {
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
        else if ([Profile isEqual:@"parent"])
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
        else if ([Profile isEqual:@"teacher"])
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
        
       NSMutableDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
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
        
        NSMutableDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtOldPass)
    {
        [txtNewPass becomeFirstResponder];
    }
    else if (textField==txtNewPass)
    {
        [txtConfirmPass becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}
- (IBAction)btnClickedToggle:(id)sender {
    
    if ([Profile isEqual:@"teacher"])
    {
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
        
        [KxMenu showMenuInView:view3 fromRect:btnObjToggle.frame menuItems:menuItems];
    }
    else if ([Profile isEqual:@"parent"])
    {
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
        [KxMenu showMenuInView:view3 fromRect:btnObjToggle.frame menuItems:menuItems];
    }
    else
    {
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
    
}
- (IBAction)headerTapped:(id)sender
{
    if (arrStudent.count>0)
    {
        [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"SMBConnect" message:@"Student not avaliable" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    stdname=[arrStudent objectAtIndex:anIndex];
    stdid=[arrStudid objectAtIndex:anIndex];
    root_id=[arrrootid objectAtIndex:anIndex];
    [prefs setObject:stdid forKey:@"stdid"];
    [prefs setObject:stdname forKey:@"stdname"];
    [prefs setObject:root_id forKey:@"root_id"];
    [prefs synchronize];
    [tableView1 reloadData];
    
}
-(IBAction)btnFeedback:(id)sender{
    parentfeedback *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentfeedback"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
}
-(IBAction)btnProfileDetail:(id)sender{
    parentprofile *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentprofile"];
    [self presentViewController:parentprofile animated:YES completion:nil];
}
- (IBAction)btnAbvoutUs:(id)sender{
    parentaboutus *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentaboutus"];
    [self presentViewController:parentprofile animated:YES completion:nil];
}
-(IBAction)btnChangeUser:(id)sender{
    
    [self getChangeUser];
}
-(IBAction)btnContacUs:(id)sender{
    parentcontactus *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"parentcontactus"];
    [self presentViewController:parentprofile animated:YES completion:nil];
    
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
- (IBAction)btnClickedSUBMIT:(id)sender {
    if([txtOldPass.text isEqualToString:@""] && [txtNewPass.text isEqualToString:@""] && [txtConfirmPass.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Fillup All Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if ([txtOldPass.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Enter Old Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        

    }
    else if ([txtNewPass.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Enter New Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else if ([txtConfirmPass.text isEqualToString:@""])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Enter Confirm Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
   /* else if(txtNewPassword.text.length<8 || txtNewPassword.text.length>16)
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"Password Must Be Between 8 To 16 Characters" confirmButtonTitle:NULL cancelButtonTitle:@"Ok"];
        
        [alertView handleCancel:^
         {
             [txtNewPassword becomeFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    */
    else if (![txtNewPass.text isEqualToString:txtConfirmPass.text])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Password Not Matched" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@changpass.php?user_id=%@&password=%@&newpassword=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"],txtOldPass.text,txtNewPass.text];
        NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",str1);
        NSURL *url1 = [NSURL URLWithString:str1];
        NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
        
        AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
        operation1.responseSerializer = [AFJSONResponseSerializer serializer];
        operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
         NSMutableDictionary  *dictionary1 = (NSMutableDictionary *)responseObject;
            NSLog(@"%@",dictionary1);
            
            if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Password Change Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
                [prefs setValue:txtConfirmPass.text forKey:@"password"];
                [prefs synchronize];
                [txtOldPass setText:@""];
                [txtNewPass setText:@""];
                [txtConfirmPass setText:@""];
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
}
@end
