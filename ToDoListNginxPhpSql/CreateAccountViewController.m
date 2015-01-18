//
//  CreateAccountViewController.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 12.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfLogin;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)btnCreateAccountTapped:(id)sender {
    if (!self.tfLogin.text.length) {
        UIMsg(@"You haven't written login, try again please")
        return;
    }
    else if (!self.tfPassword.text.length) {
        UIMsg(@"You haven't written password, try again please")
        return;
    }else {
        [LinkWithServer linkWithServerRegistration : self.tfLogin.text : self.tfPassword.text : @"createaccount"];
    }
}

@end
