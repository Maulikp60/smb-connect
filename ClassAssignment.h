//
//  ClassAssignment.h
//  Alman
//
//  Created by SMB-Mobile01 on 2/26/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassAssignment : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *dictionary1;

    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UITableView *tblobj;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIView *view1;
    UITableViewCell *cell;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedSubmit:(id)sender;


@end
