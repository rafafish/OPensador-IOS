//
//  OPensadorAppDelegate.h
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OPensadorViewController;

@interface OPensadorAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet OPensadorViewController *viewController;

@end
