//
//  Markattendance.h
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "KxMenu.h"
#import "custom.h"

@interface Markattendance : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,kDropDownListViewDelegate>{
    
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIView *view3;
    IBOutlet UITableView *tblAttendance;
    IBOutlet UITextField *txtSelectClass;
     DropDownListView * Dropobj;
    NSMutableDictionary *dictionary1;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedSelectClass:(id)sender;
- (IBAction)btnClickedSubmit:(id)sender;

@end
