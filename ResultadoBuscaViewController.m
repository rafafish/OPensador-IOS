//
//  ResultadoBuscaViewController.m
//  OPensador
//
//  Created by mac on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultadoBuscaViewController.h"
#import "OPensadorAppDelegate.h"
#import "Frase.h"
#import "ResultadoFraseViewController.h"

static sqlite3_stmt *detailStmt = nil;

@implementation ResultadoBuscaViewController


-(void) BuscaFraseNoDatabase {
    
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
	appDelegate.FrasesBusca = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		
        //If the detail view is hydrated then do not get it from the database.
        if(detailStmt == nil) {
            const char *sql = "Select * from Frases Where FraseTxt like ?001";
            if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
                NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
        }

      appDelegate.palavraBusca = [NSString stringWithFormat:@" %@", appDelegate.palavraBusca];        
        
     //   NSLog(@"palavraBusca: %@",appDelegate.palavraBusca);
        NSString *searchInput = [NSString stringWithFormat:@"%%%@%%", appDelegate.palavraBusca];
        sqlite3_bind_text(detailStmt, 1, [searchInput UTF8String],-1,SQLITE_TRANSIENT);        
		while(sqlite3_step(detailStmt) == SQLITE_ROW) {
            // Read the data from the result row
            NSInteger sIdFrase = sqlite3_column_int(detailStmt, 0);
            NSInteger sIdAutor = sqlite3_column_int(detailStmt, 1);
            NSString *sTxtFrase = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 2)];
            
            // Create a new animal object with the data from the database
            Frase *tFrase = [[Frase alloc] initWithFrase:sTxtFrase:sIdAutor:sIdFrase];
            
            // Add the animal object to the animals Array
            [appDelegate.FrasesBusca addObject:tFrase];
            
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
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    self.view.backgroundColor = [UIColor clearColor];    
    
    
    [super viewDidLoad];
    [self BuscaFraseNoDatabase];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDelegate.FrasesBusca.count;
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

   // NSLog(@"FraseBuscaCount: %@", [NSString stringWithFormat:@"%i", appDelegate.FrasesBusca.count]);  

    
    Frase *tFrase = (Frase *)[appDelegate.FrasesBusca objectAtIndex:indexPath.row];
	

    
    
	cell.textLabel.text = [tFrase TxtFrase];
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
    ResultadoFraseViewController * viewController = [[ResultadoFraseViewController alloc] initWithNibName:@"ResultadoFraseViewController" bundle:nil];
    self.title =@"Frases encontradas";
    
    OPensadorAppDelegate *appDelegate = (OPensadorAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.IndiceFraseBusca = indexPath.row;
    [self.navigationController pushViewController:viewController animated:YES]; 
    [viewController release];
}

@end
