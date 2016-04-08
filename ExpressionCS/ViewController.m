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
- (void)ExpressionDelete{
    [self deleteExpression:contentStr];
    _contentField.text = contentStr;
    _contentTextView.attributedText= [self zhuanhuan:contentStr];
}

//输入的表情
- (void)ExpressionSelect:(NSString *)str{
    [contentStr appendString:str];
    _contentField.text = contentStr;
    _contentTextView.attributedText= [self zhuanhuan:contentStr];
}

- (NSMutableAttributedString *)zhuanhuan:(NSMutableString *)content{
    
    //创建可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
    
    //通过正则表达式来匹配字符
    NSString *regex = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (!re) {
        NSLog(@"%@",[error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:content options:0 range:NSMakeRange(0, content.length)];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        
        //获取数组元素中得到range
        NSRange range = [match range];
        
        //获取原字符串中对应的值
        NSString *subStr = [content substringWithRange:range];
        
        //新建文字附件来存放我们的图片,iOS7才新加的对象
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
        
        //给附件添加图片
        textAttachment.image= [ExpressionCL ObtainPictureName:subStr];
        
        //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
        textAttachment.bounds=CGRectMake(0, -8,textAttachment.image.size.width, textAttachment.image.size.height);
        
        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        //把图片和图片对应的位置存入字典中
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        [imageDic setObject:imageStr forKey:@"image"];
        
        [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
        
        //把字典存入数组中
        [imageArray addObject:imageDic];
        
    }
    
    //4、从后往前替换，否则会引起位置问题
    for(int i = (int)imageArray.count-1; i >=0; i--) {
        
        NSRange range;
        
        [imageArray[i][@"range"] getValue:&range];
        
        //进行替换
        
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
        
    }
    return attributeString;
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
