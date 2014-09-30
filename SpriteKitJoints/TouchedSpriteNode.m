//
//  TouchedSpriteNode.m
//  SpriteKitJoints
//
//  Created by Richard Deveraux on 30/09/2014.
//  Copyright (c) 2014 Richard Deveraux. All rights reserved.
//

#import "TouchedSpriteNode.h"

@interface TouchedSpriteNode()

@property (nonatomic) BOOL wasDynamic;

@end

@implementation TouchedSpriteNode

-(void) touchesBegan: (NSSet *) touches withEvent:(UIEvent *)event {
	NSLog(@"TouchesBegan: %@", self.name);
	
	// Save dynamic state
	self.wasDynamic = self.physicsBody.dynamic;
}

-(void) touchesMoved: (NSSet *) touches withEvent:(UIEvent *)event {
	NSLog(@"TouchesMoved: %@", self.name);
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self.scene];
	
	// Restore dynamic state and then set the new position
	self.physicsBody.dynamic = self.wasDynamic;
	self.position = location;
	NSLog(@"Moved To: %f, %f", location.x, location.y);
	
	// Wait a small amount of time before turning off dynamic to update the physics on the object,
	// which will do a soft pause in physics calculations
	[self runAction:[SKAction waitForDuration:0.01] completion:^{
		//NSLog(@"Relocked %@", self.name);
		self.physicsBody.dynamic = NO;
	}];
}

-(void) touchesEnded: (NSSet *) touches withEvent:(UIEvent *)event {
	NSLog(@"TouchesEnded: %@", self.name);
	
	// Restore dynamic state to allow physics to behave as normal ie unpause
	self.physicsBody.dynamic = self.wasDynamic;
}
@end