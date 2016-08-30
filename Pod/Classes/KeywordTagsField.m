//
//  KeywordTagsField.m
//  Pods
//
//  Created by Nick on 2016-08-30.
//
//

#import "KeywordTagsField.h"
#import "TileSelectionCollectionViewCell.h"


@interface KeywordTagsField ()


@property NSArray *values;
@property NSArray *icons;
@property NSArray *colors;

@property int selectedIndex;


@end

@implementation KeywordTagsField


@synthesize delegate, tableView, fieldName;




-(void)setFieldParameters:(NSDictionary *) fieldParameters{

    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }
    
    NSString *values=[fieldParameters objectForKey:@"values"];
    if(values){
        _values=values;
    }else{
        _values=@[@"one", @"two"];
    }
    
    NSString *icons=[fieldParameters objectForKey:@"icons"];
    if(icons){
        _icons=icons;
    }else{
        _icons=@[];
    }
    
    
    
    NSNumber *value=nil;
    NSDictionary *details=self.delegate.details;
    
    if(details!=nil){
        NSString *strValue=[details objectForKey:fieldName];
        if(strValue){
            int index=[_values indexOfObject:strValue];
            if(index!=NSNotFound){
                value=[NSNumber numberWithInteger:index];
            }
        }
    }
    
    if(value==nil){
        value=[fieldParameters objectForKey:@"value"];
    }
    
    if(value){
        _selectedIndex=[value integerValue];
        [self.delegate.details setObject:[_values objectAtIndex:[value integerValue]] forKey:fieldName];
    }

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_values count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    TileSelectionCollectionViewCell *cell = (TileSelectionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DefaultKeyword" forIndexPath:indexPath];
    
    [cell.label setText:[_values objectAtIndex:indexPath.row]];
    
    if(_icons.count>indexPath.row){
        
        NSString *image=[_icons objectAtIndex:indexPath.row];
        if(![image isEqualToString:@""]){
            [cell.button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }else{
            [cell.button setImage:nil forState:UIControlStateNormal];
        }
        
    }
    
    
    if(_selectedIndex==indexPath.row){
        
        [cell.button setSelected:true];
        [cell setSelected:true];
        
    }else{
        [cell.button setSelected:false];
    }
    
    return cell;

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex=indexPath.row;
    [self.delegate.details setObject:[_values objectAtIndex:_selectedIndex] forKey:fieldName];
    TileSelectionCollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    [cell.button setSelected:true];
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    TileSelectionCollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    [cell.button setSelected:false];
}

@end
