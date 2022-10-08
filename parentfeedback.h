//
//  parentfeedback.h
//  CDRTranslucentSideBar
//
//  Created by apple on 23/02/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@interface parentfeedback : UIViewController<UITextViewDelegate,kDropDownListViewDelegate>{
    
    IBOutlet UITextView *tvFeedbackHere;
    IBOutlet UITextField *txtFeedbackType;
    DropDownListView * Dropobj;
    int i;
}
- (IBAction)btnClickedFeedbackType:(id)sender;
- (IBAction)btnClickedSubmit:(id)sender;
- (IBAction)btnClickedBack:(id)sender;

@end
