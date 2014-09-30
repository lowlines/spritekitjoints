//
//  TouchedSpriteNode.h
//  SpriteKitJoints
//
//  Created by Richard Deveraux on 30/09/2014.
//  Copyright (c) 2014 Richard Deveraux. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TouchedSpriteNode : SKSpriteNode

-(void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event;
-(void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *)event;
-(void) touchesEnded:(NSSet *) touches withEvent:(UIEvent *)event;
@end