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

	mouseSwiped = NO;

	UITouch *touch = [touches anyObject];
    
    // double tap clear don't want that right now
    //	if ([touch tapCount] == 2) {
    //		_drawImage.image = nil;
    //		return;
    //	}
	
	lastPoint = [touch locationInView:self.view];
	//lastPoint.y -= 20;
	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];
    NSLog(@"%d",touch.phase);

	[self draw:touch];

	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
	
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	   
	UITouch *touch = [touches anyObject];
    NSLog(@"%d",touch.phase);

	if( ! mouseSwiped) {

		[self draw:touch];
	}

}

-(void)draw:(UITouch*)touch {
    
    NSLog(@"%d",touch.phase);
    
    CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20;
    
	UIGraphicsBeginImageContext(_drawImage.frame.size);
	[_drawImage.image drawInRect:_drawImage.frame];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
    
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    
    if (touch.phase == 1) {
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    } else {
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    }
    
	CGContextStrokePath(UIGraphicsGetCurrentContext());
    
	_drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
    
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
