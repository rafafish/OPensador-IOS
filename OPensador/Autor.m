//
//  Autor.m
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Autor.h"


@implementation Autor

@synthesize IdAutor,NomeAutor;

-(id)initWithAutor:(NSString *)pNomeAutor :(int)pIdAutor{
	self.IdAutor = pIdAutor;
	self.NomeAutor = pNomeAutor; 
	return self;
}

@end
