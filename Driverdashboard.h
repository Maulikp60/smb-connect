//
//  Driverdashboard.h
//  SmbConnect
//
//  Created by apple on 09/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Driverdashboard : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIButton *btnObjMenu;
    IBOutlet UIView *view3;
    NSMutableDictionary *dictionary1;
    IBOutlet UILabel *lblCount;
    
    IBOutlet UILabel *lblteachercount;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedGeneral:(id)sender;
- (IBAction)btnteachermsg:(id)sender;

@end

