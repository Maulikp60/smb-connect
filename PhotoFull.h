//
//  PhotoFull.h
//  CDRTranslucentSideBar
//
//  Created by SMB-Mobile01 on 3/7/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoFull : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UILabel *lblPhotoTitle;
    IBOutlet UITableView *tblPhotoFull;
}
- (IBAction)btnClickedBack:(id)sender;


@end
