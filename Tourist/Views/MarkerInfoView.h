//
//  MarkerInfoView.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkerInfoView : UIView
-(void)setTitle:(NSString*)title andRating:(NSString*)rating;
-(void)loadWithTask:(BFTask*)task;
@end
