//
//  parentcontactus.m
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "parentcontactus.h"
#import "custom.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "Singleton.h"
#import "TLAlertView.h"

@interface parentcontactus (){
    NSMutableArray *arrdestigation;
    NSMutableArray *arrname;
    NSMutableArray *arrmobile;
    NSMutableArray *arremail;
    NSInteger school;
    NSMutableArray *arrySchool,*arryClass,*arryDivision,*arryRoot,*arrschoolid,*arrrootid,*arrdiviid;
}

@end

@implementation parentcontactus

- (void)viewDidLoad {
    [super viewDidLoad];
    
    txtSelectSchool.layer.borderWidth = 1;
    txtSelectSchool.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tblContacUs.layer.borderWidth = 1;
    tblContacUs.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BtnClickedSelectSchool:(id)sender {
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select School" withOption:arrySchool xy:CGPointMake(10, 120) size:CGSizeMake(self.view.frame.size.width-20, 400) isMultiple:YES];
}

- (IBAction)btnClickedBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getSchool];
    //[self getTeacherMessage];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(NSArray *)getSchool
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectschool.php?parent_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"id"]];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
        arrySchool=[[NSMutableArray alloc]init];
        arrschoolid=[[NSMutableArray alloc]init];
        cmp_id=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for (i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arrySchool addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]] ];
                [arrschoolid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"branch_id"]] ];
                //                [ cmp_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"user_id"]] ];
            }
        }
        else {
            arrySchool=Nil;
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
    return arrySchool;
}

-(void)getTeacherMessage
{
    arrdestigation=[[NSMutableArray alloc]init];
    arrname=[[NSMutableArray alloc]init];
    arrmobile=[[NSMutableArray alloc]init];
    arremail=[[NSMutableArray alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@contactus.php?branch_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"branch_id"]];
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
        
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for(i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arrdestigation addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"designation"]]];
                [arrname addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                [arrmobile addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"contact"]]];
                [arremail addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"email"]]];
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
        [tblContacUs reloadData];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrname.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *MyIdentifier = @"Cell";
    custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    //CustomcarCell *cell = (CustomcarCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (ce == nil)
    {
        ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
    }
    ce.lblStudentName.text=[NSString stringWithFormat:@"%@",arrname[indexPath.row]];
    
    [ce.btnObjEmail setTitle:[NSString stringWithFormat:@"%@",arremail[indexPath.row]] forState:UIControlStateNormal];
    ce.btnObjPhone.tag=indexPath.row;
    ce.btnObjEmail.tag=indexPath.row;
    [ce.btnObjPhone setTitle:[NSString stringWithFormat:@"%@",arrmobile[indexPath.row]] forState:UIControlStateNormal];
    [ce.btnObjEmail addTarget:self action:@selector(btnclickEmail:) forControlEvents:UIControlEventTouchUpInside];
    [ce.btnObjPhone addTarget:self action:@selector(btnclickPhone:) forControlEvents:UIControlEventTouchUpInside];
    return ce;
    
}
-(IBAction)btnclickEmail:(id)sender
{
    NSString *emailTitle = @"";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:[arremail objectAtIndex:((UIButton *)sender).tag]];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(IBAction)btnclickPhone:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[arrmobile objectAtIndex:((UIButton *)sender).tag]]];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    i++;
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
    Dropobj.tag=i;
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    // [txtSelectFullName resignFirstResponder];
    school=[arrschoolid[anIndex]integerValue];
    txtSelectSchool.text=arrySchool[anIndex];
    [tblContacUs setHidden:NO];
    [self getTeacherMessage];
    [tblContacUs reloadData];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }
}

@end
