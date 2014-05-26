//
//  InicioFraseViewController.h
//  OPensador
//
//  Created by mac on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InicioFraseViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
    NSInteger NumPaginas;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, assign) NSInteger NumPaginas;

- (IBAction)changePage:(id)sender;
- (IBAction)Twittar:(id)sender;
- (IBAction)fb:(id)sender;
- (IBAction)copiar:(id)sender;
- (IBAction)email:(id)sender;

@end
