//
//  BDViewController.m
//  BasicDrawing
//
//  Created by James Border on 6/19/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import "BDViewController.h"

@interface BDViewController ()

@end

@implementation BDViewController

#pragma mark -
#pragma mark

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([_drawImage isHidden]) {
		return;
	}
	
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
    
    // double tap clear don't want that right now
    //	if ([touch tapCount] == 2) {
    //		_drawImage.image = nil;
    //		return;
    //	}
	
	lastPoint = [touch locationInView:self.view];
	lastPoint.y -= 20;
	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([_drawImage isHidden]) {
		return;
	}
	
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20;
	
	UIGraphicsBeginImageContext(_drawImage.frame.size);
	[_drawImage.image drawInRect:CGRectMake(0, 0, _drawImage.frame.size.width, _drawImage.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	_drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
	
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
	
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([_drawImage isHidden]) {
		return;
	}
    
	if(!mouseSwiped) {
		
		UIGraphicsBeginImageContext(_drawImage.frame.size);
		[_drawImage.image drawInRect:CGRectMake(0, 0, _drawImage.frame.size.width, _drawImage.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		_drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
	}
	
}

#pragma mark -
#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
