//
//  parentfeedback.m
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "parentfeedback.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "Singleton.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "Reachability.h"
#import "TLAlertView.h"

@interface parentfeedback (){
        NSMutableArray *arrlist;
        int type;
        BOOL chk;
        BOOL test;
    NSInteger school;
}

@end

@implementation parentfeedback

- (void)viewDidLoad {
    [super viewDidLoad];
    arrlist=[[NSMutableArray alloc]initWithObjects:@"Suggestions",@"Complaints",@"Report Applicaion Problem", nil];
    
    txtFeedbackType.layer.borderWidth = 1;
    txtFeedbackType.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    tvFeedbackHere.layer.borderWidth=1;
    tvFeedbackHere.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    tvFeedbackHere.layer.cornerRadius=5;
    //tvFeedbackHere.font=[UIFont fontWithName:@"System" size:30];
    tvFeedbackHere.text = @"Enter Feedback Here";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    chk=YES;
    test=YES;
    tvFeedbackHere.textColor = [UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1];
}
- (IBAction)btnClickedFeedbackType:(id)sender {
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Feedback Type" withOption:arrlist xy:CGPointMake(10, 120) size:CGSizeMake(self.view.frame.size.width-20, 400) isMultiple:YES];
}

- (IBAction)btnClickedSubmit:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *id1 = [prefs stringForKey:@"id"];
    NSString *branch_id = [prefs stringForKey:@"branch_id"];
    
    if ([txtFeedbackType.text isEqualToString:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Feedback Type" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
        
    }
    
    else if (chk==YES)
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Enter Feedback Here" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
        
    }
    else if([tvFeedbackHere.text isEqual:@"Enter Detail"])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Enter Feedback Here" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
    }
    
    else if([tvFeedbackHere.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Enter Feedback Here" confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];
    }
    else
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSString *appurl =[NSString stringWithFormat:@"%@comment.php?",[[Singleton sharedSingleton] getBaseURL]];
        ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:appurl]];
        [requestsASI addPostValue:branch_id forKey:@"branch_id"];
        [requestsASI addPostValue:id1 forKey:@"user_id"];
        
        [requestsASI addPostValue:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
        
        [requestsASI addPostValue:tvFeedbackHere.text forKey:@"message"];
        
        [requestsASI setDownloadProgressDelegate:self];
        [requestsASI setDelegate:self];
        [requestsASI startSynchronous];
        
        NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
        NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
        NSLog(@"result%@",result);
        if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[result valueForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
            
            txtFeedbackType.text=@"";
            tvFeedbackHere.text=@"";
            test=YES;
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[result valueForKey:@"message"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];
        }
        [SVProgressHUD dismiss];
    }

}

- (IBAction)btnClickedBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        //tvFeedbackHere.font=[UIFont fontWithName:@"System" size:30];
        [tvFeedbackHere resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (test==YES)
    {
        tvFeedbackHere.text = @"";
        test=NO;
    }
  //  tvFeedbackHere.textColor = [UIColor darkGrayColor];
    chk=NO;
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(tvFeedbackHere.text.length == 0)
    {
        //tvFeedbackHere.font=[UIFont fontWithName:@"System" size:30];
       // tvFeedbackHere.textColor = [UIColor lightGrayColor];
        tvFeedbackHere.text = @"Enter Feedback Here";
        [tvFeedbackHere resignFirstResponder];
    }
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
    school=[arrlist[anIndex]integerValue];
    txtFeedbackType.text=arrlist[anIndex];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }
}

@end
