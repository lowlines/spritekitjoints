//
//  Common.h
//  SpriteKitJoints
//
//  Created by Richard Deveraux on 11/03/2014.
//  Copyright (c) 2014 Untitled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Common : NSObject

CGFloat distanceBetweenPoints(CGPoint pointA, CGPoint pointB);
SKPhysicsJoint* closestJointForBody(SKPhysicsBody *body);

CGFloat degreeFromRadian(CGFloat radian);
CGFloat radianFromDegree(CGFloat degree);

@end
