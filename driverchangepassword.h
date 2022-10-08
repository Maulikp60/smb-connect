//
//  driverchangepassword.h
//  SmbConnect
//
//  Created by apple on 28/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface driverchangepassword : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate>
{
    
    IBOutlet UITextField *txtConfirmPass;
    IBOutlet UITextField *txtNewPass;
    IBOutlet UITextField *txtOldPass;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIButton *btnObjMenu;
    IBOutlet UIView *view3;
    DropDownListView * Dropobj;
}

- (IBAction)btnClickedSUBMIT:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;

@end
