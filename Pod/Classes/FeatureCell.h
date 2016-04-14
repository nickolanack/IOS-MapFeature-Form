//
//  FeatureCell.h
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2015-12-02.
//  Copyright © 2015 Nick Blackwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placemarkView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *topLeftDetailLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *bottomRightDetailLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nameLabel;
@end
