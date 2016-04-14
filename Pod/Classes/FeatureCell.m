//
//  FeatureCell.m
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2015-12-02.
//  Copyright © 2015 Nick Blackwell. All rights reserved.
//

#import "FeatureCell.h"

@implementation FeatureCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self=[super initWithCoder:aDecoder];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;

    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.masksToBounds = NO;
    return self;
    

}

@end
