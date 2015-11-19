//
//  JSONPath.h
//  JsonTesting
//
//  Created by Anatoliy Dalekorey on 10/15/15.
//  Copyright © 2015 Anatoliy Dalekorey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONPath : NSObject

- (id)valueAtPath:(NSString *)path inJSON:(id)jsonObject error:(NSError **)error;

@end
