//
//  UIMessagesHelper.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 15.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "UIMessagesHelper.h"

@implementation UIMessagesHelper

+ (void) showMessage:(NSString *) message {
    [[[UIAlertView alloc] initWithTitle:@"Hey" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
@end
