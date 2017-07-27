//
//  ViewController.m
//  ExpressionCS
//
//  Created by yiliu on 16/1/14.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ViewController.h"
#import "ExpressionKeyboardView.h"
#import "ExpressionCL.h"
#import "NSAttributedString+Emotion.h"

@interface ViewController ()<ExpressionKeyboardDelegate>{
    
    NSMutableString *contentStr;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentStr = [[NSMutableString alloc] init];
    
    ExpressionKeyboardView *expressView = [[ExpressionKeyboardView alloc] init];
    expressView.delegate = self;
    [self.view addSubview:expressView];
    
}

#pragma -mark ExpressionKeyboardDelegate
//删除按钮
- (void)expressionDelete{
    [self deleteExpression:contentStr];
    _contentField.text = contentStr;
    _contentLabel.attributedText = [self emotionAttributedString:contentStr];
}

//发送
- (void)expressionSend{
}

//输入的表情
- (void)expressionSelect:(NSString *)str{
    [contentStr appendString:str];
    _contentField.text = contentStr;
    _contentLabel.attributedText= [self emotionAttributedString:contentStr];
}



- (NSAttributedString *)emotionAttributedString:(NSString *)content{
    
    UIFont *font = [UIFont systemFontOfSize:15];
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSAttributedString *contentString = [NSAttributedString emotionAttributedStringFrom:content attributes:attributes];
    
    return contentString;
    
}

- (void)deleteExpression:(NSMutableString *)content{
    if([content length] <= 0){
        return;
    }
    //字符串末尾
    NSInteger length = [content length] - 1;
    
    //字符串末尾位置
    NSRange range = NSMakeRange(length, 1);
    
    //获取末尾位置字符串
    NSString *lastStr = [content substringWithRange:range];
    
    if ([lastStr isEqualToString:@"]"]) {
        //新浪,小浪花表情
        
        //获取[的位置
        NSRange biaoqingRang = [content rangeOfString:@"[" options:NSBackwardsSearch];
        
        //获取[]长度
        NSInteger biaoqingLength = range.location - biaoqingRang.location;
        
        //重置删除的range
        range = NSMakeRange(length - biaoqingLength, biaoqingLength + 1);
        
    }else if ([lastStr intValue] < 0x1F600 || [lastStr intValue] > 0x1F64F) {
        //系统表情
        
        //重置删除的range
        range = NSMakeRange(length - 1, 2);
    }
    [content deleteCharactersInRange:range];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
