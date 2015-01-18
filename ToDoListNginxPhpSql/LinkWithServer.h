//
//  LinkWithServer.h
//  ToDoListNginxPhpSql
//
//  Created by Roman on 17.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkWithServer : NSObject
+ (void)linkWithServerRegistration:(NSString*)login :(NSString*)password :(NSString*)method;
+ (NSDictionary*)linkWithServerTodos:(NSString*)httpMethod :(NSString*)value :(NSString*)update;
@end
