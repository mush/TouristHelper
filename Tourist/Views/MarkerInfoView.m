//
//  MarkerInfoView.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "MarkerInfoView.h"

@implementation MarkerInfoView{
    
    UILabel *title_;
    UILabel *rating_;
    

}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        title_ = [UILabel new];
        rating_ = [UILabel new];
        [self addSubview:title_];
        [self addSubview:rating_];
        
        
        [title_ makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self).multipliedBy(0.5);
            make.top.left.and.width.equalTo(self);
        }];
        
        [rating_ makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title_.bottom);
            make.left.width.and.height.equalTo(title_);
        }];
        
        self.backgroundColor = [UIColor greenColor];
        
    }
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"%lf %lf", self.bounds.size.width, self.bounds.size.height);
    
}
-(void)setTitle:(NSString*)title andRating:(NSString*)rating{

    title_.text = title;
    rating_.text = rating;
    
    [self layoutIfNeeded];

}
-(void)loadWithTask:(BFTask*)task{

    [task continueWithSuccessBlock:^id(BFTask *task) {
        [self setTitle:task.result[@"title"] andRating:task.result[@"rating"]];
        return nil;
    }];

}
@end
