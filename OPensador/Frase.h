//
//  Frases.h
//  OPensador
//
//  Created by mac on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Frase : NSObject {
    int IdFrase;
    int IdAutor;
	NSString* TxtFrase;
}

@property (nonatomic,assign)int IdFrase;
@property (nonatomic, assign)int IdAutor;
@property (nonatomic,retain) NSString* TxtFrase;

-(id)initWithFrase:(NSString *)pTxtFrase :(int)pIdAutor :(int)pIdFrase;

@end
