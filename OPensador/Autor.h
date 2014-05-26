//
//  Autor.h
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Autor : NSObject {
	int IdAutor;
	NSString* NomeAutor;
}

@property (nonatomic,assign)int IdAutor;
@property (nonatomic,retain) NSString* NomeAutor;

-(id)initWithAutor:(NSString *)pNomeAutor :(int)pIdAutor;

@end
