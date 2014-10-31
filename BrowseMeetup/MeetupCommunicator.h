//
//  MeetupCommunicator.h
//  BrowseMeetup
//
//  Created by Alexander Kuliev on 10/31/14.
//  Copyright (c) 2014 Alexander Kuliev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol MeetupCommunicatorDelegate;


@interface MeetupCommunicator : NSObject

@property (weak, nonatomic) id<MeetupCommunicatorDelegate> delegate;

-(void)searchGroupsAtCoordinate:(CLLocationCoordinate2D)coordinate;

@end
