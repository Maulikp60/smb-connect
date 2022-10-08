//
//  parentcontactus.h
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "DropDownListView.h"

@interface parentcontactus : UIViewController<UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate,MFMailComposeViewControllerDelegate>{
    
    IBOutlet UITableView *tblContacUs;
    IBOutlet UITextField *txtSelectSchool;
    DropDownListView * Dropobj;
    NSMutableArray *cmp_id;
    int i;
}
- (IBAction)BtnClickedSelectSchool:(id)sender;
- (IBAction)btnClickedBack:(id)sender;


@end
