//
//  parentevent.m
//  SmbConnect
//
//  Created by apple on 24/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "parentevent.h"
#import "parentImagegallery.h"
#import "CDRTranslucentSideBar.h"
#import "KxMenu.h"
#import "parentprofile.h"
#import "parentfeedback.h"
#import "parentcontactus.h"
#import "parentaboutus.h"
#import "custom.h"
#import "CDRViewController.h"
#import "FeesScreen.h"
#import "StudentListScreen.h"
#import "Result.h"
#import "LeaveApplicationScreen.h"
#import "parentvideocallery.h"
#import "parentImagegallery.h"
#import "PhotoFull.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "parentlocatebus.h"
#import "parentevent.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "UIView+Toast.h"
#import "parenthomework.h"
#import "parentattendencesheet.h"
#import "driverchangepassword.h"

@interface parentevent ()<CDRTranslucentSideBarDelegate>
{
    NSMutableArray *arryProfile;
    UITableView *tableView1;
    UIButton *btnclk;
    NSString *Profile;
    NSUserDefaults *prefs;
    NSString *id1,*root_id;
    NSString *level,*setid,*stdname,*stdid,*strstatus,*selstring;
    NSInteger taked;
    int intdate;
    NSMutableArray *arrStudent,*arrStudid,*arreventmsgdate,*arryList,*arryList1,*arryList2,*arryList3,*mes_id,*arrtype,*arrSchoolName,*arryAttachemnt,*arryMessageKindly,*arryStattus,*arrsearcheventmsgdate,*arrysearchList,*arrysearchList1,*arrysearchList2,*arrysearchList3,*searchmes_id,*arrsearchtype,*arrsearchSchoolName,*arrysearchAttachemnt,*arrysearchMessageKindly,*arrysearchStattus,*arrflag,*arrsearchflag,*arrrootid;
    
   
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation parentevent

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sideBar = [[CDRTranslucentSideBar alloc] init];
    
    self.sideBar.sideBarWidth = self.view.frame.size.width*0.75;
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;
    
    tableView1= [[UITableView alloc] init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 30, tableView1.bounds.size.width, tableView1.bounds.size.height-30)];
    v.backgroundColor = [UIColor clearColor];
    [tableView1 setTableHeaderView:v];
    [tableView1 setTableFooterView:v];
    
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [tableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.sideBar setContentViewInSideBar:tableView1];
    [txtSearch addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    viewAttechment.layer.borderWidth = 1;
    viewAttechment.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];

    CalenderView.layer.borderWidth = 1;
    CalenderView.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];

    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    txtSearch.layer.borderWidth = 1;
    txtSearch.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
//    tblobj.layer.borderWidth = 1;
//    tblobj.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    id1 = [prefs stringForKey:@"id"];
    level = [prefs stringForKey:@"level"];
    setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
    CalenderView.hidden=YES;
    viewPopupProfile.hidden=YES;
    viewAttechment.hidden=YES;
    stdid=[prefs stringForKey:@"stdid"];
    stdname=[prefs stringForKey:@"stdname"];
    arrStudid=[prefs objectForKey:@"arrStudid"];
    arrStudent=[prefs objectForKey:@"arrStudent"];
    arrrootid=[prefs objectForKey:@"arrrootid"];
    root_id=[prefs objectForKey:@"root_id"];
    [self getCalenderList];

}
- (IBAction)btnDownload:(id)sender {
    [self saveFile];
}
- (IBAction)btnBack:(id)sender {
    viewAttechment.hidden=YES;
    CalenderView.hidden=NO;
}

- (IBAction)btncloseview:(id)sender {
    CalenderView.hidden=YES;
}
- (void)saveFile
{
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

-(void)getCalenderList
{
    arreventmsgdate=[[NSMutableArray alloc]init];
    arryList=[[NSMutableArray alloc]init];
    arryList1=[[NSMutableArray alloc]init];
    arryList2=[[NSMutableArray alloc]init];
    arryList3=[[NSMutableArray alloc]init];
    mes_id=[[NSMutableArray alloc]init];
    arrtype=[[NSMutableArray alloc]init];
    arrSchoolName=[[NSMutableArray alloc]init];
    arryAttachemnt=[[NSMutableArray alloc]init];
    arryMessageKindly=[[NSMutableArray alloc]init];
    arryStattus=[[NSMutableArray alloc]init];
    arrflag=[[NSMutableArray alloc]init];
    
    arrysearchList=[[NSMutableArray alloc]init];
    arrysearchList1=[[NSMutableArray alloc]init];
    arrysearchList2=[[NSMutableArray alloc]init];
    arrysearchList3=[[NSMutableArray alloc]init];
    searchmes_id=[[NSMutableArray alloc]init];
    arrsearchtype=[[NSMutableArray alloc]init];
    arrsearchSchoolName=[[NSMutableArray alloc]init];
    arrysearchAttachemnt=[[NSMutableArray alloc]init];
    arrysearchMessageKindly=[[NSMutableArray alloc]init];
    arrysearchStattus=[[NSMutableArray alloc]init];
    arrsearcheventmsgdate=[[NSMutableArray alloc]init];
    arrsearchflag=[[NSMutableArray alloc]init];
    [arrflag addObject:@"1"];
    
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@event_message.php?parent_id=%@",[[Singleton sharedSingleton] getBaseURL],id1];
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
            if([[dictionary1 valueForKey:@"Post"] isEqual:@""])
            {
                tblobj.hidden=YES;
            }
            else
            {
                for(int i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
                {
                    [arryList addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"messege"]]];
                    [arryList1 addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"description"]]];
                    [arryList2 addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"start_date"]]];
                    [arryList3 addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"end_date"]]];
                    [mes_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"eve_id"]]];
                    [arryMessageKindly addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes"]]];
                    [arryStattus addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"status"]]];
                    
                    [arrtype addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"type"]]]; ;
                    [arreventmsgdate addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"mes_date"]]];
                    [arrSchoolName addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"school_name"]]];
                    [arryAttachemnt addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"attachment"]]];
                }
                
                [arrysearchList addObjectsFromArray:arryList];                      //message
                [arrysearchList1 addObjectsFromArray:arryList1];                    //description
                [arrysearchList2 addObjectsFromArray:arryList2];                    //start date
                [arrysearchList3 addObjectsFromArray:arryList3];                    //end_date
                [searchmes_id addObjectsFromArray:mes_id];                          //eve_id
                [arrysearchMessageKindly addObjectsFromArray:arryMessageKindly];    //mes=Kindly Confirm Do You Attend?,
                [arrysearchStattus addObjectsFromArray:arryStattus];                //status
                [arrsearchtype addObjectsFromArray:arrtype];                        //type=EventInformation,Office-EventResponse
                [arrsearcheventmsgdate addObjectsFromArray:arreventmsgdate];        //mes_date
                [arrsearchSchoolName addObjectsFromArray:arrSchoolName];
                [arrysearchAttachemnt addObjectsFromArray:arryAttachemnt];

                for (int i=0; i<arrsearcheventmsgdate.count-1; i++)
                {
                    NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearcheventmsgdate[i]];
                    NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                    NSString *date1 = components1[0];
                    
                    NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrsearcheventmsgdate[i+1]];
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
                [tblobj reloadData];
                tblobj.hidden=NO;
            }
            
        }
        
        else
        {
            [tblobj reloadData];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)btnClickedMenu:(id)sender {
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==tblobj)
    {
        return mes_id.count;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
        return 80;
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
    if (tableView==tblobj)
    {
        
        return 105;
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
        ce.btnReadMore.tag=indexPath.row;
        
        [ce.btnReadMore addTarget:self
                           action:@selector(btnClickedReadMore:)
                 forControlEvents:UIControlEventTouchUpInside];

        
        NSString *myDateString =[NSString stringWithFormat:@"%@",arreventmsgdate[indexPath.row]];
        NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
        NSString *time1 = components1[1];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:myDateString];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
        
        NSInteger weekday = [components weekday];
        NSString *weekdayName = [dateFormatter weekdaySymbols][weekday - 1];
        
        NSLog(@"%@ is a %@", myDateString, weekdayName);
        ce.lbla.text=[NSString stringWithFormat:@"%@",arryList[indexPath.row]];
        ce.lblb.text=[NSString stringWithFormat:@"%@",arryList1[indexPath.row]];
        
        
        
       /// here this is your DATE with format yyyy-MM-dd
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of DATE..
        [dateFormatter1 setDateFormat:@"dd-MMM-yyyy"]; //// here set format of date which is in your output date (means above str with format)
        
       
        
        NSString *convertedString = [dateFormatter1 stringFromDate:date];
        ce.lblc.text=[NSString stringWithFormat:@"%@ %@",weekdayName,convertedString];
        
        ce.lblTime.text=[NSString stringWithFormat:@"%@:%@",[time1 componentsSeparatedByString:@":"][0],[time1 componentsSeparatedByString:@":"][1]];
        
        if ([[arrsearchflag objectAtIndex:indexPath.row] isEqual:@"0"])
        {
            ce.lblc.hidden=YES;
            ce.img.hidden=NO;

        }
        else
        {
            ce.lblc.hidden=NO;
            ce.img.hidden=YES;

        }
        return ce;
    }
    else if (tableView==tblProfile)
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
- (IBAction)btnClickedReadMore:(id)sender {
    NSInteger tags = ((UIButton *)sender).tag;
     taked=tags;
     tvTitle.text=[arryList objectAtIndex:tags];
    [prefs setObject:[NSString stringWithFormat:@"%@",arryAttachemnt[tags]] forKey:@"upload_docs"];
    strstatus=[arryStattus objectAtIndex:tags];
    NSDate *today = [NSDate date]; // it will give you current date
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *a=[arryList2 objectAtIndex:tags];
    NSDate *startdateFromString1 =  [dateFormatter dateFromString:a];
    result = [today compare:startdateFromString1];
    
    NSDate *startdate = [dateFormatter dateFromString:[arryList2 objectAtIndex:tags]];
    NSDate *enddate = [dateFormatter dateFromString:[arryList3 objectAtIndex:tags]];
    
    NSDateComponents *startcomponents = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:startdate];
    NSDateComponents *endcomponents = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:enddate];
    
    NSInteger satrtweekday = [startcomponents weekday];
    NSInteger endweekday = [endcomponents weekday];
    
    NSString *startweekdayName = [dateFormatter weekdaySymbols][satrtweekday - 1];
    NSString *endweekdayName = [dateFormatter weekdaySymbols][endweekday - 1];
    
    
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd-MMM-yyyy HH:mm:ss"];// here set format which you want...
    
    NSString *startconvertedString = [dateFormatter1 stringFromDate:startdate];
    NSString *endconvertedString = [dateFormatter1 stringFromDate:enddate];
    
    lblStartDate.text = [NSString stringWithFormat:@"%@",startconvertedString];
    lblEndDate.text = [NSString stringWithFormat:@"%@",endconvertedString];
    
    /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:myDateString];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    
    NSInteger weekday = [components weekday];
    NSString *weekdayName = [dateFormatter weekdaySymbols][weekday - 1];
    
    NSLog(@"%@ is a %@", myDateString, weekdayName);*/
    
    
   // lblStartDate.text=[arryList2 objectAtIndex:tags];
    //lblEndDate.text=[arryList3 objectAtIndex:tags];
    if ([[arrtype objectAtIndex:tags] isEqual:@"Office-EventResponse"])
    {
        // comparing two dates
        
        if(result==NSOrderedDescending)
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"Event Completed" confirmButtonTitle:nil cancelButtonTitle:@"Ok"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
        else if(result==NSOrderedAscending)
        {
            
            CalenderView.hidden=NO;
            btnNameOk.hidden=YES;
            btnNameYes.hidden=NO;
            btnNameNo.hidden=NO;
//            lblStartDate.text=[arryList2 objectAtIndex:tags];
//            lblEndDate.text=[arryList3 objectAtIndex:tags];
            lblMessage.text=[arryMessageKindly objectAtIndex:tags];
            DescriptionView.text=[arryList1 objectAtIndex:tags];
            NSString *attechment=[arryAttachemnt objectAtIndex:tags];
            if([attechment isEqual:@""])
            {
                [objbtnAttechment setTitle:@"" forState:UIControlStateNormal];
                objbtnAttechment.titleLabel. numberOfLines = 2;
            }
            else
            {
                [objbtnAttechment setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
                objbtnAttechment.titleLabel. numberOfLines = 2;
            }
            // [objbtnAttechment setTitle:[arryAttachemnt objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            //  objbtnAttechment.s.text=[arryAttachemnt objectAtIndex:indexPath.row];
            // objbtnAttechment.titleLabel.numberOfLines=2;
            
        }
        else
        {
            
            CalenderView.hidden=NO;
            btnNameOk.hidden=YES;
            btnNameYes.hidden=NO;
            btnNameNo.hidden=NO;
            
//            lblStartDate.text=[arryList2 objectAtIndex:tags];
//            lblEndDate.text=[arryList3 objectAtIndex:tags];
            lblMessage.text=[arryMessageKindly objectAtIndex:tags];
            DescriptionView.text=[arryList1 objectAtIndex:tags];
            NSString *attechment=[arryAttachemnt objectAtIndex:tags];
            if([attechment isEqual:@""])
            {
                [objbtnAttechment setTitle:@"" forState:UIControlStateNormal];
                objbtnAttechment.titleLabel. numberOfLines = 2;
            }
            else
            {
                [objbtnAttechment setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
                objbtnAttechment.titleLabel. numberOfLines = 2;
            }
            
        }
    }
    else
    {
        
        if(result==NSOrderedDescending)
        {
            intdate=1;
        }
        else if(result==NSOrderedAscending)
        {
            intdate=2;
        }
        else
        {
            intdate=3;
            
        }
        CalenderView.hidden=NO;
        btnNameYes.hidden=YES;
        btnNameNo.hidden=YES;
        btnNameOk.hidden=NO;
        
        lblMessage.text=@"";
        DescriptionView.text=[arryList1 objectAtIndex:tags];
        NSString *attechment=[arryAttachemnt objectAtIndex:tags];
        if([attechment isEqual:@""])
        {
            [objbtnAttechment setTitle:@"" forState:UIControlStateNormal];
            objbtnAttechment.titleLabel. numberOfLines = 2;
        }
        else
        {
            [objbtnAttechment setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
            objbtnAttechment.titleLabel. numberOfLines = 2;
        }
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (tableView==tblobj)
//    {
//        taked=indexPath.row;
//        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
//        [prefs1 setObject:[arryAttachemnt objectAtIndex:indexPath.row] forKey:@"upload_docs"];
//        strstatus=[arryStattus objectAtIndex:indexPath.row];
//        NSDate *today = [NSDate date]; // it will give you current date
//        
//        NSComparisonResult result;
//        //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
//        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSString *a=[arryList2 objectAtIndex:indexPath.row];
//        NSDate *startdateFromString1 =  [dateFormatter dateFromString:a];
//        result = [today compare:startdateFromString1];
//        
//        if ([[arrtype objectAtIndex:indexPath.row] isEqual:@"Office-EventResponse"])
//        {
//            // comparing two dates
//            
//            if(result==NSOrderedDescending)
//            {
//                TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"Event Completed" confirmButtonTitle:nil cancelButtonTitle:@"Ok"];
//                
//                [alertView handleCancel:^
//                 {
//                     
//                 }
//                          handleConfirm:^{
//                              
//                          }];
//                [alertView show];
//            }
//            else if(result==NSOrderedAscending)
//            {
//                
//                CalenderView.hidden=NO;
//                btnNameOk.hidden=YES;
//                btnNameYes.hidden=NO;
//                btnNameNo.hidden=NO;
//                lblStartDate.text=[arryList2 objectAtIndex:indexPath.row];
//                lblEndDate.text=[arryList3 objectAtIndex:indexPath.row];
//                lblMessage.text=[arryMessageKindly objectAtIndex:indexPath.row];
//                DescriptionView.text=[arryList1 objectAtIndex:indexPath.row];
//                NSString *attechment=[arryAttachemnt objectAtIndex:indexPath.row];
//                if([attechment isEqual:@""])
//                {
//                    [objbtnAttechment setTitle:@"" forState:UIControlStateNormal];
//                    objbtnAttechment.titleLabel. numberOfLines = 2;
//                }
//                else
//                {
//                    [objbtnAttechment setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
//                    objbtnAttechment.titleLabel. numberOfLines = 2;
//                }
//                // [objbtnAttechment setTitle:[arryAttachemnt objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//                //  objbtnAttechment.s.text=[arryAttachemnt objectAtIndex:indexPath.row];
//                // objbtnAttechment.titleLabel.numberOfLines=2;
//                
//            }
//            else
//            {
//               
//                CalenderView.hidden=NO;
//                btnNameOk.hidden=YES;
//                btnNameYes.hidden=NO;
//                btnNameNo.hidden=NO;
//                lblStartDate.text=[arryList2 objectAtIndex:indexPath.row];
//                lblEndDate.text=[arryList3 objectAtIndex:indexPath.row];
//                lblMessage.text=[arryMessageKindly objectAtIndex:indexPath.row];
//                DescriptionView.text=[arryList1 objectAtIndex:indexPath.row];
//                NSString *attechment=[arryAttachemnt objectAtIndex:indexPath.row];
//                if([attechment isEqual:@""])
//                {
//                    [objbtnAttechment setTitle:@"" forState:UIControlStateNormal];
//                    objbtnAttechment.titleLabel. numberOfLines = 2;
//                }
//                else
//                {
//                    [objbtnAttechment setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
//                    objbtnAttechment.titleLabel. numberOfLines = 2;
//                }
//                
//            }
//        }
//        else
//        {
//            
//            if(result==NSOrderedDescending)
//            {
//                intdate=1;
//            }
//            else if(result==NSOrderedAscending)
//            {
//                intdate=2;
//            }
//            else
//            {
//                intdate=3;
//                
//            }
//            CalenderView.hidden=NO;
//            btnNameYes.hidden=YES;
//            btnNameNo.hidden=YES;
//            btnNameOk.hidden=NO;
//            lblStartDate.text=[arryList2 objectAtIndex:indexPath.row];
//            lblEndDate.text=[arryList3 objectAtIndex:indexPath.row];
//            lblMessage.text=@"";
//            DescriptionView.text=[arryList1 objectAtIndex:indexPath.row];
//            NSString *attechment=[arryAttachemnt objectAtIndex:indexPath.row];
//            if([attechment isEqual:@""])
//            {
//                [objbtnAttechment setTitle:@"" forState:UIControlStateNormal];
//                objbtnAttechment.titleLabel. numberOfLines = 2;
//            }
//            else
//            {
//                [objbtnAttechment setTitle:@"Click Here To View And Download" forState:UIControlStateNormal];
//                objbtnAttechment.titleLabel. numberOfLines = 2;
//            }
//        }
//        
//    }
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
    [prefs setObject:stdid forKey:@"stdid"];
    [prefs setObject:stdname forKey:@"stdname"];
    root_id=[arrrootid objectAtIndex:anIndex];
    [prefs setObject:root_id forKey:@"root_id"];
    [prefs synchronize];
    [tableView1 reloadData];
    
}
- (EKEvent *)findOrCreateEvent:(EKEventStore *)store
{
    
    NSString *title =[arryList objectAtIndex:taked];
    
    // try to find an event
    
    EKEvent *event = [self findEventWithTitle:title inEventStore:store];
    
    // if found, use it
    
    // if (event)
    //   return event;
    
    // if not, let's create new event
    
    event = [EKEvent eventWithEventStore:store];
    
    event.title = title;
    event.notes = [arryList1 objectAtIndex:taked];
    event.location = @"";
    event.calendar = [store defaultCalendarForNewEvents];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = 4;
    /* event.startDate=[arryList2 objectAtIndex:taked];
     event.endDate=[arryList3 objectAtIndex:taked];*/
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *startdateFromString = [[NSDate alloc] init];
    
    NSDate *enddateFromString = [[NSDate alloc] init];
    // voila!
    startdateFromString = [dateFormatter dateFromString:[arryList2 objectAtIndex:taked]];
    
    enddateFromString = [dateFormatter dateFromString:[arryList3 objectAtIndex:taked]];
    
    event.startDate = startdateFromString;
    //components.hour = 1;
    event.endDate = enddateFromString;
    
    return event;
}

- (EKEvent *)findEventWithTitle:(NSString *)title inEventStore:(EKEventStore *)store
{
    [prefs setObject:@"143" forKey:@"chkcal"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start range date components
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    
    // Create the end range date components
    NSDateComponents *oneWeekFromNowComponents = [[NSDateComponents alloc] init];
    oneWeekFromNowComponents.day = 7;
    NSDate *oneWeekFromNow = [calendar dateByAddingComponents:oneWeekFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneDayAgo
                                                            endDate:oneWeekFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    
    for (EKEvent *event in events)
    {
        if ([title isEqualToString:event.title])
        {
            return event;
        }
    }
    
    return nil;
}
- (void)createEventAndPresentViewController:(EKEventStore *)store
{
    EKEvent *event = [self findOrCreateEvent:store];
    
    EKEventEditViewController *controller = [[EKEventEditViewController alloc] init];
    controller.event = event;
    controller.eventStore = store;
    controller.editViewDelegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
}
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // [self getCalenderList];
}
-(void)calender
{
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    NSString *mid=[mes_id objectAtIndex:taked];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *otherStr =[NSString stringWithFormat:@"%@event_registration.php?eve_id=%@&parent_id=%@&branch_id=%@&attendance=%@",[[Singleton sharedSingleton] getBaseURL],mid,id1,branch_id,selstring];
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:otherStr]];
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
    
    NSLog(@"reslt == %@",result);
    if ([[result valueForKey:@"result"] isEqualToString:@"YES"] )
    {
        // [ILAlertView showWithTitle:@"" message:@"" closeButtonTitle:@"OK" secondButtonTitle:nil
        //                tappedSecondButton:nil];
    }
    else
    {
        // [ILAlertView showWithTitle:@"Sorry" message:@"Unsuccessfully Added" closeButtonTitle:@"OK" secondButtonTitle:nil
        //        tappedSecondButton:nil];
        
    }
    [SVProgressHUD dismiss];
    //    if ([strstatus isEqual:@"present"])
    //    {
    //        CalenderView.hidden=YES;
    //    }
    //    else if ([strstatus isEqual:@"absence"])
    //    {
    //        CalenderView.hidden=YES;
    //    }
    //    else
    //    {
    EKEventStore *store = [[EKEventStore alloc] init];
    
    if([store respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // iOS 6
        [store requestAccessToEntityType:EKEntityTypeEvent
                              completion:^(BOOL granted, NSError *error) {
                                  if (granted)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [self createEventAndPresentViewController:store];
                                      });
                                  }
                              }];
    } else
    {
        // iOS 5
        [self createEventAndPresentViewController:store];
    }
    // }
}
- (IBAction)btnYes:(id)sender {
    
    if ([strstatus isEqual:@"present"])
    {
        selstring=@"present";
        
    }
    else if ([strstatus isEqual:@"absence"])
    {
        selstring=@"absence";
    }
    else
    {
        selstring=@"present";
    }
    [self calender];
}

- (IBAction)btnOk:(id)sender {
    
    
    if(intdate==1)
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"Event Completed" confirmButtonTitle:nil cancelButtonTitle:@"Ok"];
        
        [alertView handleCancel:^
         {
             CalenderView.hidden=YES;
         }
                  handleConfirm:^{
                      
                      
                      
                  }];
        [alertView show];
    }
    else if(intdate==2)
    {
        
        
        EKEventStore *store = [[EKEventStore alloc] init];
        
        if([store respondsToSelector:@selector(requestAccessToEntityType:completion:)])
        {
            // iOS 6
            [store requestAccessToEntityType:EKEntityTypeEvent
                                  completion:^(BOOL granted, NSError *error) {
                                      if (granted)
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self createEventAndPresentViewController:store];
                                          });
                                      }
                                  }];
        } else
        {
            // iOS 5
            [self createEventAndPresentViewController:store];
        }
        
    }
    else
    {
        EKEventStore *store = [[EKEventStore alloc] init];
        
        if([store respondsToSelector:@selector(requestAccessToEntityType:completion:)])
        {
            // iOS 6
            [store requestAccessToEntityType:EKEntityTypeEvent
                                  completion:^(BOOL granted, NSError *error) {
                                      if (granted)
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self createEventAndPresentViewController:store];
                                          });
                                      }
                                  }];
        } else
        {
            // iOS 5
            [self createEventAndPresentViewController:store];
        }
        
    }
}
- (IBAction)btnNo:(id)sender {
    if ([strstatus isEqual:@"present"])
    {
        CalenderView.hidden=YES;
    }
    else if ([strstatus isEqual:@"absence"])
    {
        CalenderView.hidden=YES;
    }
    else
    {
        selstring=@"absence";
        [self calender];
    }
}
- (IBAction)btnAttechment:(id)sender {
    
    CalenderView.hidden=YES;
    viewAttechment.hidden=NO;
    NSString *id11 = [prefs stringForKey:@"upload_docs"];
    
    [WebviewAttechment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:id11]]];
    
}
- (IBAction)textFieldDidChange:(id)sender
{
    
    arreventmsgdate=[[NSMutableArray alloc]init];
    arryList=[[NSMutableArray alloc]init];
    arryList1=[[NSMutableArray alloc]init];
    arryList2=[[NSMutableArray alloc]init];
    arryList3=[[NSMutableArray alloc]init];
    mes_id=[[NSMutableArray alloc]init];
    arrtype=[[NSMutableArray alloc]init];
    arrSchoolName=[[NSMutableArray alloc]init];
    arryAttachemnt=[[NSMutableArray alloc]init];
    arryMessageKindly=[[NSMutableArray alloc]init];
    arryStattus=[[NSMutableArray alloc]init];
    arrsearchflag=[[NSMutableArray alloc]init];
    
    NSString *searchText=txtSearch.text;

        if ([txtSearch.text isEqual:@""])
        {
            txtSearch.placeholder=@"Search";
            
            [arryList addObjectsFromArray:arrysearchList];
            [arryList1 addObjectsFromArray:arrysearchList1];
            [arryList2 addObjectsFromArray:arrysearchList2];
            [arryList3 addObjectsFromArray:arrysearchList3];
            
            [mes_id addObjectsFromArray:searchmes_id];
            [arryMessageKindly addObjectsFromArray:arrysearchMessageKindly];
            [arryStattus addObjectsFromArray:arrysearchStattus];
            
            [arrtype addObjectsFromArray:arrsearchtype];
            [arreventmsgdate addObjectsFromArray:arrsearcheventmsgdate];
            [arrSchoolName addObjectsFromArray:arrsearchSchoolName];
            [arryAttachemnt addObjectsFromArray:arrysearchAttachemnt];
            [arrsearchflag addObjectsFromArray:arrflag];

        }
        else
        {
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
            arryList = [[arrysearchList filteredArrayUsingPredicate:resultPredicate]mutableCopy];
            for (int i123=0; i123<arrysearchList.count; i123++)
            {
                if ([arryList containsObject:[arrysearchList objectAtIndex:i123]])
                {
                    [arryList1 addObject:[arrysearchList1 objectAtIndex:i123]];
                    [arryList2 addObject:[arrysearchList2 objectAtIndex:i123]];
                    [arryList3 addObject:[arrysearchList3 objectAtIndex:i123]];
                    
                    [mes_id addObject:[searchmes_id objectAtIndex:i123]];
                    [arryMessageKindly addObject:[arrysearchMessageKindly objectAtIndex:i123]];
                    [arryStattus addObject:[arrysearchStattus objectAtIndex:i123]];
                    
                    [arrtype addObject:[arrsearchtype objectAtIndex:i123]];
                    [arreventmsgdate addObject:[arrsearcheventmsgdate objectAtIndex:i123]];
                    [arrSchoolName addObject:[arrsearchSchoolName objectAtIndex:i123]];
                    [arryAttachemnt addObject:[arrysearchAttachemnt objectAtIndex:i123]];
                }
                else
                {
                    
                }
            }
            
           if (arryList.count>0)
            {
                [arrsearchflag addObject:@"1"];
                for (int i=0; i<arreventmsgdate.count-1; i++)
                {
                    NSString *myDateString =[NSString stringWithFormat:@"%@",arreventmsgdate[i]];
                    NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                    NSString *date1 = components1[0];
                    NSString *myDateString1 =[NSString stringWithFormat:@"%@",arreventmsgdate[i+1]];
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
        [tblobj reloadData];
        
    
    
}
@end
