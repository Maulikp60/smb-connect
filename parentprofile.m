//
//  parentprofile.m
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "parentprofile.h"
#import "TLAlertView.h"

@interface parentprofile (){
    NSMutableArray *arryName,*arryAddress,*arryCity,*arryDesignation,*arryEmaiId,*arryContact;
    NSUserDefaults *prefs;
    NSString *id1 ;
}

@end

@implementation parentprofile

- (void)viewDidLoad {
    [super viewDidLoad];
    prefs = [NSUserDefaults standardUserDefaults];
    txtName.layer.borderWidth = 1;
    txtName.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtAddress.layer.borderWidth = 1;
    txtAddress.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtCity.layer.borderWidth = 1;
    txtCity.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtDesignation.layer.borderWidth = 1;
    txtDesignation.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtEmail.layer.borderWidth = 1;
    txtEmail.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtUsername.layer.borderWidth = 1;
    txtUsername.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [self getProfileDetail];
}

/*
#pragma mark - Navigation
 txtUsername.layer.borderWidth = 1;
 txtUsername.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClickedUpdate:(id)sender {
     [self UpdateData];

}

- (IBAction)btnClickedBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    UIView *view = [self.view viewWithTag:textField.tag + 1];
    if (textField.tag > 4)
    {
       [textField resignFirstResponder];
         self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        
    }
    else
    {
        [view becomeFirstResponder];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    self.view.frame = CGRectMake(0,-30*textField.tag,self.view.frame.size.width,self.view.frame.size.height);
    
}
-(void)getProfileDetail
{
    arryName=[[NSMutableArray alloc]init];
    arryAddress=[[NSMutableArray alloc]init];
    arryCity=[[NSMutableArray alloc]init];
    arryDesignation=[[NSMutableArray alloc]init];
    arryEmaiId=[[NSMutableArray alloc]init];
    arryContact=[[NSMutableArray alloc]init];
    
    [SVProgressHUD showProgress:0 status:@"Loading"];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@user_profile.php?user_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs objectForKey:@"id"]];
    
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
            for(int i=0;i<[[dictionary1 valueForKey:@"Post"]count];i++)
            {
                [arryName addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                [arryAddress addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"address"]]];
                [arryCity addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"city"]]];
                [arryDesignation addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"designation"]]];
                [arryEmaiId addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"email"]]];
                [arryContact addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"contact"]]];
            }
            txtName.text=[arryName objectAtIndex:0];
            txtAddress.text=[arryAddress objectAtIndex:0];
            txtCity.text=[arryCity objectAtIndex:0];
            txtDesignation.text=[arryDesignation objectAtIndex:0];
            txtEmail.text=[arryEmaiId objectAtIndex:0];
            txtUsername.text=[arryContact objectAtIndex:0];
            
            
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
-(void)UpdateData
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@edituser_profile.php?user_id=%@&name=%@&address=%@&city=%@&contact=%@&designation=%@&email=%@",[[Singleton sharedSingleton] getBaseURL],[prefs objectForKey:@"id"],txtName.text,txtAddress.text,txtCity.text,txtUsername.text,txtDesignation.text,txtEmail.text];
    
    
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    // 2
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
            [prefs setObject:txtName.text forKey:@"name"];
            [prefs synchronize];
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
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


@end
