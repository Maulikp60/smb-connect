//
//  parentImagegallery.h
//  CDRTranslucentSideBar
//
//  Created by apple on 24/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface parentImagegallery : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,kDropDownListViewDelegate>
{
    DropDownListView * Dropobj;
    
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *view1;
    IBOutlet UIButton *btnObjToggle;
    NSMutableDictionary *dictionary1;
}
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
@end
