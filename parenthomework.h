//
//  parenthomework.h
//  SmbConnect
//
//  Created by SMB-Mobile01 on 3/25/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface parenthomework : UIViewController<UITableViewDelegate,UITableViewDataSource,kDropDownListViewDelegate>
{
    IBOutlet UIView *view1;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    DropDownListView * Dropobj;
    UITableViewCell *cell;
    IBOutlet UITableView *tblobj;
    NSMutableDictionary *dictionary1;
    IBOutlet UITextField *txtSearch;
    IBOutlet UIButton *btnobjhomework;
    IBOutlet UIView *viewwebview;
    IBOutlet UIWebView *web1;
    IBOutlet UIView *viewReadMore;
    IBOutlet UIButton *btnobjmark;
    IBOutlet UIButton *btnobjnextview;
    IBOutlet UITextView *txtdescription;
    IBOutlet UILabel *lbltitle;
    IBOutlet UILabel *lblsubj;
    
    IBOutlet UILabel *lblsettilte;
    IBOutlet UILabel *lbldate;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnhomework:(id)sender;
- (IBAction)btnClickedClose:(id)sender;
- (IBAction)btnwebviewclose:(id)sender;
- (IBAction)btnclknextview:(id)sender;
- (IBAction)btnmark:(id)sender;
- (IBAction)btndownload:(id)sender;

@end
