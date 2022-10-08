//
//  parentattendencesheet.h
//  SmbConnect
//
//  Created by apple on 09/04/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "XYPieChart.h"

@interface parentattendencesheet : UIViewController<UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate,XYPieChartDelegate, XYPieChartDataSource>

{
    IBOutlet UIButton *btnname;
    IBOutlet UIView *viewPopupProfile;
    IBOutlet UIView *view1;
    IBOutlet UIButton *btnObjToggle;
    UITableViewCell *cell;
    NSMutableDictionary *dictionary1;
    DropDownListView * Dropobj;
    IBOutlet UITableView *tblProfile;
    
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedToggle:(id)sender;
- (IBAction)btnleve:(id)sender;
@property (strong, nonatomic) IBOutlet XYPieChart *pieChartRight;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@end


