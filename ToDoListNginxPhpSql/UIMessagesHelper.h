//
//  UIMessagesHelper.h
//  ToDoListNginxPhpSql
//
//  Created by Roman on 15.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIMessagesHelper : NSObject
+ (void) showMessage:(NSString *) message;
@end

#define UIMsg(x) { [UIMessagesHelper showMessage:(x)]; }