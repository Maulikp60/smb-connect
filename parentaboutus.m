//
//  parentaboutus.m
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import "parentaboutus.h"

@interface parentaboutus ()

@end

@implementation parentaboutus

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)btnClickedBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}
@end
