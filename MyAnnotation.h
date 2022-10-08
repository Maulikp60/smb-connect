//
//  MyAnnotation.h
//  SmartSchool
//
//  Created by Qutub Kothari on 7/16/14.
//  Copyright (c) 2014 SAK Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>{
    
    CLLocationCoordinate2D coordinate;
    
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
