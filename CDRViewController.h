//
//  CDRViewController.h
//  CDRTranslucentSideBar
//
//  Created by UetaMasamichi on 2014/06/02.
//  Copyright (c) 2014年 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface CDRViewController : UIViewController < UITableViewDataSource, UITableViewDelegate,kDropDownListViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *btnObjHomework;
    
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *gethomeworkcount;
    IBOutlet UILabel *getfeesdate;
    IBOutlet UILabel *getfeescount;
    IBOutlet UILabel *getteachercount;
    IBOutlet UILabel *getgenralcount;
    DropDownListView * Dropobj;

    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjEvents;
    IBOutlet UIButton *btnObjFees;
    IBOutlet UIButton *btnObjTeacherMessage;
    IBOutlet UIButton *btnobjGeneralMessage;
    IBOutlet UIView *view3;
    IBOutlet UIButton *btnObjToggle;
    NSMutableDictionary *dictionary1;
    int i;
}
- (IBAction)OnSideBarButtonTapped:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)clkhomework:(id)sender;
- (IBAction)btnclkevent:(id)sender;
- (IBAction)btnclkfess:(id)sender;
- (IBAction)btnclkgenral:(id)sender;
- (IBAction)btnclkteachermsg:(id)sender;
- (IBAction)headerTapped:(id)sender;

@end
