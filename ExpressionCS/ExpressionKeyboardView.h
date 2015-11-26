//
//  ExpressionKeyboardView.h
//  ExpressionCS
//
//  Created by yiliu on 16/1/14.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明协议中的接口函数
@protocol  ExpressionKeyboardDelegate <NSObject>

- (void)ExpressionSelect:(NSString *)str;

- (void)ExpressionDelete;

@end


@interface ExpressionKeyboardView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign) id<ExpressionKeyboardDelegate> delegate;

@property (nonatomic,strong) UIScrollView *defaultView;

@property (nonatomic,strong) UIPageControl *defaultPage;

@property (nonatomic,strong) NSArray *emojiArry;
@property (nonatomic,strong) NSArray *defaultArry;
@property (nonatomic,strong) NSArray *lxhArry;

@property (nonatomic,assign) NSInteger emojinum;
@property (nonatomic,assign) NSInteger defaultnum;
@property (nonatomic,assign) NSInteger lxhnum;

@property (nonatomic,strong) UIButton *emojiBtn;
@property (nonatomic,strong) UIButton *defaultBtn;
@property (nonatomic,strong) UIButton *lxhBtn;

@property (nonatomic,assign) NSInteger selectIndex;

@end
