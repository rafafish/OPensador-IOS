//
//  Frases.m
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Frase.h"


@implementation Frase

@synthesize IdFrase,IdAutor,TxtFrase;

-(id)initWithFrase:(NSString *)pTxtFrase :(int)pIdAutor :(int)pIdFrase{
    self.IdFrase = pIdFrase;
	self.IdAutor = pIdAutor;
	self.TxtFrase = pTxtFrase; 
	return self;
}

@end
