//
//  Result.m
//  CDRTranslucentSideBar
//
//  Created by apple on 24/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "Result.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "parentprofile.h"
#import "parentfeedback.h"
#import "parentcontactus.h"
#import "parentaboutus.h"
#import "SVProgressHUD.h"
#import "Singleton.h"
#include "AFNetworking.h"
#import "custom.h"
#import "CDRViewController.h"
#import "FeesScreen.h"
#import "parentImagegallery.h"
#import "parentvideocallery.h"
#import "LeaveApplicationScreen.h"
#import "StudentListScreen.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "parentlocatebus.h"
#import "parentevent.h"
#import "parenthomework.h"
#import "parentattendencesheet.h"
#import "driverchangepassword.h"

@interface Result ()<CDRTranslucentSideBarDelegate,kDropDownListViewDelegate>
{
    UIButton *btnclk;
    NSMutableArray *arrStudent,*arrStuid,*arrsubj,*arrcount,*arrimge,*arrmarks,*arrgetcount,*arrdate,*arrexams,*arrtotalmarks,*arrrootid;
    NSUserDefaults *prefs;
    NSString *id1;
    NSString *level,*setid,*stdname,*stdid,*root_id;
    NSMutableArray *arryProfile;
    int k,getsection;
    NSInteger school;
    NSString *Profile;
    UITableView *tableView1;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation Result

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
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    stdid=[prefs stringForKey:@"stdid"];
    stdname=[prefs stringForKey:@"stdname"];
    arrStuid=[prefs objectForKey:@"arrStudid"];
    arrStudent=[prefs objectForKey:@"arrStudent"];
    arrrootid=[prefs objectForKey:@"arrrootid"];
    root_id=[prefs objectForKey:@"root_id"];
    
    if (arrStudent.count>0)
    {
        tblresult.hidden=NO;
        [self getmarks];
    }
    else
    {
    
        tblresult.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getmarks
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    arrsubj=[[NSMutableArray alloc]init];
    arrgetcount=[[NSMutableArray alloc]init];
    arrdate=[[NSMutableArray alloc]init];
    arrexams=[[NSMutableArray alloc]init] ;
    arrcount=[[NSMutableArray alloc]init];
    arrimge=[[NSMutableArray alloc]init];
    arrtotalmarks=[[NSMutableArray alloc]init];
    arrmarks=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@result.php?student_id=%@",[[Singleton sharedSingleton] getBaseURL],stdid];
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
            if([[dictionary2 valueForKey:@"Post"] isEqual:@""])
            {
                tblresult.hidden=YES;
            }
            else
            {
                NSMutableArray *arr=[dictionary2 valueForKey:@"Post"];
                
                for(i=0;i<arr.count;i++)
                {
                    [arrsubj addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"name" ]]];
                    [arrcount addObject:@"0"];
                    [arrimge addObject:@"0"];
                    
                    if ([[[arr objectAtIndex:i]valueForKey:@"get_result" ] isEqual:@""])
                    {
                        [arrgetcount addObject:@"0"];
                    }
                    else
                    {
                        NSMutableArray *result11=[[arr objectAtIndex:i]valueForKey:@"get_result" ];
                        [arrgetcount addObject:[NSString stringWithFormat:@"%lu",(unsigned long)result11.count]];
                        
                        for (int j=0; j<result11.count; j++)
                        {
                            NSMutableDictionary *dic1=[result11 objectAtIndex:j];
                            
                            
                            NSString *myDateString =[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"ex_date"]];
                           
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            NSDate *date = [dateFormatter dateFromString:myDateString];
                            
                            /// here this is your DATE with format yyyy-MM-dd
                            
                            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of DATE..
                            [dateFormatter1 setDateFormat:@"dd-MMM-yyyy"]; //// here set format of date which is in your output date (means above str with format)
                            
                            
                            
                            NSString *convertedString = [dateFormatter1 stringFromDate:date];
                           
                            [arrdate addObject:convertedString];
                            [arrexams addObject:[dic1 objectForKey:@"name"]];
                            [arrtotalmarks addObject:[dic1 objectForKey:@"total_marks"]];
                            [arrmarks addObject:[dic1 objectForKey:@"marks"]];
                            
                        }
                        
                    }
                    
                }

            }
            
            [tblresult reloadData];
            tblresult.hidden=NO;
        }
        
        else
        {
            [tblresult reloadData];
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
        
        [SVProgressHUD dismiss];
    }];
    [operation1 start];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView==tblresult)
    {
        return arrsubj.count;
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
    
    if (tableView==tblresult)
    {
        NSLog(@"row%ld",(long)[[arrcount objectAtIndex:section] integerValue]);
        NSLog(@"section%ld",(long)section);
        
        if ([[arrcount objectAtIndex:section] integerValue]==0)
        {
            return 0;
        }
        else
        {
            return [[arrcount objectAtIndex:section] integerValue]+1;
        }
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
    if (tableView==tblresult)
    {
        return 60;
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
    
    if (tableView==tblresult)
    {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,5,tableView.frame.size.width,50)];
        customView.backgroundColor=[UIColor whiteColor];
        
        UILabel *customView1 = [[UILabel alloc] initWithFrame:customView.frame];
        
        customView1.font = [UIFont boldSystemFontOfSize:18];
        
       /* if (section % 11 == 1)
        {
            customView1.backgroundColor=[UIColor colorWithRed:15.0/255.0 green:113.0/255.0 blue:147.0/255.0 alpha:1.0];
        }
        else if (section % 11 == 2)
        {
            customView1.backgroundColor=[UIColor colorWithRed:6.0/255.0  green:147.0/255.0 blue:43.0/255.0 alpha:1.0];
        }
        
        else if (section % 11 == 3)
        {
            customView1.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:176.0/255.0 blue:21.0/255.0 alpha:1.0];
        }
        else if (section % 11 == 4)
        {
            customView1.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:83.0/255.0 blue:15.0/255.0 alpha:1.0];
        }
        else  if (section % 11 == 5)
        {
            customView1.backgroundColor=[UIColor colorWithRed:151.0/255.0 green:91.0/255.0 blue:46.0/255.0 alpha:1.0];
        }
        else if (section % 11 == 6)
        {
            customView1.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:83.0/255.0 blue:15.0/255.0 alpha:1.0];
        }
        else if (section % 11 == 7)
        {
            customView1.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:176.0/255.0 blue:21.0/255.0 alpha:1.0];
        }
        else if (section % 11 == 8)
        {
            customView1.backgroundColor=[UIColor colorWithRed:6.0/255.0  green:147.0/255.0 blue:43.0/255.0 alpha:1.0];
        }
        else if (section % 11 == 9)
        {
            customView1.backgroundColor=[UIColor colorWithRed:15.0/255.0 green:113.0/255.0 blue:147.0/255.0 alpha:1.0];
        }
        
        else if (section % 11 == 10)
        {
            customView1.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1.0];
        }
        
        else
        {
            customView1.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1.0];
        }*/
        
        
        customView1.backgroundColor=[UIColor colorWithRed:172.0/255.0 green:175.0/255.0 blue:205.0/255.0 alpha:1.0];
        
        [customView addSubview:customView1];
        UIImage *myImage;
        NSString *str;
        // create image object
        if ([[arrimge objectAtIndex:section] isEqual:@"0"])
        {
            myImage = [UIImage imageNamed:@"plus.png"];
            
            str=@"+";
        }
        else
        {
            myImage = [UIImage imageNamed:@"index.jpg"];
            str=@"-";
        }
        
        
        // create the label objects
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:18];
        headerLabel.frame = CGRectMake(20,20,200,20);
        headerLabel.text =  [arrsubj objectAtIndex:section];
        headerLabel.textColor = [UIColor whiteColor];
        
        UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectZero];
        //[imageView setBackgroundImage:myImage forState:UIControlStateNormal];
        imageView.frame = CGRectMake(260,10,50,40);
        imageView.tag=section;
        
        imageView.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        
        
        [imageView setTitle: str forState: UIControlStateNormal];
        imageView.titleLabel.textColor=[UIColor blueColor];
        
        [imageView addTarget:self action:@selector(btnClickedEdit:) forControlEvents:UIControlEventTouchUpInside];
        [customView addSubview:imageView];
        [customView addSubview:headerLabel];
        
        return customView;
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
    
    if (tableView==tblresult)
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
    
    if (tableView==tblresult)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        NSMutableArray *aarrmarks=[[NSMutableArray alloc]init];
        NSMutableArray *aarrdate=[[NSMutableArray alloc]init];
        NSMutableArray *aarrtotalmarks=[[NSMutableArray alloc]init];
        NSMutableArray *aarrexams=[[NSMutableArray alloc]init];
        NSMutableArray *arrdisplaycount=[[NSMutableArray alloc]init];
        
        [arrdisplaycount addObject:@"#"];
        [aarrmarks addObject:@""];
        [aarrdate addObject:@"Date"];
        [aarrtotalmarks addObject:@"Marks"];
        [aarrexams addObject:@"Exams"];
        
        for (i=0; i<getsection; i++)
        {
            [aarrmarks addObject:[arrmarks objectAtIndex:k+i]];
            [aarrdate addObject:[arrdate objectAtIndex:k+i]];
            [aarrtotalmarks addObject:[arrtotalmarks objectAtIndex:k+i]];
            [aarrexams addObject:[arrexams objectAtIndex:k+i]];
            [arrdisplaycount addObject:[NSString stringWithFormat:@"%d",i+1]];
            
        }
        
        //CustomcarCell cell = (CustomcarCell )[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        
        ce.lblname.text=[arrdisplaycount objectAtIndex:indexPath.row];
        ce.lblDate.text =[aarrdate objectAtIndex:indexPath.row];
       
        ce.lblexams.text =[aarrexams objectAtIndex:indexPath.row];
        NSString *mark=[aarrtotalmarks objectAtIndex:indexPath.row];
        mark=[mark stringByReplacingOccurrencesOfString:@" marks" withString:@""];
        
        if (indexPath.row==0)
        {
            ce.lbltotalmarks.text=[aarrtotalmarks objectAtIndex:indexPath.row];
        }
        else
        {
             ce.lbltotalmarks.text=[NSString stringWithFormat:@"%@/%@ ",[aarrmarks objectAtIndex:indexPath.row],[aarrtotalmarks objectAtIndex:indexPath.row]];
            /*if ([mark integerValue]>92)
            {
                ce.lbltotalmarks.layer.cornerRadius=5;
                ce.lbltotalmarks.backgroundColor=[UIColor greenColor];
                ce.lbltotalmarks.clipsToBounds=YES;
            }
            else
            {
                ce.lbltotalmarks.layer.cornerRadius=5;
                ce.lbltotalmarks.backgroundColor=[UIColor purpleColor];
                ce.lbltotalmarks.clipsToBounds=YES;
            }*/
        }
        
        
        
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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
    if(tableView==tblresult)
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

-(IBAction)btnClickedEdit:(id)sender
{
    NSInteger tag=((UIButton *)sender).tag;
    NSLog(@"tag%ld",(long)tag);
    k=0;
    
    getsection = [[arrgetcount objectAtIndex:tag] intValue];
    for (i=0; i<arrimge.count; i++)
    {
        if (tag>i)
        {
            k = k +[[arrgetcount objectAtIndex:i] intValue];
            
        }
        else
        {
            
        }
    }
    
    for (i=0; i<arrimge.count; i++)
    {
        if (tag==i)
        {
            
            // int n=[[arrgetcount objectAtIndex:tag]intValue]+1;
            
            if ([[arrimge objectAtIndex:tag] isEqual:@"0"])
            {
                [arrimge replaceObjectAtIndex:i withObject:@"1"];
                [arrcount replaceObjectAtIndex:i withObject:[arrgetcount objectAtIndex:tag]];
                //[Arrtotalcount replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",n]];
                
            }
            else
            {
                [arrimge replaceObjectAtIndex:i withObject:@"0"];
                [arrcount replaceObjectAtIndex:i withObject:@"0"];
                //[Arrtotalcount replaceObjectAtIndex:i withObject:@"0"];
            }
        }
        else
        {
            [arrimge replaceObjectAtIndex:i withObject:@"0"];
            [arrcount replaceObjectAtIndex:i withObject:@"0"];
            // [Arrtotalcount replaceObjectAtIndex:i withObject:@"0"];
            
        }
        
    }
    
    [tblresult reloadData];
    
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }

    [viewPopupProfile setHidden:YES];
}
- (IBAction)headerTapped:(id)sender
{
    [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
}
- (IBAction)btnclickselectstudent:(id)sender {
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 120) size:CGSizeMake(self.view.frame.size.width-20, 400) isMultiple:YES];
    
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
    stdname=[arrStudent objectAtIndex:anIndex];
    stdid=[arrStuid objectAtIndex:anIndex];
    [prefs setObject:stdid forKey:@"stdid"];
    [prefs setObject:stdname forKey:@"stdname"];
    root_id=[arrrootid objectAtIndex:anIndex];
    [prefs setObject:root_id forKey:@"root_id"];
    [prefs synchronize];
    [tableView1 reloadData];
    [self getmarks];
   
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
