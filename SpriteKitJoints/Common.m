//
//  Common.m
//  SpriteKitJoints
//
//  Created by Richard Deveraux on 11/03/2014.
//  Copyright (c) 2014 Untitled. All rights reserved.
//

#import "Common.h"

CGFloat distanceBetweenPoints(CGPoint pointA, CGPoint pointB) {
	CGFloat dx = pointB.x - pointA.x;
	CGFloat dy = pointB.y - pointA.y;
	return sqrt(dx*dx + dy*dy);
}

SKPhysicsJoint* closestJointForBody(SKPhysicsBody *body) {
	int count = 0;
	SKPhysicsJoint *closestJoint = nil;
	CGFloat closestDistance = 0;
	for (SKPhysicsJoint *joint in [body joints]) {
		SKPhysicsBody *otherBody = joint.bodyA == body ? joint.bodyB : joint.bodyA;
		CGFloat distance = distanceBetweenPoints(body.node.position, otherBody.node.position);
		if (closestJoint == nil || abs(closestDistance) > abs(distance)) {
			closestJoint = joint;
			closestDistance = distance;
		}
		
		NSLog(@"Body(%@) - Body(%@) At: %f", body.node.name, otherBody.node.name, distance);
		count++;
	}
	return closestJoint;
}

CGFloat degreeFromRadian(CGFloat radian) {
	return radian * 180/M_PI;
}

CGFloat radianFromDegree(CGFloat degree) {
	return degree * M_PI/180;
}

@implementation Common

@end
