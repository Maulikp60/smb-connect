//
//  Singleton.h
//  PocketRealty
//
//  Created by TISMobile on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface Singleton : NSObject {
	
}


+ (Singleton *) sharedSingleton;
- (NSString *) getBaseURL;


@end
