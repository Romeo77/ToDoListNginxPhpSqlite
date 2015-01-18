//
//  AppDelegate.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 12.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak, readonly) UIStoryboard *storyboard;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:notificationLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:notificationLogout object:
     nil];
    return YES;
}

- (id) createTodoNavVc { return [self.storyboard instantiateViewControllerWithIdentifier:@"todoNav"]; }

- (void) userDidLogin {
    [self setNewRootVc:[self createTodoNavVc] animated:YES];
}

- (void) userDidLogout {
    [self setNewRootVc:[self.storyboard instantiateInitialViewController] animated:YES];
}

- (void) setNewRootVc:(UIViewController *) newVc animated:(BOOL) animated
{
    if (!animated) {
        self.window.rootViewController = newVc;
        return;
    }
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:newVc.view
                      duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    completion:^(BOOL finished)
     {
         if (!finished) return;
         self.window.rootViewController = newVc;
     }];
}

- (UIStoryboard *)storyboard {
    return self.window.rootViewController.storyboard;
}


@end
