//
//  BuscaViewController.h
//  OPensador
//
//  Created by mac on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuscaViewController : UIViewController<UITextFieldDelegate> {
    
    IBOutlet UITextField *txtBusca;
    
}

@property (nonatomic, retain) IBOutlet UITextField *txtBusca;
-(IBAction)Buscar:(id)sender;
- (IBAction)Limpar:(id)sender;

@end
