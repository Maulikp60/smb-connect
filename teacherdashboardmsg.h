//
//  teacherdashboardmsg.h
//  SmbConnect
//
//  Created by apple on 26/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface teacherdashboardmsg : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

{
    
    IBOutlet UIButton *btnObjTrasparent;
    IBOutlet UILabel *lblDateDisplay;
    IBOutlet UIView *viewReadMore;
    IBOutlet UIView *view1;
    IBOutlet UITextField *txtSearch;
    IBOutlet UITableView *tblGeneralMessage;
    UITableViewCell *cell;
    IBOutlet UITextView *tvDescription;
    IBOutlet UITextView *tvTitle;
    NSMutableDictionary *dictionary,*dictionary1;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    
    IBOutlet UIButton *btnname;
    IBOutlet UIView *viewwebview;
    IBOutlet UIWebView *web1;
    
}
- (IBAction)btnwebviewclose:(id)sender;
- (IBAction)btnclkdownload:(id)sender;
- (IBAction)btnclknextview:(id)sender;

- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedtoggle:(id)sender;
- (IBAction)btnClickedTrasparent:(id)sender;
- (IBAction)btnClickedClose:(id)sender;
@end
