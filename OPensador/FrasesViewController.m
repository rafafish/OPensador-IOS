//
//  FrasesViewController.m
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FrasesViewController.h"
#import "OPensadorAppDelegate.h"
#import "Frase.h"
#import "Autor.h"
#import "AutoresViewController.h"
#import "FrasesDoAutorViewController.h"
#import "FrasePaginaViewController.h"

static sqlite3_stmt *detailStmt = nil;

@implementation FrasesViewController

@synthesize FrasesView;


-(void) LeFrasesDoDatabase {
    
    // Setup some globals
	databaseName = @"db_frases.sqlite";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];    
	// Setup the database object
	sqlite3 *database;
	
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
	// Init  animals Array
	appDelegate.FrasesDoAutor = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		
        //If the detail view is hydrated then do not get it from the database.
        if(detailStmt == nil) {
            const char *sql = "Select * from Frases Where IdAutor = ?";
            if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
                NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
        }
        
        OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        sqlite3_bind_int(detailStmt, 1, appDelegate.AutorID);        
		while(sqlite3_step(detailStmt) == SQLITE_ROW) {
				// Read the data from the result row
				NSInteger sIdFrase = sqlite3_column_int(detailStmt, 0);
                NSInteger sIdAutor = sqlite3_column_int(detailStmt, 1);
				NSString *sTxtFrase = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 2)];
				
				// Create a new animal object with the data from the database
				Frase *tFrase = [[Frase alloc] initWithFrase:sTxtFrase:sIdAutor:sIdFrase];
				
				// Add the animal object to the animals Array
				[appDelegate.FrasesDoAutor addObject:tFrase];
				
				[tFrase release];
			}
		}
		// Release the compiled statement from memory
			sqlite3_reset(detailStmt);
		sqlite3_close(database);

}
	


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [super viewDidLoad];
    
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    self.view.backgroundColor = [UIColor clearColor];

    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];    
    
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:appDelegate.AutorID-1];    
    
    //Set the title
    self.navigationItem.title = [tAutor NomeAutor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;     
    
    [self LeFrasesDoDatabase];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDelegate.FrasesDoAutor.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
        OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    Frase *tFrase = (Frase *)[appDelegate.FrasesDoAutor objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [tFrase TxtFrase];
    
    cell.textLabel.font = [UIFont fontWithName:@"American Typewriter" size:17.0];     
    
	return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FrasesDoAutorViewController * viewController = [[FrasesDoAutorViewController alloc] initWithNibName:@"FrasesDoAutorViewController" bundle:nil];
    
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];    
    
    Autor *tAutor = (Autor *)[appDelegate.Autores objectAtIndex:appDelegate.AutorID-1];
    self.title = [tAutor NomeAutor];
    
    
    appDelegate.IndiceFraseDoAutor = indexPath.row;
  

    [self.navigationController pushViewController:viewController animated:YES]; 
    [viewController release];
}

@end
