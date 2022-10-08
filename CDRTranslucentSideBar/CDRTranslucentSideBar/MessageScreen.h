//
//  MessageScreen.h
//  AlmanAppNew
//
//  Created by SMB-Mobile01 on 2/13/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface MessageScreen : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,kDropDownListViewDelegate>{
    
    IBOutlet UIButton *btnObjTrasparent;
    IBOutlet UILabel *lblDateDisplay;
    IBOutlet UIView *viewReadMore;
    IBOutlet UIView *view1;
    IBOutlet UITextField *txtSearch;
    IBOutlet UITableView *tblGeneralMessage;
    IBOutlet UIButton *btnObjGeneral;
    UITableViewCell *cell;
    IBOutlet UIButton *btnObjHomework;
    IBOutlet UIButton *btnObjTeacher;
    IBOutlet UITextView *tvDescription;
    IBOutlet UITextView *tvTitle;
    NSMutableDictionary *dictionary,*dictionary1;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    DropDownListView * Dropobj;
    IBOutlet UIWebView *web1;
    IBOutlet UIView *viewwebview;
    
    IBOutlet UILabel *lbltitle;
    IBOutlet UIButton *btnname;
    
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedtoggle:(id)sender;
- (IBAction)btnClickedGeneral:(id)sender;
- (IBAction)btnClickedTeacher:(id)sender;
- (IBAction)btnClickedHomework:(id)sender;
- (IBAction)btnClickedTrasparent:(id)sender;
- (IBAction)btnClickedClose:(id)sender;
- (IBAction)btnwebviewclose:(id)sender;
- (IBAction)btnclkdownload:(id)sender;
- (IBAction)btnclknextview:(id)sender;
@end
