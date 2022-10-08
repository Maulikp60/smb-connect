//
//  custom.h
//  SmartSchool
//
//  Created by apple on 15/08/14.
//  Copyright (c) 2014 SAK Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface custom : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblNo;
@property (strong, nonatomic) IBOutlet UILabel *lblAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblPending;
@property (strong, nonatomic) IBOutlet UILabel *lblStudentName;
@property (strong, nonatomic) IBOutlet UILabel *lblStudentStd;
@property (strong, nonatomic) IBOutlet UILabel *lblSchoolName;
@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UILabel *lblexams;
@property (strong, nonatomic) IBOutlet UILabel *lbltotalmarks;
@property (strong, nonatomic) IBOutlet UILabel *lblnamebackgroundcolor;
@property (strong, nonatomic) IBOutlet UILabel *lblcellbackgroundcolor;
@property (strong, nonatomic) IBOutlet UILabel *lblcount;
@property (strong, nonatomic) IBOutlet UILabel *lblParentName;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lbla;
@property (strong, nonatomic) IBOutlet UILabel *lblb;
@property (strong, nonatomic) IBOutlet UILabel *lblc;
@property (strong, nonatomic) IBOutlet UILabel *lblsubject;
@property (strong, nonatomic) IBOutlet UILabel *lbltopic;
@property (strong, nonatomic) IBOutlet UILabel *lblclass;
@property (strong, nonatomic) IBOutlet UILabel *lbldate;
@property (strong, nonatomic) IBOutlet UILabel *lblstatus;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIImageView *imgteacher;

@property (strong, nonatomic) IBOutlet UIButton *btnremark;
@property (strong, nonatomic) IBOutlet UIButton *btndelete;
@property (strong, nonatomic) IBOutlet UIButton *btnReadMore;
@property (strong, nonatomic) IBOutlet UIButton *btnObjCheck;
@property (strong, nonatomic) IBOutlet UIButton *btnObjEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnObjPhone;

@end
