//
//  OPensadorAppDelegate.h
//  OPensador
//
//  Created by rafafish on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> // Import the SQLite database framework


@interface OPensadorAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {

    UIWindow *window;
//    UINavigationController *navigationController;
    UITabBarController *tabBarController;
    
    // Database variables
	NSString *databaseName;
	NSString *databasePath;
    
    NSMutableArray *FrasesBusca;
    NSMutableArray *Autores;
 	NSMutableArray *FrasesDoAutor;
    NSMutableArray *AllFrases;

    NSString *palavraBusca;
    NSInteger AutorID;
    NSInteger IndiceFraseDoAutor;
    NSInteger IndiceFraseBusca;
    NSInteger InicioPaginaNumPag;
    NSInteger AutorPaginaNumPag;
    NSInteger BuscaPaginaNumPag;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray *FrasesDoAutor;
@property (nonatomic, retain) NSMutableArray *Autores;
@property (nonatomic, retain) NSMutableArray *AllFrases;
@property (nonatomic, retain) NSMutableArray *FrasesBusca;
//@property (nonatomic, retain) IBOutlet UINavigationController *viewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, assign) NSInteger AutorID;
@property (nonatomic, assign) NSInteger IndiceFraseDoAutor;
@property (nonatomic, retain) NSString *palavraBusca;
@property (nonatomic, assign) NSInteger IndiceFraseBusca;
@property (nonatomic, assign) NSInteger InicioPaginaNumPag;
@property (nonatomic, assign) NSInteger AutorPaginaNumPag;
@property (nonatomic, assign) NSInteger BuscaPaginaNumPag;

-(void) checkAndCreateDatabase;
-(void) LeTodasFrasesDoDatabase;
-(void) LeAutoresDoDatabase;
@end
