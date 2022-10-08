//
//  MessageScreen.m
//  AlmanAppNew
//
//  Created by SMB-Mobile01 on 2/13/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import "MessageScreen.h"
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
#import "FeesScreen.h"
#import "StudentListScreen.h"
#import "LeaveApplicationScreen.h"
#import "Result.h"
#import "parentImagegallery.h"
#import "parentvideocallery.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "parentlocatebus.h"
#import "parentevent.h"
#import "parenthomework.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "UIView+Toast.h"
#import "parentattendencesheet.h"
#import "driverchangepassword.h"

@interface MessageScreen ()<CDRTranslucentSideBarDelegate>
{
    UIButton *btnclk;
    UITableView *tableView1;

    NSMutableArray *arrgmsg,*arrgmsgid,*arrgmsgdate,*arrgdescription,*arrgdate;
    NSMutableArray *arrsearchgmsg,*arrsearchgmsgdate,*arrsearcgmsgid,*arrsearcgdescription,*arrsearcgdate,*arrStudid,*arrStudent,*arrrootid;
    NSUserDefaults *prefs;
    NSString *id1;
    NSMutableArray *arrTeacherDate,*arrTeacherMessage,*arrTeacherschool,*arrFrom,*arrto;
     NSMutableArray *arrSearchTeacherDate,*arrSearchTeacherMessage,*arrSearchTeacherschool,*arrSearchFrom,*arrSearchto,*arrflag,*arrsearchflag;
    int flag;
    NSString *Title,*Discription,*stdid,*stdname,*root_id;
    NSString *Profile;
    NSString *level,*setid;
    NSMutableArray *arryProfile;
    NSString *General;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation MessageScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   //s [self getGeneralList];
    
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

    
    txtSearch.layer.borderWidth = 1;
    txtSearch.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
   // txtSearch.layer.cornerRadius=3;
    
    viewReadMore.layer.borderWidth = 1;
    viewReadMore.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];

    [txtSearch addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    viewwebview.layer.borderWidth = 1;
    viewwebview.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
   
    //NSString *Teacher=[prefs stringForKey:@"Teachermsg"];
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    General=[prefs stringForKey:@"Generalmsg"];
    
     stdid=[prefs stringForKey:@"stdid"];
     stdname=[prefs stringForKey:@"stdname"];
     arrStudid=[prefs objectForKey:@"arrStudid"];
     arrStudent=[prefs objectForKey:@"arrStudent"];
    arrrootid=[prefs objectForKey:@"arrrootid"];
    root_id=[prefs objectForKey:@"root_id"];
    viewwebview.hidden=YES;
     if ([General isEqual:@"1"])
     {
         
         lbltitle.text=@"General Messages";
          [self getGeneralList];
     }
     else
     {
          lbltitle.text=@"Teacher Messages";
         [self getteachermsg];
     }
//     else if([Teacher isEqual:@"2"])
//     {
//            [self getteachermsg];
//     }
//     else{
//         
//     }
//    [btnObjTeacher setBackgroundImage:[UIImage imageNamed:@"iphonmessages_05.png"] forState:UIControlStateNormal];
//    [btnObjHomework setBackgroundImage:[UIImage imageNamed:@"iphonmessages_08.png"] forState:UIControlStateNormal];
//    [btnObjGeneral setBackgroundImage:[UIImage imageNamed:@"iphonmessages_031.png"] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [viewPopupProfile setHidden:YES];
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
- (IBAction)btnClickedtoggle:(id)sender {
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

//- (IBAction)btnClickedGeneral:(id)sender {
//    [btnObjTeacher setBackgroundImage:[UIImage imageNamed:@"iphonmessages_05.png"] forState:UIControlStateNormal];
//    [btnObjHomework setBackgroundImage:[UIImage imageNamed:@"iphonmessages_08.png"] forState:UIControlStateNormal];
//    [btnObjGeneral setBackgroundImage:[UIImage imageNamed:@"iphonmessages_031.png"] forState:UIControlStateNormal];
//    
//   // [txtSearch setHidden:YES];
//    flag=0;
//    [self getGeneralList];
//}

//- (IBAction)btnClickedTeacher:(id)sender {
//    [btnObjTeacher setBackgroundImage:[UIImage imageNamed:@"iphonmessages_051.png"] forState:UIControlStateNormal];
//    [btnObjGeneral setBackgroundImage:[UIImage imageNamed:@"iphonmessages_032.png"] forState:UIControlStateNormal];
//    [btnObjHomework setBackgroundImage:[UIImage imageNamed:@"iphonmessages_08.png"] forState:UIControlStateNormal];
//    //[txtSearch setHidden:YES];
//    flag=1;
//    [self getteachermsg];
//}

- (IBAction)btnClickedHomework:(id)sender {
}

- (IBAction)btnClickedTrasparent:(id)sender {
    [btnObjTrasparent setHidden:YES];
    [viewReadMore setHidden:YES];
}

- (IBAction)btnClickedClose:(id)sender {
    [btnObjTrasparent setHidden:YES];
    [viewReadMore setHidden:YES];
}

- (IBAction)btnwebviewclose:(id)sender {
    
    [viewwebview setHidden:YES];
}

- (IBAction)btnclkdownload:(id)sender
{
    
    [self saveFile];
    
}

- (IBAction)btnclknextview:(id)sender {
    [web1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[prefs stringForKey:@"upload_docs"]]]];
    viewwebview.hidden=NO;
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
- (IBAction)btnClickedReadMore:(id)sender {
    
    NSInteger tags = ((UIButton *)sender).tag;
    [btnObjTrasparent setHidden:NO];
    btnname.hidden=YES;
    [viewReadMore setHidden:NO];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[viewReadMore layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
//    tvTitle.textColor=[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1];
//    tvTitle.selectable=YES;

    if([General isEqual:@"1"])
    {
        tvTitle.text=[arrsearchgmsg objectAtIndex:tags];
        tvDescription.text=[arrsearcgdescription objectAtIndex:tags];
       
        NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearchgmsgdate[tags]];
        NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
        lblDateDisplay.text=[NSString stringWithFormat:@"%@ %@",components1[0],components1[1]];
        
        
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
            
            for (int i = 0; i< dataArr.count; i++)
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
        else{
        }
        
    }
    else
    {
        tvTitle.text=[arrSearchTeacherMessage objectAtIndex:tags];
        tvDescription.text=[arrSearchTeacherschool objectAtIndex:tags];
        NSString *myDateString =[NSString stringWithFormat:@"%@",arrSearchTeacherDate[tags]];
        NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
        lblDateDisplay.text=[NSString stringWithFormat:@"%@ %@",components1[0],components1[1]];
        
    
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tblGeneralMessage)
    {
        if([General isEqual:@"1"])
        {
             return 1;
        }
        else{
             return 1;
        }
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
    if (tableView==tblGeneralMessage)
    {
        if([General isEqual:@"1"])
        {
            return arrsearcgmsgid.count;
            NSLog(@"%lu",(unsigned long)arrsearcgmsgid.count);
        }
        else{
            return arrSearchTeacherMessage.count;
              NSLog(@"%lu",(unsigned long)arrSearchTeacherMessage.count);
        }
    }
   else if (tableView==tblProfile)
    {
        return arryProfile.count;
    }

   else
   {
        return 10;
   }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView==tblGeneralMessage)
    {
        if([General isEqual:@"1"])
        {
            return 0;

        }
        else{
            return 0;

        }

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
    if (tableView==tblGeneralMessage)
    {
        if([General isEqual:@"1"])
        {
           return nil;
            
        }
        else{
            return nil;
        }

        
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
    if (tableView==tblGeneralMessage)
    {
        if([General isEqual:@"1"])
        {
             return 121;
            
        }
        else{
            return 121;
        }

       
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView==tblGeneralMessage)
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
        if([General isEqual:@"1"])
        {
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
            
            ce.lblTitle.text=[NSString stringWithFormat:@"%@",arrsearchgmsg[indexPath.row]];
           // Title=[NSString stringWithFormat:@"%@",arrsearchgmsg[indexPath.row]];
            //        [ce.lbla setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
            //        ce.lbla.textColor=[UIColor blackColor];
            
            ce.lblDescription.text=[NSString stringWithFormat:@"%@",arrsearcgdescription[indexPath.row]];
           // Discription=[NSString stringWithFormat:@"%@",arrsearcgdescription[indexPath.row]];
            ce.lblTime.text=[NSString stringWithFormat:@"%@:%@",[time1 componentsSeparatedByString:@":"][0],[time1 componentsSeparatedByString:@":"][1]];
            ce.lblDate.text=[NSString stringWithFormat:@"%@ %@",weekdayName,date1];
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
        }
        else{
            NSString *myDateString =[NSString stringWithFormat:@"%@",arrSearchTeacherDate[indexPath.row]];
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

            
            ce.lblTitle.text=[NSString stringWithFormat:@"%@",arrSearchTeacherMessage[indexPath.row]];
            ce.lblDescription.text=[NSString stringWithFormat:@"%@",arrSearchTeacherschool[indexPath.row]];
            
           ce.lblTime.text=[NSString stringWithFormat:@"%@:%@",[time1 componentsSeparatedByString:@":"][0],[time1 componentsSeparatedByString:@":"][1]];
           // ce.lblTime.text=[NSString stringWithFormat:@"%@",time1];
            ce.lblDate.text=[NSString stringWithFormat:@"%@ %@",weekdayName,date1];
            
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
    
    
    if (tableView==tblGeneralMessage)
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

- (IBAction)headerTapped:(id)sender
{
    [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
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
    [prefs setObject:root_id forKey:@"root_id"];
    
    [prefs setObject:stdid forKey:@"stdid"];
    [prefs setObject:stdname forKey:@"stdname"];
    
    [prefs synchronize];
    [tableView1 reloadData];
    
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

-(void)getGeneralList
{
    arrgmsg=[[NSMutableArray alloc]init];
    arrgmsgdate=[[NSMutableArray alloc]init];
    arrgmsgid=[[NSMutableArray alloc]init];
    arrgdescription=[[NSMutableArray alloc]init];
    arrgdate=[[NSMutableArray alloc]init];
    
    arrsearchgmsg=[[NSMutableArray alloc]init];
    arrsearchgmsgdate=[[NSMutableArray alloc]init];
    arrsearcgmsgid=[[NSMutableArray alloc]init];
    arrsearcgdescription=[[NSMutableArray alloc]init];
    arrsearcgdate=[[NSMutableArray alloc]init];
    
    [SVProgressHUD showProgress:0 status:@"Loading"];
//    tblgenral.hidden=NO;
//    tblcalender.hidden=YES;
//    tbroute.hidden=YES;
//    tblteacher.hidden=YES;
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@school_general_message_title.php?user_id=%@&type=parent",[[Singleton sharedSingleton] getBaseURL],id1];
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary = (NSMutableDictionary *)responseObject;
        
        if ([[dictionary valueForKey:@"status"] isEqualToString:@"YES"] ) {
            for(int i=0;i<[[dictionary valueForKey:@"Post"]count];i++)
            {
                [arrgmsg addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"messege"]]];
                [arrgmsgid addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes_id"]]];
                [arrgmsgdate addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes_date"]]];
                [arrgdescription addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"description"]]];
                [arrgdate addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"school_name"]]];
                
            }
            
            [arrsearchgmsg addObjectsFromArray:arrgmsg];
            [arrsearchgmsgdate addObjectsFromArray:arrgmsgdate];
            [arrsearcgmsgid addObjectsFromArray:arrgmsgid];
            [arrsearcgdescription addObjectsFromArray:arrgdescription];
            [arrsearcgdate addObjectsFromArray:arrgdate];
            arrflag=[[NSMutableArray alloc]init];
            arrsearchflag=[[NSMutableArray alloc]init];
            
            [arrflag addObject:@"1"];
            for (int i=0; i<arrsearchgmsgdate.count-1; i++)
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
            [tblGeneralMessage reloadData];
        }
        else
        {
            [tblGeneralMessage reloadData];
            
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
-(void)getteachermsg
{
    arrTeacherDate = [[NSMutableArray alloc]init];
    arrTeacherMessage = [[NSMutableArray alloc]init];
    arrTeacherschool = [[NSMutableArray alloc]init];
    arrFrom = [[NSMutableArray alloc]init];
    arrto = [[NSMutableArray alloc]init];

    arrSearchTeacherDate=[[NSMutableArray alloc]init];
    arrSearchTeacherMessage=[[NSMutableArray alloc]init];
    arrSearchTeacherschool=[[NSMutableArray alloc]init];
    arrSearchFrom=[[NSMutableArray alloc]init];
    arrSearchto=[[NSMutableArray alloc]init];

    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@teachermessages.php?parent_id=%@&student_id=%@",[[Singleton sharedSingleton] getBaseURL],id1,stdid];
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
            for(int i=0;i<[[dictionary valueForKey:@"Post"]count];i++)
            {
                [arrTeacherDate addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes_date"]]];
                [arrTeacherMessage addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"messege"]]];
                [arrTeacherschool addObject:[NSString stringWithFormat:@"%@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"school_name"]]];
                [arrFrom addObject:[NSString stringWithFormat:@"From: %@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"teacher"]]];
                [arrto addObject:[NSString stringWithFormat:@"To     : %@",[[[dictionary valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"student"]]];
            }
            [arrSearchTeacherMessage addObjectsFromArray:arrTeacherMessage];
            [arrSearchTeacherDate addObjectsFromArray:arrTeacherDate];
            [arrSearchTeacherschool addObjectsFromArray:arrTeacherschool];
            [arrSearchFrom addObjectsFromArray:arrFrom];
            [arrSearchto addObjectsFromArray:arrto];
            arrflag=[[NSMutableArray alloc]init];
            arrsearchflag=[[NSMutableArray alloc]init];
            [arrflag addObject:@"1"];
            for (int i=0; i<arrSearchTeacherDate.count-1; i++)
            {
                NSString *myDateString =[NSString stringWithFormat:@"%@",arrSearchTeacherDate[i]];
                NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                NSString *date1 = components1[0];
                
                NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrSearchTeacherDate[i+1]];
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
            
            [tblGeneralMessage reloadData];
        }
        else
        {
             [tblGeneralMessage reloadData];
            
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
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
- (IBAction)textFieldDidChange:(id)sender
{
    arrsearchgmsg=[[NSMutableArray alloc]init];
    arrsearchgmsgdate=[[NSMutableArray alloc]init];
    arrsearcgmsgid=[[NSMutableArray alloc]init];
    arrsearcgdescription=[[NSMutableArray alloc]init];
    arrsearcgdate=[[NSMutableArray alloc]init];
    arrsearchflag=[[NSMutableArray alloc]init];
    arrSearchTeacherDate=[[NSMutableArray alloc]init];
    arrSearchTeacherschool=[[NSMutableArray alloc]init];
    NSString *searchText=txtSearch.text;
    
    if([General isEqual:@"1"])
    {
        if ([txtSearch.text isEqual:@""])
        {
            txtSearch.placeholder=@"Search";
            [arrsearchgmsg addObjectsFromArray:arrgmsg];
            [arrsearchgmsgdate addObjectsFromArray:arrgmsgdate];
            [arrsearcgmsgid addObjectsFromArray:arrgmsgid];
            [arrsearcgdescription addObjectsFromArray:arrgdescription];
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
                }
                else
                {
                    
                }
            }
            if (arrsearchgmsg.count>0)
            {
                [arrsearchflag addObject:@"1"];
                for (int i=0; i<arrsearchgmsgdate.count-1; i++)
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
        [tblGeneralMessage reloadData];
    
    }
    else
    {
        if ([txtSearch.text isEqual:@""])
        {
            txtSearch.placeholder=@"Search";
            [arrSearchTeacherMessage addObjectsFromArray:arrTeacherMessage];
            [arrSearchTeacherDate addObjectsFromArray:arrTeacherDate];
            [arrSearchTeacherschool addObjectsFromArray:arrTeacherschool];
            [arrsearchflag addObjectsFromArray:arrflag];
        }
        else
        {
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
            arrSearchTeacherMessage = [[arrTeacherMessage filteredArrayUsingPredicate:resultPredicate]mutableCopy];
            for (int i123=0; i123<arrTeacherMessage.count; i123++)
            {
                if ([arrSearchTeacherMessage containsObject:[arrTeacherMessage objectAtIndex:i123]])
                {
                    [arrSearchTeacherDate addObject:[arrTeacherDate objectAtIndex:i123]];
                    [arrSearchTeacherschool addObject:[arrTeacherschool objectAtIndex:i123]];
                }
                else
                {
                    
                }
            }
            if (arrSearchTeacherMessage.count>0)
            {
                [arrsearchflag addObject:@"1"];
                for (int i=0; i<arrSearchTeacherDate.count-1; i++)
                {
                    NSString *myDateString =[NSString stringWithFormat:@"%@",arrSearchTeacherDate[i]];
                    NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                    NSString *date1 = components1[0];
                    NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrSearchTeacherDate[i+1]];
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
        [tblGeneralMessage reloadData];
    }
}


@end
