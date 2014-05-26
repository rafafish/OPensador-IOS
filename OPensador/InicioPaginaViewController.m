//
//  InicioPaginaViewController.m
//  OPensador
//
//  Created by mac on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InicioPaginaViewController.h"
#import "OPensadorAppDelegate.h"
#import "Frase.h"
#import "Autor.h"


@implementation InicioPaginaViewController

@synthesize FraseTextView;


// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self == [super initWithNibName:@"InicioPaginaViewController" bundle:nil]) {
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
    
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"transparent"]];
    self.view.backgroundColor = [UIColor clearColor];
    self.FraseTextView.backgroundColor = [UIColor clearColor];
  //  [background release];
    
    
     OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Frase *tFrase = (Frase *)[appDelegate.AllFrases objectAtIndex:pageNumber];
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
