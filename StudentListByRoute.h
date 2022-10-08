//
//  StudentListByRoute.h
//  SmbConnect
//
//  Created by apple on 10/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"

@interface StudentListByRoute : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate>{
    
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjDrop;
    IBOutlet UIImageView *imgDrop;
    IBOutlet UITableView *tblSee;
    IBOutlet UIView *viewSelectRoute;
    IBOutlet UITextField *txtRoute;
    IBOutlet UITableView *tblListRoute;
    IBOutlet UIView *view3;
    UITableViewCell *cell;
    NSDictionary *dictionary1;
    int i;
    IBOutlet UIButton *btnObjToggle;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedRoute:(id)sender;

@end
