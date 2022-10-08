//
//  parentevent.h
//  SmbConnect
//
//  Created by apple on 24/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import <EventKitUI/EventKitUI.h>

@interface parentevent : UIViewController<UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate,EKEventEditViewDelegate>
{
    DropDownListView * Dropobj;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *view1;
    IBOutlet UIButton *btnObjToggle;
    NSMutableDictionary *dictionary1;
    IBOutlet UITableView *tblobj;
    
    
    IBOutlet UITextView *tvTitle;

    IBOutlet UITextField *txtSearch;
    IBOutlet UILabel *lblStartDate;
    IBOutlet UILabel *lblEndDate;
    IBOutlet UIButton *btnNameNo;
    IBOutlet UIButton *btnNameYes;
    IBOutlet UIView *CalenderView;
    IBOutlet UIButton *btnNameOk;
    IBOutlet UILabel *lblMessage;
    IBOutlet UITextView *DescriptionView;
    IBOutlet UIButton *objbtnAttechment;
    IBOutlet UIView *viewAttechment;
    IBOutlet UIWebView *WebviewAttechment;
}
- (IBAction)btnDownload:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnAttechment:(id)sender;
- (IBAction)btnNo:(id)sender;
- (IBAction)btnOk:(id)sender;
- (IBAction)btnYes:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btncloseview:(id)sender;


@end
