//
//  DataClass.h
//  ToDoListNginxPhpSql
//
//  Created by Roman on 16.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject {
    
    NSString *str;
}

@property(nonatomic,retain)NSString *str;
+(DataClass*)getInstance;
@end
