//
//  markhomework.m
//  SmbConnect
//
//  Created by apple on 04/05/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "markhomework.h"
#import "Singleton.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "SVProgressHUD.h"
#import "custom.h"
#import "AFNetworking.h"
#import "TLAlertView.h"
@interface markhomework ()
{
     NSUserDefaults *prefs;
     NSMutableArray *arrimg,*arrparent,*arrid,*arrname;
}
@end

@implementation markhomework

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
    tblobj.layer.borderWidth = 1;
    tblobj.layer.borderColor=[[UIColor colorWithRed:12.0/255.0 green:158.0/255.0 blue:239.0/255.0 alpha:1]CGColor];
    
    [self getClass];
}
-(void)getClass
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    arrimg=[[NSMutableArray alloc]init];
    arrparent=[[NSMutableArray alloc]init];
    arrid=[[NSMutableArray alloc]init];
    arrname=[[NSMutableArray alloc]init];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@remarkview.php?h_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs stringForKey:@"h_id"]];
    
    ASIFormDataRequest *requestsASI = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:myRequestString1]];
    [requestsASI setDownloadProgressDelegate:self];
    [requestsASI setDelegate:self];
    [requestsASI startSynchronous];
    
    NXJsonParser* parser = [[NXJsonParser alloc] initWithData:[requestsASI responseData]];
    NSDictionary *result  = [parser parse:nil ignoreNulls:NO];
    NSLog(@"result%@",result);
    if ([[result valueForKey:@"status"] isEqualToString:@"YES"] )
    {
        NSArray *arr1=[result objectForKey:@"Post"];
        
        for (int i=0; i<arr1.count; i++)
        {
            NSDictionary *dic1=[arr1 objectAtIndex:i];
            [arrimg addObject:[NSString stringWithFormat:@"%ld",(long)[[dic1 objectForKey:@"teach_rem_date"]integerValue]]];
            [arrparent addObject:[NSString stringWithFormat:@"%ld",(long)[[dic1 objectForKey:@"stud_com_date"]integerValue]]];
           
            [arrid addObject:[dic1 objectForKey:@"stud_id"]];
            [arrname addObject:[dic1 objectForKey:@"name"]];
        }
    }
    else
    {
        
    }
    [tblobj reloadData];
    [SVProgressHUD dismiss];
}
- (IBAction)btnback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return arrid.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *MyIdentifier = @"Cell";
        custom *cell = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
        }
        cell.lblStudentName.text=[arrname objectAtIndex:indexPath.row];
    
        
        if ([[arrparent objectAtIndex:indexPath.row] isEqual:@"0"])
        {
           
            [cell.img setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
                
        else
        {
   
            [cell.img setImage:[UIImage imageNamed:@"cheack.png"]];
        }
    
        if ([[arrimg objectAtIndex:indexPath.row] isEqual:@"0"])
        {
        
            [cell.imgteacher setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
    
        else
        {
            [cell.imgteacher setImage:[UIImage imageNamed:@"cheack.png"]];
        }
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
       NSInteger tags = indexPath.row;
   
        if ([[arrimg objectAtIndex:tags] isEqual:@"0"])
       {
            [arrimg replaceObjectAtIndex:tags withObject:@"1"];
        }
        else
        {
            [arrimg replaceObjectAtIndex:tags withObject:@"0"];
        }
    
        [tblobj reloadData];
   
}

- (IBAction)btnsubmit:(id)sender {
    
    
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSMutableArray *chk=[[NSMutableArray alloc]init];
    NSMutableArray *uncheck=[[NSMutableArray alloc]init];
    for (int i=0; i<arrimg.count; i++)
    {
        if ([[arrimg objectAtIndex:i] isEqual:@"0"])
        {
            [uncheck addObject:[arrid objectAtIndex:i]];
        }
        else
        {
            [chk addObject:[arrid objectAtIndex:i]];
        }
    }
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@updatehomeworkremark.php?checked=%@&unchecked=%@&h_id=%@&branch_id=%@",[[Singleton sharedSingleton] getBaseURL],[chk componentsJoinedByString:@","],[uncheck componentsJoinedByString:@","],[prefs stringForKey:@"h_id"],[prefs objectForKey:@"branch_id"]];
    NSString *str = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    operation1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"%@",dictionary1);
        if ([[dictionary1 valueForKey:@"status"] isEqualToString:@"YES"] ) {
            
            
            
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
@end
