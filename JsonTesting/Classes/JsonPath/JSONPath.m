//
//  JSONPath.m
//  JsonTesting
//
//  Created by Anatoliy Dalekorey on 10/15/15.
//  Copyright © 2015 Anatoliy Dalekorey. All rights reserved.
//

#import "JSONPath.h"

@interface JSONPath ()

@property (strong, nonatomic) NSDictionary *json;

@end

@implementation JSONPath

#pragma mark - Public Metods

- (id)valueAtPath:(NSString *)path inJSON:(id)jsonObject error:(NSError **)error
{
    if (!path) {
        *error = [[NSError alloc] initWithDomain:@"thinkmobiles.com" code:-10 userInfo:@{NSLocalizedDescriptionKey : @"Path is nil"}];
        return nil;
    }
    if (!path.length) {
        *error = [[NSError alloc] initWithDomain:@"thinkmobiles.com" code:-11 userInfo:@{NSLocalizedDescriptionKey : @"Path is empty"}];
        return nil;
    }
    if (!jsonObject) {
        *error = [[NSError alloc] initWithDomain:@"thinkmobiles.com" code:-12 userInfo:@{NSLocalizedDescriptionKey : @"JSONObject is nil"}];
        return nil;
    }
    if ([jsonObject isKindOfClass:[NSDictionary class]] || [jsonObject isKindOfClass:[NSArray class]]) {
        NSArray *keys = [path componentsSeparatedByString:@"."];
        id returnObject = [jsonObject copy];
        for (id key in keys) {
            returnObject = [self getObjectFromObject:returnObject forKey:key];
        }
        if (!returnObject) {
            *error = [[NSError alloc] initWithDomain:@"thinkmobiles.com" code:-13 userInfo:@{NSLocalizedDescriptionKey : @"For this path don't exist object"}];
        }
        return returnObject;
    } else {
        *error = [[NSError alloc] initWithDomain:@"thinkmobiles.com" code:-14 userInfo:@{NSLocalizedDescriptionKey : @"Object is't JSON object"}];
        return nil;
    }
}

#pragma mark - Private Metods

- (id)getObjectFromObject:(id)rootObject forKey:(NSString *)key
{
    if ([rootObject isKindOfClass:[NSArray class]]) {
        return rootObject[[key integerValue]];
    } else if ([rootObject isKindOfClass:[NSDictionary class]]) {
        return [rootObject objectForKey:key];
    }
    return nil;
}

@end
