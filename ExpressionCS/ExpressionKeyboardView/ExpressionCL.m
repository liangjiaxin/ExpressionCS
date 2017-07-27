//
//  ExpressionCL.m
//  ExpressionCS
//
//  Created by yiliu on 16/1/14.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ExpressionCL.h"
#import "Emoji.h"

@implementation ExpressionCL

//根据文件夹名称获取表情包的plist文件路径
+ (NSString *)ObtainFilePath:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
    
    //获取emotiocns.plist文件内容
    NSString *emotiocnsPath = [NSString stringWithFormat:@"%@/%@/info.plist",path,name];
    
    return emotiocnsPath;
}

//根据文件夹名称获取表情路径
+ (NSString *)ObtainExpressionPath:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
    NSString *emotiocnsPath = [NSString stringWithFormat:@"%@/%@",path,name];
    return emotiocnsPath;
}

/**
 *获取所有emoji表情
 */
+ (NSArray *)ObtainAllEmojiExpression{
    NSArray *expressionArry = [Emoji allEmoji];
    return expressionArry;
}

/**
 *获取所有sina默认表情
 */
+ (NSArray *)ObtainAllSinaDefaultExpression{
    NSString *filePath = [self ObtainFilePath:@"com.sina.default"];
    
    //获取文件内容
    NSDictionary *fileDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //获取表情
    NSArray *expressionArry = [fileDict objectForKey:@"emoticons"];
    
    return expressionArry;
}

/**
 *获取所有浪小花表情
 */
+ (NSArray *)ObtainAllSinaLxhExpression{
    NSString *filePath = [self ObtainFilePath:@"com.sina.lxh"];
    
    //获取文件内容
    NSDictionary *fileDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //获取表情
    NSArray *expressionArry = [fileDict objectForKey:@"emoticons"];
    
    return expressionArry;
}

/**
 *根据图片名获取sina默认表情图片
 */
+ (UIImage *)ObtainPictureDefault:(NSString *)name{
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self ObtainExpressionPath:@"com.sina.default"],name];
    
    //根据地址获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}

/**
 *根据图片名获取浪小花表情图片
 */
+ (UIImage *)ObtainPictureLxh:(NSString *)name{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self ObtainExpressionPath:@"com.sina.lxh"],name];
    
    //根据地址获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}

/**
 *根据表情名称获取sina默认表情图片
 */
+ (UIImage *)ObtainPictureNameDefault:(NSString *)name{
    NSArray *sinaArry = [self ObtainAllSinaDefaultExpression];
    for (int i=0; i<sinaArry.count; i++) {
        NSDictionary *dict = sinaArry[i];
        if([dict[@"chs"] isEqual:name]){
            return [self ObtainPictureDefault:dict[@"png"]];
        }
    }
    return nil;
}

/**
 *根据表情名称获取浪小花表情图片
 */
+ (UIImage *)ObtainPictureNameLxh:(NSString *)name{
    NSArray *lxhArry = [self ObtainAllSinaLxhExpression];
    for (int i=0; i<lxhArry.count; i++) {
        NSDictionary *dict = lxhArry[i];
        if([dict[@"chs"] isEqual:name]){
            return [self ObtainPictureLxh:dict[@"png"]];
        }
    }
    return nil;
}

/**
 *根据表情名称获取表情图片
 */
+ (UIImage *)ObtainPictureName:(NSString *)name{
    UIImage *image = [self ObtainPictureNameDefault:name];
    if(!image){
        image = [self ObtainPictureNameLxh:name];
    }
    return image;
}

//获取删除按钮图片
+ (UIImage *)ObtainBtnImage{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
    NSString *btnPath = [NSString stringWithFormat:@"%@/compose_emotion_delete.imageset/compose_emotion_delete@2x.png",path];
    //根据地址获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:btnPath];
    return image;
}



@end

