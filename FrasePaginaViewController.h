//
//  FrasePaginaViewController.h
//  OPensador
//
//  Created by mac on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FrasePaginaViewController : UIViewController {
    IBOutlet UITextView *FraseTextView;
    int pageNumber;
}

@property (nonatomic, retain) UITextView *FraseTextView;

- (id)initWithPageNumber:(int)page;

@end
