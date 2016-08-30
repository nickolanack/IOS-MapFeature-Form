//
//  KeywordTagsField.h
//  Pods
//
//  Created by Nick on 2016-08-30.
//
//

#import <UIKit/UIKit.h>
#import "GFDelegateCell.h"
#import "FeatureField.h"

@interface KeywordTagsField : UITableViewCell<GFDelegateCell, FeatureField, UICollectionViewDelegate, UICollectionViewDataSource>

@property NSString *fieldName;

@end
