//
//  Result.h
//  CDRTranslucentSideBar
//
//  Created by apple on 24/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface Result : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,kDropDownListViewDelegate>

{
    IBOutlet UIButton *btnObjToggle;
    
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UITextField *txtSelectStudent;
    IBOutlet UITableView *tblresult;
    IBOutlet UIView *view1;
    NSMutableDictionary *dictionary1;
    DropDownListView * Dropobj;
    int i;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnclickselectstudent:(id)sender;

@end
