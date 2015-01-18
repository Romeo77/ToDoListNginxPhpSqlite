//
//  BaseViewController.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 16.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


@implementation BaseTableViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end