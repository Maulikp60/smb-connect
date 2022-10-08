//
//  parentlocatebus.h
//  SmbConnect
//
//  Created by apple on 24/03/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MapKit.h>

@interface parentlocatebus : UIViewController<UITableViewDelegate,UITableViewDataSource,kDropDownListViewDelegate,MKMapViewDelegate>

{
    IBOutlet UITableView *tblsetmap;
    IBOutlet UITextField *selectmap;
    IBOutlet UIView *view1;
    IBOutlet UIButton *btnObjToggle;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewPopupProfile;
    DropDownListView * Dropobj;
    UITableViewCell *cell;

}
- (IBAction)btnselectmap:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
