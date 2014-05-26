//
//  InicioFraseViewController.m
//  OPensador
//
//  Created by mac on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InicioFraseViewController.h"
#import "OPensadorAppDelegate.h"
#import "InicioPaginaViewController.h"
#import "SHKTwitter.h"
#import "SHKFacebook.h"
#import "AutoresViewController.h"
#import "Frase.h"
#import "Autor.h"
#import "SHKMail.h"

@implementation InicioFraseViewController

@synthesize NumPaginas, scrollView, pageControl, viewControllers;


- (IBAction)email:(id)sender{
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Frase *tFrase = (Frase *)[appDelegate.AllFrases objectAtIndex: appDelegate.InicioPaginaNumPag];
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:[tFrase IdAutor]-1];
    
    NSString *txt = [NSString stringWithFormat:@"%@ (%@)", [tFrase TxtFrase],[tAutor NomeAutor]];
    NSString *subject = [NSString stringWithFormat:@"Frase de (%@)", [tAutor NomeAutor]];
    
    [SHK setRootViewController:self];
    SHKItem *item = [SHKItem text:txt];
    item.title = subject;    
    [SHKMail shareItem:item];
}

- (IBAction)copiar:(id)sender{
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Frase *tFrase = (Frase *)[appDelegate.AllFrases objectAtIndex: appDelegate.InicioPaginaNumPag];
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:[tFrase IdAutor]-1];
    
    [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@ (%@)", [tFrase TxtFrase],[tAutor NomeAutor]];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"A frase foi copiada!" 
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}


- (IBAction)fb:(id)sender{
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Frase *tFrase = (Frase *)[appDelegate.AllFrases objectAtIndex: appDelegate.InicioPaginaNumPag];
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:[tFrase IdAutor]-1];
    
    NSString *txt = [NSString stringWithFormat:@"%@ (%@)", [tFrase TxtFrase],[tAutor NomeAutor]];
    
    [SHK setRootViewController:self];
    SHKItem *item = [SHKItem text:txt];
    [SHKFacebook shareItem:item];
}

-(IBAction)Twittar:(id)sender{
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Frase *tFrase = (Frase *)[appDelegate.AllFrases objectAtIndex: appDelegate.InicioPaginaNumPag];
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:[tFrase IdAutor]-1];
    
    NSString *txt = [NSString stringWithFormat:@"%@ (%@)", [tFrase TxtFrase],[tAutor NomeAutor]];
    
    [SHK setRootViewController:self];
    SHKItem *item = [SHKItem text:txt];
    [SHKTwitter shareItem:item];    
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= NumPaginas) return;
	
    // replace the placeholder if necessary
    InicioFraseViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[InicioPaginaViewController alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
//    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
 //       OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
 //       appDelegate.InicioPaginaNumPag = pageControl.currentPage + 1;
 //       return;
 //   }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    
    
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
    
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
 
    
    appDelegate.InicioPaginaNumPag = pageControl.currentPage;
  
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;       
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{    
    [viewControllers release];
    [scrollView release];
    [pageControl release];    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    //Set the title
    self.navigationItem.title = @"Frases";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;    
        
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    NumPaginas = appDelegate.AllFrases.count;
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < NumPaginas; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NumPaginas, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    scrollView.delegate = self;
	
    pageControl.numberOfPages = NumPaginas;
    
    
    
    pageControl.currentPage = appDelegate.IndiceFraseDoAutor;
    
    appDelegate.InicioPaginaNumPag = pageControl.currentPage;
    
    
    [self changePage:nil]; 
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    
//    [self loadScrollViewWithPage:0];
//    [self loadScrollViewWithPage:1];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
