//
//  GFTitleCell.m
//  GeoFormsMappit
//
//  Created by Nick Blackwell on 2014-08-08.
//  Copyright (c) 2014 Nick Blackwell. All rights reserved.
//

#import "GFTitleCell.h"

@implementation GFTitleCell

@synthesize delegate, tableView, fieldName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    fieldName=@"name";
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onEditTitle:(id)sender {
    
    [self.delegate.details setObject:self.titleField.text forKey:fieldName];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}



-(void)setFieldParameters:(NSDictionary *) fieldParameters{
    
    
    
    NSString *field=[fieldParameters objectForKey:@"field"];
    if(field){
        fieldName=field;
    }
    
    NSString *placeholder=[fieldParameters objectForKey:@"placeholder"];
    if(placeholder){
         [self.titleField setPlaceholder:placeholder];
    }
    


    
    
    
    NSString *value=nil;
    NSDictionary *details=self.delegate.details;
    
    if(details!=nil){
        value=[details objectForKey:fieldName];
    }
    
    if(value){
        [self.titleField setText:value];
    }
    
    
//    NSString *focus=[fieldParameters objectForKey:@"focus"];
//    if(focus){
//        [self.titleField becomeFirstResponder];
//    }
    
    
}
@end
