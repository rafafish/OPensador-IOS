//
//  AutoresViewController.h
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverlayViewController;

@interface AutoresViewController : UITableViewController {
    
    AutoresViewController *AutoresView;

  	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	IBOutlet UISearchBar *searchBar;
    BOOL searching;
    BOOL letUserSelectRow;
    NSMutableArray *copyListOfItems;
	OverlayViewController *ovController;
}


@property(nonatomic, retain) AutoresViewController *AutoresView;

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@end
