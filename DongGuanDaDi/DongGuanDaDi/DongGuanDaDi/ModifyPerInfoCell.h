//
//  ModifyPerInfoCell.h
//  DongGuanDaDi
//
//  Created by fanyunlong on 8/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPerInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextField *qqTxtField;
@property (strong, nonatomic) IBOutlet UITextField *weChatTxtField;
@property (nonatomic, strong) IBOutlet UITextField *phoneTxtField;
- (IBAction)modifyPeronalInfo:(id)sender;
- (IBAction)cancelModifyPersonalInfo:(id)sender;
@end
