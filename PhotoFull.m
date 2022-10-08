//
//  PhotoFull.m
//  CDRTranslucentSideBar
//
//  Created by SMB-Mobile01 on 3/7/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "PhotoFull.h"
#import "Singleton.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "custom.h"
#import "ViewController.h"
#import "TLAlertView.h"
@interface PhotoFull (){
    NSMutableArray *arrGallery_id,*arrUrl,*arrName;
    NSUserDefaults *prefs;
}

@end

@implementation PhotoFull

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
   prefs = [NSUserDefaults standardUserDefaults];
   lblPhotoTitle.text=[prefs stringForKey:@"gallery_title"];
    [self GalleryList];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrGallery_id.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *MyIdentifier = @"Cell";
    custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (ce == nil)
    {
        ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
    }
     ce.img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrUrl objectAtIndex:indexPath.row]]]];
    ce.lblname.text=[arrName objectAtIndex:indexPath.row];
    return ce;
}
-(void)GalleryList
{
    arrGallery_id=[[NSMutableArray alloc]init];
    arrUrl=[[NSMutableArray alloc]init];
    arrName=[[NSMutableArray alloc]init];
    [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@GalleryImageList.php?branch_id=%@&cat_id=%@",[[Singleton sharedSingleton] getBaseURL],[prefs objectForKey:@"branch_id"],[prefs objectForKey:@"gallery_id"]];
    
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
                [arrGallery_id addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"gallery_id"]]];
                [arrUrl addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"url"]]];
                [arrName addObject:[NSString stringWithFormat:@"%@",[[[dictionary1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"name"]]];

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
        [tblPhotoFull reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClickedBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}
@end
