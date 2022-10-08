//
//  TeacherDashboard.h
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherDashboard : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjClassAssign;
    IBOutlet UIButton *btnObjClassMessage;
    IBOutlet UIButton *btnObjAttendance;
    IBOutlet UIButton *btnObjStudentMesage;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIButton *btnObjMenu;
    IBOutlet UIView *view3;
    NSMutableDictionary *dictionary1;
    IBOutlet UILabel *lblCount;
    
    IBOutlet UILabel *lblteachercount;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClassRoomMessage:(id)sender;
- (IBAction)btnStudentMessage:(id)sender;
- (IBAction)btnClassAssignment:(id)sender;
- (IBAction)btnMarkAttendance:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedGeneral:(id)sender;
- (IBAction)btnteachermsg:(id)sender;

@end
