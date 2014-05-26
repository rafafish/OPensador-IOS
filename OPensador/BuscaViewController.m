//
//  BuscaViewController.m
//  OPensador
//
//  Created by mac on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BuscaViewController.h"
#import "ResultadoBuscaViewController.h"
#import "OPensadorAppDelegate.h"

@implementation BuscaViewController

@synthesize txtBusca;


- (IBAction)Limpar:(id)sender{
    txtBusca.text = NULL;
}


-(IBAction)Buscar:(id)sender{
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];   
    
    appDelegate.palavraBusca = txtBusca.text;
        NSLog(@"FraseBusca: %@", appDelegate.palavraBusca);   
    NSLog(@"FraseBusca: %@", txtBusca.text);   
    
	ResultadoBuscaViewController *viewController = [[ResultadoBuscaViewController alloc] initWithNibName:@"ResultadoBuscaViewController" bundle:nil];
	
    [self.navigationController pushViewController:viewController animated:YES];
	
	viewController.title=@"Resultado";
	[viewController release];
}

-(void) touchesBegan :(NSSet *) touches withEvent:(UIEvent *)event
{
	[txtBusca resignFirstResponder];
	[super touchesBegan:touches withEvent:event ];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textfield {
//   [txtBusca resignFirstResponder];
//   return YES;
//}

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
    
    //Set the title
    self.navigationItem.title = @"Busca";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;    
    
    self.view.backgroundColor = [UIColor clearColor];
    txtBusca.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
