//
//  homeworkstatus.h
//  SmbConnect
//
//  Created by apple on 04/05/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface homeworkstatus : UIViewController<UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate>
{
     DropDownListView * Dropobj;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *view1;
    IBOutlet UIButton *btnObjToggle;
    NSMutableDictionary *dictionary1;
    UITableViewCell *cell;

    IBOutlet UITableView *tblobj;
}

- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnassign:(id)sender;

@end
