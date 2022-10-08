//
//  sendclassroommessage.h
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendclassroommessage : UIViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{
     NSMutableDictionary *dictionary1;
    UITableViewCell *cell;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UITableView *tblSendMessage;
    IBOutlet UITextView *tvSendMessage;
    IBOutlet UIView *view3;
    IBOutlet UIButton *btnObjToggle;
}

- (IBAction)btnClickedSend:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;

@end
