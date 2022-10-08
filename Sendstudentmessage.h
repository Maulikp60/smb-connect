//
//  Sendstudentmessage.h
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sendstudentmessage : UIViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableViewCell *cell;
    IBOutlet UIView *view3;
    IBOutlet UITableView *tblPopupStudentmessage;
    IBOutlet UIButton *btnObjSend;
    IBOutlet UITableView *tblStudentMessage;
    IBOutlet UITextView *tvStudentMessage;
    IBOutlet UIView *viewStudentMessage;
    NSMutableDictionary *dictionary1;
    int i;
    IBOutlet UIImageView *imgPlan;
    IBOutlet UILabel *lblObjMessage;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIView *viewPopupProfile;
    
    IBOutlet UILabel *lblcount;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedSend:(id)sender;
- (IBAction)btnClickedPopupSend:(id)sender;

@end
