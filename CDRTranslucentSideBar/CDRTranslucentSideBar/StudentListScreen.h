//
//  StudentListScreen.h
//  CDRTranslucentSideBar
//
//  Created by apple on 19/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "MyAnnotation.h"

@interface StudentListScreen : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,kDropDownListViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate>{
    
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtSelectRoute;
    IBOutlet UITextField *txtSelectDivision;
    IBOutlet UITextField *txtSelectClass;
    IBOutlet UITextField *txtSelectSchool;
    IBOutlet UIView *viewAddStudent;
    IBOutlet UIButton *btnobjTrasparent;
    IBOutlet UIView *viewModify;
    IBOutlet UITableView *tblStudentList;
    IBOutlet UIButton *btnObjAddStudent;
    IBOutlet UILabel *lblAddEdit;
    IBOutlet UIView *view1;
    UITableViewCell *cell;
    NSMutableDictionary *dictionary,*dictionary1;
    IBOutlet UIButton *btnObjToggle;
    NSInteger fortag;
    DropDownListView * Dropobj;
    NSMutableArray *cmp_id,*classId,*divId;
    IBOutlet UITextField *txtUpdateName;
    IBOutlet UITextField *txtUpdateSelectRoute;
    IBOutlet UITextField *txtUpdateSelectDivision;
    IBOutlet UITextField *txtUpdateSelectClass;
    IBOutlet UITextField *txtUpdateSelectSchool;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *viewUpdateStudent;
    IBOutlet UITableView *tblProfile;
    IBOutlet UIView *viewlocation;
    IBOutlet UITextField *txtmapname;
}
- (IBAction)btnselctmap:(id)sender;
- (IBAction)btnmapsave:(id)sender;
- (IBAction)btnClickedClose:(id)sender;
- (IBAction)btnClickedEdit:(id)sender;
- (IBAction)btnClickedDelete:(id)sender;
- (IBAction)btnClickedTrasparent:(id)sender;
- (IBAction)btnClickedClose1:(id)sender;
- (IBAction)btnClickedSubmit:(id)sender;
- (IBAction)btnClickedAddStudent:(id)sender;
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnClickedClose2:(id)sender;
- (IBAction)btnUpdateSubmit:(id)sender;
- (IBAction)btnclkmylocation:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)zoomIn:(id)sender;
- (IBAction)changeMapType:(id)sender;
@end
