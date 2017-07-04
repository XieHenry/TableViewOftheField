//
//  TableViewCell.m
//  TableViewDemo
//
//  Created by XieHenry on 2017/7/4.
//  Copyright © 2017年 XieHenry. All rights reserved.
//

#import "TableViewCell.h"

/**
 @abstract 根据RGB值来获取UICOLOR.
 **/
static inline UIColor *UICOLOR_FROM_RGB(CGFloat r,CGFloat g,CGFloat b) {
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.0];
}


static inline UIColor *UICOLOR_RANDOM_COLOR() {
    return UICOLOR_FROM_RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
}

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    
    
//    _label = [[UILabel alloc]init];
    
    _label = [[UITextField alloc]init];
    _label.frame = CGRectMake(20, 10, self.frame.size.width-20, 30);
    _label.backgroundColor = UICOLOR_RANDOM_COLOR();
    [self.contentView addSubview:_label];
    
}


@end
