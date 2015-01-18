//
//  LinkWithServer.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 17.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "LinkWithServer.h"

@implementation LinkWithServer

+ (void)linkWithServerRegistration :(NSString*)login :(NSString*)password :(NSString*)method{
    NSString *post = [NSString stringWithFormat:@"login=%@&password=%@&method=%@", login, password ,method];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://188.166.37.45/filik.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"1111" forHTTPHeaderField:@"CLIENTKEY"];
    [request setHTTPBody:postData];
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
    {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions
                              error:&error];
        NSArray* keyFromJson = [json allKeys];
        NSArray* valueFromJson = [json allValues];
        NSString* resultKeyFromJson = [keyFromJson objectAtIndex:0];
        NSString* resultValueFromJson = [valueFromJson objectAtIndex:0];
        
        if([resultKeyFromJson isEqualToString :@"error"]){
            UIMsg(resultValueFromJson)
        }else{
            DataClass *obj=[DataClass getInstance];
            obj.str= resultValueFromJson;
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationLogin object:nil];
        }
    }else{
        UIMsg(@"Error server")
    }
}

+ (NSDictionary*)linkWithServerTodos:(NSString*)httpMethod :(NSString*)value :(NSString*)update{
    DataClass *obj=[DataClass getInstance];
    NSData *postData;
    NSString *postLength ;
    if([httpMethod isEqualToString:@"POST"]){
        NSString *post = [NSString stringWithFormat:@"value=%@&update=%@", value, update];
        postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://188.166.37.45/todo.php"]];
    [request setHTTPMethod:httpMethod];
    [request setValue:obj.str forHTTPHeaderField:@"ACCESSTOKEN"];
    if([httpMethod isEqualToString:@"DELETE"] || [httpMethod isEqualToString:@"PUT"]){
        [request setValue:value forHTTPHeaderField:@"INDEX"];
        [request setValue:update forHTTPHeaderField:@"UPDATE"];
    }
    if([httpMethod isEqualToString:@"POST"])
        [request setHTTPBody:postData];
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
    {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions
                              error:&error];
        return  json;
    }else{
        UIMsg(@"Error server")
        return nil;
    }
}


@end
