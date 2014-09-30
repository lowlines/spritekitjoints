//
//  GameScene.m
//  SpriteKitJoints
//
//  Created by Richard Deveraux on 30/09/2014.
//  Copyright (c) 2014 Richard Deveraux. All rights reserved.
//

#import "GameScene.h"
#import "Common.h"
#import "TouchedSpriteNode.h"

@interface GameScene()

@property (nonatomic) TouchedSpriteNode *touchedNode;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
	if (self = [super initWithSize:size]) {
		self.scaleMode = SKSceneScaleModeAspectFit;
		/* Setup your scene here */
		
		NSLog(@"Size: %f x %f", self.frame.size.width, self.frame.size.height);
	}
	return self;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
	
	NSLog(@"Size: %f x %f", self.frame.size.width, self.frame.size.height);
	
	self.backgroundColor = [SKColor lightGrayColor];
	self.name = @"scene";
	self.physicsWorld.contactDelegate = self;
	
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
	
	// Uncomment the joint you want to display
	//[self loadFixedJointLevel];
	//[self loadSlidingJointLevel];
	[self loadSpringJointLevel];
	//[self loadLimitJointLevel];
	//[self loadPinJointLevel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self];
	
	SKNode *node = [self nodeAtPoint:location];
	
	NSLog(@"Name: %@", node.name);
	
	if ([node isKindOfClass:[TouchedSpriteNode class]]) {
		self.touchedNode = (TouchedSpriteNode *)node;
		[self.touchedNode touchesBegan:touches withEvent:event];
	} else {
		if (self.touchedNode != nil) {
			[self.touchedNode touchesEnded:touches withEvent:event];
		}
		self.touchedNode = nil;
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (self.touchedNode != nil) {
		[self.touchedNode touchesMoved:touches withEvent:event];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (self.touchedNode != nil) {
		[self.touchedNode touchesEnded:touches withEvent:event];
	}
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


-(void)loadFixedJointLevel {
	TouchedSpriteNode *bodyA = [TouchedSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
	bodyA.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-bodyA.size.height/2);
	bodyA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyA.physicsBody.dynamic = YES;
	bodyA.physicsBody.density = 1;
	[self addChild:bodyA];
	
	TouchedSpriteNode *bodyB = [TouchedSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(40, 40)];
	bodyB.position = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height);
	bodyB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyB.physicsBody.dynamic = NO;
	bodyB.physicsBody.density = 1;
	[self addChild:bodyB];
	
	CGPoint anchor = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height/2);
	SKPhysicsJointFixed *joint = [SKPhysicsJointFixed jointWithBodyA:bodyA.physicsBody bodyB:bodyB.physicsBody anchor:anchor];
	[self.physicsWorld addJoint:joint];
}

-(void)loadSlidingJointLevel {
	TouchedSpriteNode *bodyA = [TouchedSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
	bodyA.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-bodyA.size.height/2);
	bodyA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyA.physicsBody.dynamic = YES;
	bodyA.physicsBody.density = 1;
	[self addChild:bodyA];
	
	TouchedSpriteNode *bodyB = [TouchedSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(40, 40)];
	bodyB.position = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height);
	bodyB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyB.physicsBody.dynamic = NO;
	bodyB.physicsBody.density = 1;
	[self addChild:bodyB];
	
	CGPoint anchor = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height/2);
	CGVector axis = CGVectorMake(1, 0);
	SKPhysicsJointSliding *joint = [SKPhysicsJointSliding jointWithBodyA:bodyA.physicsBody bodyB:bodyB.physicsBody anchor:anchor axis:axis];
	
	// Limit the distance bodies can move along the axis.
	//joint.shouldEnableLimits = YES;
	//joint.lowerDistanceLimit = -30;
	//joint.upperDistanceLimit = 30;
	
	[self.physicsWorld addJoint:joint];
}

-(void)loadSpringJointLevel {
	TouchedSpriteNode *bodyA = [TouchedSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
	bodyA.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-bodyA.size.height/2);
	bodyA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyA.physicsBody.dynamic = YES;
	bodyA.physicsBody.density = 1;
	[self addChild:bodyA];
	
	TouchedSpriteNode *bodyB = [TouchedSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(40, 40)];
	bodyB.position = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height+20);
	bodyB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyB.physicsBody.dynamic = NO;
	bodyB.physicsBody.density = 1;
	[self addChild:bodyB];
	
	CGPoint anchorA = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height/2);
	CGPoint anchorB = CGPointMake(bodyB.position.x, bodyB.position.y-bodyB.size.height/2);
	SKPhysicsJointSpring *joint = [SKPhysicsJointSpring jointWithBodyA:bodyA.physicsBody bodyB:bodyB.physicsBody anchorA:anchorA anchorB:anchorB];
	// A constant that defines how the spring’s motion should be damped due to the forces of friction.
	//joint.damping = 0.0;
	
	// A constant that defines the frequency characteristics of the spring.
	joint.frequency = 1.5;
	
	[self.physicsWorld addJoint:joint];
}

-(void)loadLimitJointLevel {
	TouchedSpriteNode *bodyA = [TouchedSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
	bodyA.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-bodyA.size.height/2);
	bodyA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyA.physicsBody.dynamic = YES;
	bodyA.physicsBody.density = 1;
	[self addChild:bodyA];
	
	TouchedSpriteNode *bodyB = [TouchedSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(40, 40)];
	bodyB.position = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height+80);
	bodyB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyB.physicsBody.dynamic = NO;
	bodyB.physicsBody.density = 1;
	[self addChild:bodyB];
	
	CGPoint anchorA = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height/2);
	CGPoint anchorB = CGPointMake(bodyB.position.x, bodyB.position.y-bodyB.size.height/2);
	SKPhysicsJointLimit *joint = [SKPhysicsJointLimit jointWithBodyA:bodyA.physicsBody bodyB:bodyB.physicsBody anchorA:anchorA anchorB:anchorB];
	
	// The maximum distance allowed between the two physics bodies connected by the limit joint.
	//joint.maxLength = 40;
	
	[self.physicsWorld addJoint:joint];
}

-(void)loadPinJointLevel {
	TouchedSpriteNode *bodyA = [TouchedSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
	bodyA.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-bodyA.size.height/2);
	bodyA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyA.physicsBody.dynamic = NO;
	bodyA.physicsBody.density = 1;
	[self addChild:bodyA];
	
	TouchedSpriteNode *bodyB = [TouchedSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(20, 80)];
	bodyB.position = CGPointMake(bodyA.position.x, bodyA.position.y-bodyA.size.height/2-bodyB.size.height/2);
	bodyB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
	bodyB.physicsBody.dynamic = YES;
	bodyB.physicsBody.density = 1;
	[self addChild:bodyB];
	
	CGPoint anchor = CGPointMake(bodyA.position.x, bodyA.position.y-bodyA.size.height/2);
	SKPhysicsJointPin *joint = [SKPhysicsJointPin jointWithBodyA:bodyA.physicsBody bodyB:bodyB.physicsBody anchor:anchor];
	
	joint.shouldEnableLimits = YES;
	
	// The smallest angle allowed for the pin joint, in radians.
	joint.lowerAngleLimit = radianFromDegree(-90);
	
	// The largest angle allowed for the pin joint, in radians.
	joint.upperAngleLimit = radianFromDegree(90);
	
	// The resistance applied by the pin joint to spinning around the anchor point.
	// Ranges from 0.0 to 1.0
	joint.frictionTorque = 0.0;
	
	
	[self.physicsWorld addJoint:joint];
}

@end
