//
//  LeaveApplicationScreen.h
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"
#import "DropDownListView.h"

@interface LeaveApplicationScreen : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,IQActionSheetPickerViewDelegate,kDropDownListViewDelegate>{
    
    IBOutlet UIButton *btnname;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *view1;
    IBOutlet UITextField *txtToDate;
    IBOutlet UITextField *txtFromDate;
    IBOutlet UITextView *tvReason;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITextField *txtSelectLeaveTemplates;
    IBOutlet UITableView *tblLeaveTemplate;
    UITableViewCell *cell;
    NSMutableDictionary *dictionary1;
    DropDownListView * Dropobj;
    int i;
    IBOutlet UITableView *tblProfile;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedSubmit:(id)sender;
- (IBAction)btnClickedDate:(id)sender;
- (IBAction)btnClickedTemplates:(id)sender;
- (IBAction)btnback:(id)sender;

@end
