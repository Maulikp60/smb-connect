//
//  DriverMessageScreen.h
//  SmbConnect
//
//  Created by apple on 10/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverMessageScreen : UIViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UITextView *tvDescription;
    IBOutlet UITextView *tvTitle;
    IBOutlet UIView *viewReadMore;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITableView *tblDriverMessage;
    IBOutlet UITextField *txtSearch;
    IBOutlet UIView *view3;
    UITableViewCell *cell;
    IBOutlet UILabel *lblDate;
    NSMutableDictionary *dictionary1;
    int i;
    
    IBOutlet UIWebView *web1;
    IBOutlet UIView *viewwebview;
    IBOutlet UIButton *btnname;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedClose:(id)sender;
- (IBAction)btnclknextview:(id)sender;
- (IBAction)btnwebviewclose:(id)sender;
- (IBAction)btnclkdownload:(id)sender;

@end
