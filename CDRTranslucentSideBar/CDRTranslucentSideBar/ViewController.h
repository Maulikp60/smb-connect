//
//  ViewController.h
//  SmartSchool
//
//  Created by Qutub Kothari on 7/8/14.
//  Copyright (c) 2014 SAK Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "TLAlertView.h"


@interface ViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *txtUsername,*txtPassword;
    IBOutlet UIButton *objTrobleLogin;
    IBOutlet UITextField *txtContactNo;
    NSString *str;
    IBOutlet UITextField *txtForgot;
    IBOutlet UIView *FogotView;
}
-(IBAction)btnLogin:(id)sender;
-(IBAction)btnSubmit:(id)sender;
- (IBAction)btnTrobleL:(id)sender;
- (IBAction)btncancel:(id)sender;

@end
