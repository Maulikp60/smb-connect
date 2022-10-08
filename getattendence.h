//
//  getattendence.h
//  SmbConnect
//
//  Created by apple on 23/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"

@interface getattendence : UIViewController<UITableViewDataSource,UITableViewDelegate,IQActionSheetPickerViewDelegate>
{
    
    IBOutlet UITextField *txtdate;
    IBOutlet UITableView *tblobj;
    IBOutlet UITableView *tblProfile;
    UITableViewCell *cell;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *view3;
    IBOutlet UIButton *btnObjToggle;
    NSMutableDictionary *dictionary1;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btntakeattnedance:(id)sender;
- (IBAction)btndate:(id)sender;

@end
