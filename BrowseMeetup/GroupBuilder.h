//
//  GroupBuilder.h
//  BrowseMeetup
//
//  Created by Alexander Kuliev on 10/31/14.
//  Copyright (c) 2014 Alexander Kuliev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuilder : NSObject

+(NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
