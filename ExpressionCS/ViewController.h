//
//  ViewController.h
//  ExpressionCS
//
//  Created by yiliu on 16/1/14.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UITextField *contentField;

@property (weak, nonatomic) IBOutlet UIButton *SendMessage;
- (IBAction)SendMessage:(id)sender;

@end