//
//  FeesScreen.h
//  CDRTranslucentSideBar
//
//  Created by apple on 17/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"


@interface FeesScreen : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate>{
    
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *view1;
    IBOutlet UILabel *lblTotalDueAmount1;
    IBOutlet UITableView *tblFeesInstallment;
    IBOutlet UITableView *tblFeesPaymentHistory;
    IBOutlet UILabel *lblTotalDueAmount;
    IBOutlet UIView *ViewNextIstallment;
    IBOutlet UIScrollView *scrFees;
     UITableViewCell *cell;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIView *viewPopupProfile;
    NSMutableDictionary *dictionary1;
    DropDownListView * Dropobj;
    IBOutlet UILabel *lbldate;
    IBOutlet UILabel *lblfees;
    
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;

@end
