//
//  DataClass.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 16.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass
@synthesize str;

static DataClass *instance = nil;

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataClass new];
        }
    }
    return instance;
}
@end
