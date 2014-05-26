//
//  OverlayViewController.h
//  TableView
//
//  Created by iPhone SDK Articles on 1/17/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import <UIKit/UIKit.h>

@class AutoresViewController;

@interface OverlayViewController : UIViewController {

    AutoresViewController *rvController;
}

@property (nonatomic, retain) AutoresViewController *rvController;

@end
