//
//  parenthomework.m
//  SmbConnect
//
//  Created by SMB-Mobile01 on 3/25/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "parenthomework.h"
#import "parentlocatebus.h"
#import "StudentListScreen.h"
#import "CDRTranslucentSideBar.h"
#import "Singleton.h"
#import "AFNetworking.h"
#import "KxMenu.h"
#import "parentaboutus.h"
#import "parentcontactus.h"
#import "parentfeedback.h"
#import "parentprofile.h"
#import "SVProgressHUD.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "CDRViewController.h"
#import "parentImagegallery.h"
#import "parentvideocallery.h"
#import "Result.h"
#import "FeesScreen.h"
#import "LeaveApplicationScreen.h"
#import "ViewController.h"
#import "TeacherDashboard.h"
#import "Driverdashboard.h"
#import "custom.h"
#import "JPSThumbnailAnnotation.h"
#import "UIView+Toast.h"
#import "parentevent.h"
#import "parentattendencesheet.h"
#import "driverchangepassword.h"
@interface parenthomework ()<CDRTranslucentSideBarDelegate>
{
      UIButton *btnclk;
    NSMutableArray *arrStudent,*arrStudid,*arrrootid;
    NSString *stdname,*stdid;
    UITableView *tableView1;
    NSUserDefaults *prefs;
    NSMutableArray *arryProfile;
    NSString *Profile,*level,*root_id,*h_id;
    
    NSMutableArray *arrsub,*arrtopic,*arrcreatedate,*arrcompdate,*arrdescription,*arrattachment,*arrflag,*arrh_id,*arris_mark;
    
   NSMutableArray *arrsearchsub,*arrsearchtopic,*arrsearchcreatedate,*arrsearchcompdate,*arrsearchdescription,*arrsearchattachment,*arrserachflag,*arrsearchh_id,*arrsearchis_mark;
    
    NSString *Title,*Discription,*Date,*chktag,*imgtag;
    UIAlertView *alerthome;
 
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation parenthomework

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
    
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [self.sideBar setContentViewInSideBar:tableView1];
    [tableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    viewPopupProfile.layer.borderWidth = 1;
    viewPopupProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    viewReadMore.layer.borderWidth = 1;
    viewReadMore.layer.borderColor=[[UIColor colorWithRed:118.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1]CGColor];
    txtSearch.layer.borderWidth = 1;
    txtSearch.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblProfile.layer.borderWidth = 1;
    tblProfile.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    txtdescription.layer.borderWidth=1;
    txtdescription.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    txtdescription.textColor=[UIColor lightGrayColor];
    btnobjhomework.layer.cornerRadius=5;
    btnobjhomework.layer.masksToBounds=YES;
    viewwebview.layer.borderWidth = 1;
    viewwebview.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    level = [prefs stringForKey:@"level"];
    chktag=@"1";
    [txtSearch addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    stdid=[prefs stringForKey:@"stdid"];
    stdname=[prefs stringForKey:@"stdname"];
    arrStudid=[prefs objectForKey:@"arrStudid"];
    arrStudent=[prefs objectForKey:@"arrStudent"];
    arrrootid=[prefs objectForKey:@"arrrootid"];
    root_id=[prefs objectForKey:@"root_id"];
    if (arrStudent.count>0)
    {
        tblobj.hidden=NO;
        [self gethomeworkmsg];
    }
    else
    {
        tblobj.hidden=YES;
    }
    
   lblsettilte.text=@"Home Work";
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    [viewPopupProfile setHidden:YES];
}
-(void)gethomeworkmsg
{

    arrsub=[[NSMutableArray alloc]init];
    arrtopic=[[NSMutableArray alloc]init];
    arrcreatedate=[[NSMutableArray alloc]init];
    arrcompdate=[[NSMutableArray alloc]init];
    arrdescription=[[NSMutableArray alloc]init];
    arrattachment=[[NSMutableArray alloc]init];
    arrflag=[[NSMutableArray alloc]init];
    arrh_id=[[NSMutableArray alloc]init];
    arris_mark=[[NSMutableArray alloc]init];
    
    arrsearchis_mark=[[NSMutableArray alloc]init];
    arrsearchh_id=[[NSMutableArray alloc]init];
    arrsearchsub=[[NSMutableArray alloc]init];
    arrsearchtopic=[[NSMutableArray alloc]init];
    arrsearchcreatedate=[[NSMutableArray alloc]init];
    arrsearchcompdate=[[NSMutableArray alloc]init];
    arrsearchdescription=[[NSMutableArray alloc]init];
    arrsearchattachment=[[NSMutableArray alloc]init];
    arrserachflag=[[NSMutableArray alloc]init];
    
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1;
    if ([chktag isEqual:@"1"])
    {
       myRequestString1 = [NSString stringWithFormat:@"%@homeworkdisplay.php?stud_id=%@",[[Singleton sharedSingleton] getBaseURL],stdid];
        
    }
    else
    {
       myRequestString1 = [NSString stringWithFormat:@"%@homeworkhistorydisplay.php?stud_id=%@",[[Singleton sharedSingleton] getBaseURL],stdid];
    }
    
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            for(int i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arrh_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"h_id"]]];
                
                [arris_mark addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"is_mark"]]];
                
                [arrsub addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                
                [arrtopic addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"topic"]]];
                
                [arrdescription addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"description"]]];
                
                [arrattachment addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"attechment"]]];
                
                [arrcompdate addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"com_date"]]];
                
                [arrcreatedate addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"create_date"]]];
                
                
            }
            [arrflag addObject:@"1"];
            
            [arrsearchh_id addObjectsFromArray:arrh_id];
            [arrsearchis_mark addObjectsFromArray:arris_mark];
            [arrsearchsub addObjectsFromArray:arrsub];
            [arrsearchtopic addObjectsFromArray:arrtopic];
            [arrsearchdescription addObjectsFromArray:arrdescription];
            [arrsearchattachment addObjectsFromArray:arrattachment];
            [arrsearchcompdate addObjectsFromArray:arrcompdate];
            [arrsearchcreatedate addObjectsFromArray:arrcreatedate];
            
            for (int i=0; i<arrsearchsub.count-1; i++)
            {
                NSString *myDateString =[NSString stringWithFormat:@"%@",arrsearchcompdate[i]];
                NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                NSString *date1 = components1[0];
                
                NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrsearchcompdate[i+1]];
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
            [arrserachflag addObjectsFromArray:arrflag];
           
        }
        
        else
        {
          /*  TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];*/
        }
         [tblobj reloadData];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)textFieldDidChange:(id)sender
{
    arrattachment=[[NSMutableArray alloc]init];
    arrcompdate=[[NSMutableArray alloc]init];
    arrcreatedate=[[NSMutableArray alloc]init];
    arrdescription=[[NSMutableArray alloc]init];
    arrsub=[[NSMutableArray alloc]init];
    arrtopic=[[NSMutableArray alloc]init];
    arrh_id=[[NSMutableArray alloc]init];
    arris_mark=[[NSMutableArray alloc]init];
    arrserachflag=[[NSMutableArray alloc]init];
    
    NSString *searchText=txtSearch.text;
    
    if ([txtSearch.text isEqual:@""])
    {
        txtSearch.placeholder=@"Search";
        [arrattachment addObjectsFromArray:arrsearchattachment];
        [arrcompdate addObjectsFromArray:arrsearchcompdate];
        [arrcreatedate addObjectsFromArray:arrsearchcreatedate];
        [arrdescription addObjectsFromArray:arrsearchdescription];
        
        [arrsub addObjectsFromArray:arrsearchsub];
        [arrtopic addObjectsFromArray:arrsearchtopic];
        [arrserachflag addObjectsFromArray:arrflag];
        [arrh_id addObjectsFromArray:arrsearchh_id];
        [arris_mark addObjectsFromArray:arrsearchis_mark];
    }
    else
    {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
        arrsub = [[arrsearchsub filteredArrayUsingPredicate:resultPredicate]mutableCopy];
        for (int i123=0; i123<arrsearchsub.count; i123++)
        {
            if ([arrsub containsObject:[arrsearchsub objectAtIndex:i123]])
            {
                [arrattachment addObject:[arrsearchattachment objectAtIndex:i123]];
                [arrcompdate addObject:[arrsearchcompdate objectAtIndex:i123]];
                [arrcreatedate addObject:[arrsearchcreatedate objectAtIndex:i123]];
                
                [arrdescription addObject:[arrsearchdescription objectAtIndex:i123]];
                [arrtopic addObject:[arrsearchtopic objectAtIndex:i123]];
                
                [arrh_id addObject:[arrsearchh_id objectAtIndex:i123]];
                [arris_mark addObject:[arrsearchis_mark objectAtIndex:i123]];
            }
            else
            {
                
            }
        }
        if (arrsub.count>0)
        {
            [arrserachflag addObject:@"1"];
            for (int i=0; i<arrcompdate.count-1; i++)
            {
                NSString *myDateString =[NSString stringWithFormat:@"%@",arrcompdate[i]];
                NSArray *components1 = [myDateString componentsSeparatedByString:@" "];
                NSString *date1 = components1[0];
                NSString *myDateString1 =[NSString stringWithFormat:@"%@",arrcompdate[i+1]];
                NSArray *components11 = [myDateString1 componentsSeparatedByString:@" "];
                NSString *date11 = components11[0];
                if([date1 isEqualToString:date11])
                {
                    [arrserachflag addObject:@"0"];
                }
                else
                {
                    [arrserachflag addObject:@"1"];
                }
            }
        }
        else
        {
        }
    }
    [tblobj reloadData];
    
    
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

- (IBAction)btnhomework:(id)sender {
    
    if ([chktag isEqual:@"1"])
    {
       
        chktag=@"2";
        lblsettilte.text=@"Home Work History";
        [btnobjhomework setTitle:@"Back" forState:UIControlStateNormal];
    }
    else
    {
       
        chktag=@"1";
        lblsettilte.text=@"Home Work";
        [btnobjhomework setTitle:@"History" forState:UIControlStateNormal];
    }
     [self gethomeworkmsg];
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
    ;
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
    [self gethomeworkmsg];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView==tblProfile)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView==tblProfile)
    {
        return arryProfile.count;
    }
    else if (tableView==tblobj)
    {
        return arrsub.count;
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
    if (tableView==tblProfile)
    {
        return 0;
    }
    else if (tableView==tblobj)
    {
        return 0;
    }
    else
    {
        return 80;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(tableView==tblProfile)
    {
        return nil;
    }
    else if(tableView==tblobj)
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
    
    [self showPopUpWithTitle:@"Select Student" withOption:arrStudent xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==tblProfile)
    {
        return 44;
    }
    else if (tableView==tblobj)
    {
        return 121;
    }
    else
    {
        
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    
    else if (tableView==tblobj)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (ce == nil)
        {
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        ce.btnReadMore.tag=indexPath.row;
        
        [ce.btnReadMore addTarget:self action:@selector(btnClickedReadMore:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSString *myDateString =[NSString stringWithFormat:@"%@",arrcompdate[indexPath.row]];
        
       // NSString *time1 = components1[1];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date = [dateFormatter dateFromString:myDateString];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
        
        NSInteger weekday = [components weekday];
        NSString *weekdayName = [dateFormatter weekdaySymbols][weekday - 1];
        
        NSLog(@"%@ is a %@", myDateString, weekdayName);
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of DATE..
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
        
        NSDate *date1 = [dateFormatter dateFromString: myDateString]; // here you can fetch date from string with define format
        
        dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"dd-MMM-yyyy"];// here set format which you want...
        
        NSString *convertedString = [dateFormatter1 stringFromDate:date1];
    
        ce.lblDate.text=[NSString stringWithFormat:@"%@ %@",weekdayName,convertedString];
        //ce.lblTime.text=time1;
        ce.lblTitle.text=[arrsub objectAtIndex:indexPath.row];
        ce.lblDescription.text=[arrtopic objectAtIndex:indexPath.row];
        
        
        NSString *a=[arrcreatedate objectAtIndex:indexPath.row];;
        NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
        [dateFormatter3 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *startdateFromString1 =  [dateFormatter3 dateFromString:a];
        
        
        NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
        [dateFormatter4 setDateFormat:@"dd-MMM-yyyy"];// here set format which you want...
        
        NSString *startconvertedString = [dateFormatter4 stringFromDate:startdateFromString1];
        

        ce.lblc.text=startconvertedString;
        
        if ([[arrserachflag objectAtIndex:indexPath.row] isEqual:@"0"])
        {
            ce.lblDate.hidden=YES;
            ce.img.image=[UIImage imageNamed:@"photogalary-lineiphonewithoutcut.png"];
        }
        else
        {
            ce.lblDate.hidden=NO;
            ce.img.image=[UIImage imageNamed:@"photogalary-lineiphonewithoutbox.png"];
        }
        if ([[arris_mark objectAtIndex:indexPath.row] isEqual:@"1"])
        {
            ce.btnObjPhone.backgroundColor=[UIColor colorWithRed:84.0/255.0 green:177.0/255.0 blue:15.0/255.0 alpha:1.0];
        }
        else
        {
            ce.btnObjPhone.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:83.0/255.0 blue:15.0/255.0 alpha:1.0];
        }
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
    else  if(tableView==tblobj)
    {
        
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
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@profile.php?user_id=%@&profile=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"],level];
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
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@toggle.php?user_id=%@&profile=%@&deviceid=%@&devicetype=iphone",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"],Profile,[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"]];
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
-(void)completehomework
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@remarkhomework.php?stud_id=%@&h_id=%@&branch_id=%@",[[Singleton sharedSingleton] getBaseURL],stdid,h_id,[prefs stringForKey:@"branch_id"]];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            btnobjmark.userInteractionEnabled=NO;
            UIImage *buttonImage = [UIImage imageNamed:@"cheack.png"];
            [btnobjmark setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
            [self gethomeworkmsg];
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
- (IBAction)btnClickedReadMore:(id)sender {
    
    NSInteger tags = ((UIButton *)sender).tag;
    [viewReadMore setHidden:NO];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[viewReadMore layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    
    lblsubj.text=[arrsub objectAtIndex:tags];
    lbltitle.text=[arrtopic objectAtIndex:tags];
    txtdescription.text=[arrdescription objectAtIndex:tags];
    h_id=[arrh_id objectAtIndex:tags];
    if ([[arrattachment objectAtIndex:tags] isEqual:@""])
    {
        btnobjnextview.hidden=YES;
    }
    else
    {
         btnobjnextview.hidden=NO;
        [web1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[arrattachment objectAtIndex:tags]]]];
    }
    NSString *a=[arrcompdate objectAtIndex:tags];;
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startdateFromString1 =  [dateFormatter3 dateFromString:a];
    
    
    NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
    [dateFormatter4 setDateFormat:@"dd-MMM-yyyy"];// here set format which you want...
    
    NSString *startconvertedString = [dateFormatter4 stringFromDate:startdateFromString1];
    

    lbldate.text=startconvertedString;
    imgtag=[arris_mark objectAtIndex:tags];
    UIImage *buttonImage;
    if ([imgtag isEqual:@"0"])
    {
        buttonImage = [UIImage imageNamed:@"uncheck.png"];
        btnobjmark.userInteractionEnabled=YES;
        
    }
    else
    {
        buttonImage = [UIImage imageNamed:@"cheack.png"];
        btnobjmark.userInteractionEnabled=NO;
    }
    
    [btnobjmark setBackgroundImage:buttonImage forState:UIControlStateNormal];

}
- (void)saveFile {
    
    NSString *stringURL = [prefs stringForKey:@"upload_docs"];
    NSString *attachmenttitle = [prefs stringForKey:@"attachmenttitle"];
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,attachmenttitle];
        [urlData writeToFile:filePath atomically:YES];
    }
    [self.view makeToast:@"Your File Is Download"];
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
- (IBAction)btnclknextview:(id)sender
{
    viewwebview.hidden=NO;
}

- (IBAction)btnmark:(id)sender {
    
    alerthome=[[UIAlertView alloc]initWithTitle:@"Smb Connect" message:@"Do You Want To Complete Homework?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alerthome show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==alerthome)
    {
        if (buttonIndex==0)
        {
            [self completehomework];
    
        }
        else
        {
            
        }
    }
    else
    {
        
    }
}
- (IBAction)btndownload:(id)sender {
    [self saveFile];
}
- (IBAction)btnClickedClose:(id)sender
{
    viewReadMore.hidden=YES;
}
- (IBAction)btnwebviewclose:(id)sender
{
     viewwebview.hidden=YES;
}
@end
