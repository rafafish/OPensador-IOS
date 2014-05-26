//
//  ResultadoPaginaViewController.m
//  OPensador
//
//  Created by mac on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultadoPaginaViewController.h"
#import "OPensadorAppDelegate.h"
#import "Frase.h"
#import "Autor.h"

static NSArray *__pageControlColorList = nil;


@implementation ResultadoPaginaViewController

@synthesize FraseTextView;


// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self == [super initWithNibName:@"ResultadoPaginaViewController" bundle:nil]) {
        pageNumber = page;
    }
    return self;
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
    [FraseTextView release];
 
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
    
    self.view.backgroundColor = [UIColor clearColor];
    self.FraseTextView.backgroundColor = [UIColor clearColor];

    
 
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Frase *tFrase = (Frase *)[appDelegate.FrasesBusca objectAtIndex:pageNumber];
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:[tFrase IdAutor]-1];
    
    FraseTextView.text = [NSString stringWithFormat:@"%@ (%@)", [tFrase TxtFrase],[tAutor NomeAutor]]; 

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
