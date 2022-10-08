//
//  givehomework.m
//  SmbConnect
//
//  Created by apple on 04/05/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "givehomework.h"
#import "SVProgressHUD.h"
#import "Singleton.h"
#include "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#include "TLAlertView.h"
#import "IQActionSheetPickerView.h"


@interface givehomework ()
{
     NSUserDefaults *prefs;
     NSMutableArray *arrclassname,*arrclassid,*arrdivisionname,*arrdivisionid,*arrsubid,*arrsubname;
     NSString *strclassid,*strdivisionid,*strsubjectid,*strtransferid,*PastDate;
    int d1,e1,transfertag;
}
@end

@implementation givehomework

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    prefs = [NSUserDefaults standardUserDefaults];
    strtransferid=0;
    txtclassname.layer.borderWidth = 1;
    txtclassname.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtdivisionname.layer.borderWidth = 1;
    txtdivisionname.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtsubjectname.layer.borderWidth = 1;
    txtsubjectname.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txttopicname.layer.borderWidth = 1;
    txttopicname.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtdescription.layer.borderWidth = 1;
    txtdescription.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtdivisionname.layer.borderWidth = 1;
    txtdivisionname.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtattachment.layer.borderWidth = 1;
    txtattachment.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    txtsubmissiondate.layer.borderWidth = 1;
    txtsubmissiondate.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    NSDate *today = [NSDate date];
    //today=[today dateByAddingTimeInterval:60*60*24];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    PastDate = [dateFormat stringFromDate:today];
   // txtsubmissiondate.text=PastDate;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    
    txtattachment.leftView = paddingView;
    txtattachment.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    
    txtclassname.leftView = paddingView1;
    txtclassname.leftViewMode = UITextFieldViewModeAlways;
    
     UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    txtdivisionname.leftView = paddingView2;
    txtdivisionname.leftViewMode = UITextFieldViewModeAlways;
    
     UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    txtsubjectname.leftView = paddingView3;
    txtsubjectname.leftViewMode = UITextFieldViewModeAlways;
     UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    txtsubmissiondate.leftView = paddingView4;
    txtsubmissiondate.leftViewMode = UITextFieldViewModeAlways;
     UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    txttopicname.leftView = paddingView5;
    txttopicname.leftViewMode = UITextFieldViewModeAlways;
    if (transfertag==1)
    {
        transfertag=0;
    }
    else
    {
         txtdescription.text=@"Description";
    }
   
    [self getclass];
    [self getsubject];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [Dropobj fadeOut];
}
-(void )getclass
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectclass.php?branch_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs objectForKey:@"branch_id"]];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        arrclassname=[[NSMutableArray alloc]init];
        arrclassid=[[NSMutableArray alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            for (int i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arrclassname addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];
                [arrclassid addObject:[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]];
                
            }
            
            [SVProgressHUD dismiss];
        }
        else
        {
            /*TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];*/
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

-(void)getDivision
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@selectdivision.php?class_id=%@",[[Singleton sharedSingleton] getBaseURL],strclassid];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url1 = [NSURL URLWithString:str];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    // 2
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictionary1 = (NSMutableDictionary *)responseObject;
        arrdivisionid=[[NSMutableArray alloc]init];
        arrdivisionname=[[NSMutableArray alloc]init];
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            
            for (int i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arrdivisionname addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]] ];
                [arrdivisionid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"class_id"]]];
                
            }
            
        }
        else {
           /* TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                      }];
            [alertView show];*/
            
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
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
-(void)getsubject
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@subjectlist.php?branch_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs objectForKey:@"branch_id"]];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        arrsubid=[[NSMutableArray alloc]init];
        arrsubname=[[NSMutableArray alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            for (int i=0; i<[[dictionary1 valueForKey:@"Post"]count]; i++) {
                [arrsubid addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"sub_id"]]];
                [arrsubname addObject:[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]];
                
            }
            
            [SVProgressHUD dismiss];
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

- (IBAction)btnback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnselectclass:(id)sender
{
    strtransferid=@"class";
    txtdivisionname.text=@"";
    strdivisionid=@"";
    
    if (arrclassid.count==0)
    {
       /* TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[dictionary1 objectForKey:@"Post"] confirmButtonTitle:NULL 	cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             
         }
                  handleConfirm:^{
                      
                  }];
        [alertView show];*/
    }
    else
    {
        [self showPopUpWithTitle:@"Select Class" withOption:arrclassname xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
       
    }
}

- (IBAction)btnselectdivision:(id)sender {
    
    strtransferid=@"division";
    if (arrdivisionid.count==0)
    {
        
    }
    else
    {
        [self showPopUpWithTitle:@"Select Divison" withOption:arrdivisionname xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
    }
    
}

- (IBAction)btnslectsubject:(id)sender {
    strtransferid=@"subject";
    if (arrclassid.count==0)
    {
        
    }
    else
    {
        [self showPopUpWithTitle:@"Select Subject" withOption:arrsubname xy:CGPointMake(10, 58) size:CGSizeMake(self.view.frame.size.width-20, 330) isMultiple:YES];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.view.frame = CGRectMake(0,-30,self.view.frame.size.width,self.view.frame.size.height);
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtdescription becomeFirstResponder];
    self.view.frame = CGRectMake(0,-60,self.view.frame.size.width,self.view.frame.size.height);

    
    return YES;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    if([txtdescription.text isEqualToString:@"Description"])
    {
        txtdescription.text=@"";
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(txtdescription.text.length == 0)
    {
        txtdescription.text =@"Description";
        [txtdescription resignFirstResponder];
        self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);

        
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [txtdescription resignFirstResponder];
        self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);

        //[scrLeave setTransform:CGAffineTransformMakeTranslation(0,0)];
        return NO;
    }
    return YES;
}

- (IBAction)btnbrowse:(id)sender
{
    UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"" message:@"Select" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Camera",@"Photos", nil];
    [alert show];
  
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        
    }
    else if(buttonIndex == 1)
    {
        transfertag=1;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
         transfertag=1;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)btnselectdate:(id)sender
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
}
-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles{
    
    txtsubmissiondate.text=[titles componentsJoinedByString:@" - "];
    
    [self b];
    if (d1 < e1){
        
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"From Date Can't be Less Than Current Date" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtdescription resignFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
        
        
        txtsubmissiondate.text=PastDate;
        
    }
}
-(void)b{
    NSString *str1 = txtsubmissiondate.text; /// here this is your date with format yyyy-MM-dd
    NSString *str2=PastDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"MMM dd,yyyy"]; //// here set format of date which is in your output date (means above str with format)
    
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


- (IBAction)btnsubmit:(id)sender
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    
    if ([txtclassname.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Class" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtclassname resignFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([txtdivisionname.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Division" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtclassname resignFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([txtsubjectname.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Subject" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtclassname resignFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([txttopicname.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Topic" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtclassname resignFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }
    else if([txtsubmissiondate.text isEqual:@""])
    {
        TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:@"Select Complete Date" confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
        
        [alertView handleCancel:^
         {
             [txtclassname resignFirstResponder];
             
         }
                  handleConfirm:^{
                      
                      
                  }];
        [alertView show];
    }

    else
    {
        
        NSString *appurl =[NSString stringWithFormat:@"%@assignhomework.php?",[[Singleton sharedSingleton] getBaseURL]];
        
        ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:appurl]];
        
        
        [requestsASI addPostValue:strdivisionid forKey:@"sub_class"];
        [requestsASI addPostValue:[prefs stringForKey:@"id"] forKey:@"teacher_id"];
        [requestsASI addPostValue:strsubjectid forKey:@"sub_id"];
        [requestsASI addPostValue:txttopicname.text forKey:@"sub_name"];
        if ([txtdescription.text isEqual:@"Description"])
        {
            txtdescription.text=@"";
        }
        NSString *str1 = txtsubmissiondate.text; /// here this is your date with format yyyy-MM-dd
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
        [dateFormatter setDateFormat:@"MMM dd,yyyy"]; //// here set format of date which is in your output date (means above str with format)
        
        NSDate *date1 = [dateFormatter dateFromString:str1];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];// here set format which you want...
        
        NSString *a = [dateFormatter stringFromDate:date1];
        [requestsASI addPostValue:txtdescription.text forKey:@"sub_topic"];
        [requestsASI addPostValue:a forKey:@"sub_date"];
        [requestsASI addPostValue:[prefs objectForKey:@"branch_id"] forKey:@"branch_id"];
        
        NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);

        NSDate *currDate = [NSDate date];
        NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc]init];
        [dateFormatter3 setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [dateFormatter3 stringFromDate:currDate];
        
        dateString= [NSString stringWithFormat:@"%@.jpeg",dateString];
        
        [requestsASI addData:imageData withFileName:dateString andContentType:@"image/jpeg" forKey:@"uploaded_file"];
        
        [requestsASI setDownloadProgressDelegate:self];
        [requestsASI setDelegate:self];
        [requestsASI startSynchronous];
        
        NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
        NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
        NSLog(@"result%@",result);
        if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[result valueForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
            txtclassname.text=@"";
            txtdescription.text=@"Description";
            txtdivisionname.text=@"";
            txtsubjectname.text=@"";
            txtsubmissiondate.text=@"";
            txttopicname.text=@"";
            
        }
        else
        {
            TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"SMBConnect" message:[result valueForKey:@"message"] confirmButtonTitle:NULL cancelButtonTitle:@"OK"];
            
            [alertView handleCancel:^
             {
                 
             }
                      handleConfirm:^{
                          
                          
                      }];
            [alertView show];
            
        }
        [SVProgressHUD dismiss];
        
    }
    [SVProgressHUD dismiss];
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    if ([strtransferid isEqual:@"class"])
    {
        strclassid=[arrclassid objectAtIndex:anIndex];
        txtclassname.text=[arrclassname objectAtIndex:anIndex];
         [self getDivision];
        strtransferid=@"0";
    }
    else if ([strtransferid isEqual:@"division"])
    {
        strdivisionid=[arrdivisionid objectAtIndex:anIndex];
        txtdivisionname.text=[arrdivisionname objectAtIndex:anIndex];
        strtransferid=@"0";
    }
    else if ([strtransferid isEqual:@"subject"])
    {
        strsubjectid=[arrsubid objectAtIndex:anIndex];
        txtsubjectname.text=[arrsubname objectAtIndex:anIndex];
        strtransferid=@"0";
    }
    else
    {
        
    }
    
}

@end
