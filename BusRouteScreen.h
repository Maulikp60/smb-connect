//
//  BusRouteScreen.h
//  SmbConnect
//
//  Created by apple on 10/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BusRouteScreen : UIViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UIView *view3;
    IBOutlet MKMapView *mapview1;
    NSMutableDictionary *dic,*dictionary1;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIButton *btnObjMenu;
    
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;


@end
