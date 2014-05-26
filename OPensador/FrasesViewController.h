//
//  FrasesViewController.h
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrasesViewController : UITableViewController {
    FrasesViewController *FrasesView;
    // Database variables
	NSString *databaseName;
	NSString *databasePath;
}

@property (nonatomic, retain) FrasesViewController *FrasesView;

-(void) LeFrasesDoDatabase;

@end
