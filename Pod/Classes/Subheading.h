//
//  Subheading.h
//  Pods
//
//  Created by Nick on 2016-07-19.
//
//

#import <Foundation/Foundation.h>
#import "FeatureField.h"

@interface Subheading : UITableViewCell<FeatureField>
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subheading;

@end
