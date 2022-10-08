//
//  parentvideocallery.h
//  CDRTranslucentSideBar
//
//  Created by apple on 24/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface parentvideocallery : UIViewController<UITableViewDelegate,UITableViewDataSource,kDropDownListViewDelegate>
{
    IBOutlet UIView *view1;
    
    IBOutlet UIView *viewwebview;
    IBOutlet UITableView *tblobj;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    DropDownListView * Dropobj;
    UITableViewCell *cell;

    IBOutlet UIWebView *web1;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnclose:(id)sender;

@end
