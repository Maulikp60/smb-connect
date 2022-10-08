//
//  ViewController.m
//  SmartSchool
//
//  Created by Qutub Kothari on 7/8/14.
//  Copyright (c) 2014 SAK Solutions. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIProgressView+AFNetworking.h"
#import "CDRAppDelegate.h"
#import "UIView+Toast.h"
#import "Singleton.h"
#import "CDRViewController.h"
#import "TeacherDashboard.h"
#import "Nonacademicdashboard.h"
#import "Driverdashboard.h"
#import "DriverMessageScreen.h"
#import "Validate.h"

@interface ViewController ()
{
    CDRAppDelegate *app;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    txtUsername.layer.borderWidth = 1;
    txtUsername.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtPassword.layer.borderWidth = 1;
    txtPassword.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtContactNo.layer.borderWidth = 1;
    txtContactNo.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
     if (![self connected])
     {
         [self.view makeToast:@"Internet Connection Is Not Available"];
     }
        txtUsername.returnKeyType=UIReturnKeyNext;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"0" forKey:@"getcountstd"];
    [prefs synchronize];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(IBAction)btnLogin:(id)sender
{

    if (![self connected]) {
        
        [self.view makeToast:@"Internet "];
    }
    else
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        
        if([txtUsername.text isEqualToString:@""] && [txtPassword.text isEqualToString:@""])
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Plese Enter Contact Number and Password" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 [txtUsername becomeFirstResponder];
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
        }
        else if([txtUsername.text isEqualToString:@""])
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Plese Enter Contact Number" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 [txtUsername becomeFirstResponder];
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
        }
        else if([txtPassword.text isEqualToString:@""])
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Plese Enter Password" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 [txtPassword becomeFirstResponder];
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
             [alertView show];
        }
        else  if (![Validate isNumbersOnly:txtUsername.text])
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Plese Enter Valid Contact Number" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 [txtPassword becomeFirstResponder];
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
        }
        else
        {
            [SVProgressHUD showProgress:0 status:@"Loading"];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
            NSString *myRequestString1=[NSString stringWithFormat: @"%@login.php?username=%@&password=%@&token=%@&device=iphone",[[Singleton sharedSingleton] getBaseURL],txtUsername.text,txtPassword.text,setid];
            
            NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url1 = [NSURL URLWithString:str1];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url1];
            NSURLResponse * response = nil;
            NSError * error = nil;
            NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                  returningResponse:&response
                                                              error:&error];
            NSDictionary *json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
            NSLog(@"%@",json);
            if([[json objectForKey:@"status"]isEqualToString:@"YES"])
            {
               
                NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
                [prefs1 setBool:YES forKey:@"boolVal"];
                NSString *myString = [prefs stringForKey:@"boolVal"];
                NSLog(@"mystr%@",myString);
                [prefs1 setObject:[json objectForKey:@"level"] forKey:@"level"];
                NSLog(@"level%@",[json objectForKey:@"level"]);
                [prefs1 setObject:[json objectForKey:@"name"] forKey:@"name"];
                [prefs1 setObject:[json objectForKey:@"branch_id"] forKey:@"branch_id"];
                [prefs1 setObject:[json objectForKey:@"id"] forKey:@"id"];
                [prefs1 setValue:txtPassword.text forKey:@"password"];
                [prefs synchronize];
                 [self getChildList];
                
                if([[json objectForKey:@"level"]isEqualToString:@"teacher"])
                {
                    TeacherDashboard *TeacherDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"TeacherDashboard"];
                    [self presentViewController:TeacherDashboard animated:YES completion:nil];
                  
                }
                else if([[json objectForKey:@"level"]isEqualToString:@"parent"])
                {
                    
                    CDRViewController *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"CDRViewController"];
                    [self presentViewController:parentprofile animated:YES completion:nil];
    
                }
                else if([[json objectForKey:@"level"]isEqualToString:@"driver"])
                {
                    DriverMessageScreen *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                    [self presentViewController:parentprofile animated:YES completion:nil];
                }
                else if([[json objectForKey:@"level"]isEqualToString:@"nonacademic"])
                {
                    Nonacademicdashboard *parentprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"Driverdashboard"];
                    [self presentViewController:parentprofile animated:YES completion:nil];
                }
            }
            else
            {
                TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[json valueForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
                
                [alertView handleCancel:^{
               
                }
                          handleConfirm:^{
                              
                              
                          }];
                [alertView show];
            }
        }
        [SVProgressHUD dismiss];
    // connected, do some internet stuff
    }
}

-(void)getChildList
{
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];

    NSMutableArray *arrStudent=[[NSMutableArray alloc]init];
    NSMutableArray *arrStudid=[[NSMutableArray alloc]init];
    NSMutableArray *arrrootid=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@showchild.php?parent_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs1 objectForKey:@"id"]];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       NSMutableDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",dictionary1);
        
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            for(int i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arrStudent addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"student"]]];
                [arrStudid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"stud_id"]]];
                [arrrootid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"root_id"]] ];
            }
            [prefs1 setObject:arrStudid forKey:@"arrStudid"];
            [prefs1 setObject:arrStudent forKey:@"arrStudent"];
            [prefs1 setObject:arrrootid forKey:@"arrrootid"];
            
            if (arrStudid.count>0)
            {
                [prefs1 setObject:[arrStudid objectAtIndex:0] forKey:@"stdid"];
                [prefs1 setObject:[arrStudent objectAtIndex:0] forKey:@"stdname"];
                [prefs1 setObject:[arrrootid objectAtIndex:0] forKey:@"root_id"];
            }
            
            [prefs1 synchronize];

        }
        else
        {
            [prefs1 setObject:arrStudid forKey:@"arrStudid"];
            [prefs1 setObject:arrrootid forKey:@"arrrootid"];
            [prefs1 setObject:arrStudent forKey:@"arrStudent"];
            [prefs1 synchronize];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [operation1 start];
}

- (IBAction)btnSubmit:(id)sender {
    [txtContactNo resignFirstResponder];
    [txtForgot resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtUsername resignFirstResponder];
    if([txtContactNo.text isEqualToString:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Plese Enter Contact No" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtForgot becomeFirstResponder];
             
         }
        handleConfirm:^{
                  }];
        [alertView show];
    }
    else{
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@forgot.php?contact=%@",[[Singleton sharedSingleton] getBaseURL],txtContactNo.text]]];
        NSURLResponse * response = nil;
        NSError * error = nil;
        
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                              returningResponse:&response
                                                          error:&error];
        
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        NSLog(@"%@",json);
        if([[json objectForKey:@"status"]isEqualToString:@"YES"])
        {
            [FogotView setHidden:YES];
            [objTrobleLogin setHidden:NO];
            [txtContactNo setText:@""];
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[json valueForKey:@"Post"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
        else{
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[json valueForKey:@"Post"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            [alertView handleCancel:^
             {
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
        }
    }

}

- (IBAction)btnTrobleL:(id)sender {
    [txtContactNo resignFirstResponder];
    [txtForgot resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtUsername resignFirstResponder];
    [FogotView setHidden:NO];
    //[objTrobleLogin setHidden:YES];

}

- (IBAction)btncancel:(id)sender {
    [txtContactNo resignFirstResponder];
    [txtForgot resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtUsername resignFirstResponder];
    [FogotView setHidden:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIView *view = [self.view viewWithTag:textField.tag + 1];
    if (!view)
        [textField resignFirstResponder];
    else if (textField ==txtForgot)
        [textField resignFirstResponder];
    else
        [view becomeFirstResponder];
    return YES;
}

@end
