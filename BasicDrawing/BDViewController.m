//
//  BDViewController.m
//  BasicDrawing
//
//  Created by James Border on 6/19/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import "BDViewController.h"

@interface BDViewController () {

    CGPoint lastPoint;
	BOOL mouseSwiped;

	int mouseMoved;

    CGFloat point;
    UIColor *color;

}

@property (weak, nonatomic) IBOutlet UIButton *buttonErase;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPointSize;
@property (strong, nonatomic) IBOutlet UIImageView *drawImage;

@end

@implementation BDViewController

#pragma mark -
#pragma mark

- (IBAction)actionSetPointSize:(id)sender {

    NSLog(@"sender:%i",_segmentPointSize.selectedSegmentIndex);
    
    point = (_segmentPointSize.selectedSegmentIndex + 1) * 15;
    
}

- (IBAction)actionErase:(id)sender {

    UIButton *erase = sender;

    if ( ! [erase isSelected] ) {

        [_buttonErase setSelected:YES];
        color = [UIColor clearColor];

    } else {

        [_buttonErase setSelected:NO];
        color = [UIColor blackColor];

    }
    
}

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
    
    CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20;
    
	UIGraphicsBeginImageContext(_drawImage.frame.size);
	[_drawImage.image drawInRect:_drawImage.frame];

    CGContextRef cgref = UIGraphicsGetCurrentContext();

    CGContextSetLineCap(cgref, kCGLineCapRound);
    
    CGContextSetLineWidth(cgref, point);
    CGContextSetStrokeColorWithColor(cgref, [color CGColor]);
    CGContextBeginPath(cgref);
    
    CGContextMoveToPoint(cgref, lastPoint.x, lastPoint.y);

    if ( [_buttonErase isSelected] ) {

        CGContextSetBlendMode(cgref, kCGBlendModeClear);
        CGContextClosePath(cgref);
        CGContextDrawPath(cgref, kCGPathFillStroke);

    } else {

        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeColor);
        
        if (touch.phase == 1) {
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        } else {
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        }

        CGContextStrokePath(UIGraphicsGetCurrentContext());

    }

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

    [_buttonErase setTitle:@"Erase √" forState:UIControlStateSelected];
    [_buttonErase setTitle:@"Erase" forState:UIControlStateNormal];

    color = [UIColor blackColor];

    point = 25;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
