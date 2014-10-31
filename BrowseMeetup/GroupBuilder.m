//
//  GroupBuilder.m
//  BrowseMeetup
//
//  Created by Alexander Kuliev on 10/31/14.
//  Copyright (c) 2014 Alexander Kuliev. All rights reserved.
//

#import "GroupBuilder.h"
#import "Group.h"

@implementation GroupBuilder

+(NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *groups = [NSMutableArray new];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        Group *group = [Group new];
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [groups addObject:group];
    }
    
    return groups;
}

@end
