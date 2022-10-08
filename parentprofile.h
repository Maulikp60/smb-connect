//
//  parentprofile.h
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Singleton.h"
#import "AFNetworking.h"

@interface parentprofile : UIViewController<UITextFieldDelegate>{
    
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtDesignation;
    IBOutlet UITextField *txtCity;
    IBOutlet UITextField *txtAddress;
    IBOutlet UITextField *txtName;
}
- (IBAction)btnClickedUpdate:(id)sender;
- (IBAction)btnClickedBack:(id)sender;

@end
