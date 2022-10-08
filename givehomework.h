//
//  givehomework.h
//  SmbConnect
//
//  Created by apple on 04/05/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "IQActionSheetPickerView.h"

@interface givehomework : UIViewController<UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate,IQActionSheetPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    IBOutlet UITextField *txtclassname;
    DropDownListView * Dropobj;
    IBOutlet UITextField *txttopicname;
    IBOutlet UITextField *txtsubjectname;
    IBOutlet UITextField *txtdivisionname;
    UIImage *chosenImage;
    IBOutlet UITextField *txtsubmissiondate;
    IBOutlet UITextField *txtattachment;
    IBOutlet UITextView *txtdescription;
    NSMutableDictionary *dictionary1;
}
- (IBAction)btnback:(id)sender;
- (IBAction)btnselectclass:(id)sender;
- (IBAction)btnselectdivision:(id)sender;
- (IBAction)btnslectsubject:(id)sender;
- (IBAction)btnbrowse:(id)sender;
- (IBAction)btnselectdate:(id)sender;
- (IBAction)btnsubmit:(id)sender;

@end
