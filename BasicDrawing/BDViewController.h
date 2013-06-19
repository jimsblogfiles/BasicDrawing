//
//  BDViewController.h
//  BasicDrawing
//
//  Created by James Border on 6/19/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDViewController : UIViewController <UIGestureRecognizerDelegate> {

    CGPoint lastPoint;
	BOOL mouseSwiped;
	int mouseMoved;

}

@property (strong, nonatomic) IBOutlet UIImageView *drawImage;


@end
