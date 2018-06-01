//
//  ViewController.m
//  SlideViewDemo
//
//  Created by sunror on 2016/10/27.
//  Copyright © 2016年 mxl. All rights reserved.
//

#import "ViewController.h"

static NSString *imageiocn = @"9d4636a301cbcdfa18125dcf88c1da6f";
@interface ViewController ()
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, assign) BOOL isDraging;
@property (nonatomic, weak) UIButton *btnn;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //       1.添加子控件
    // left
    UIView *left = [[UIView alloc] initWithFrame:self.view.bounds];
    left.backgroundColor = [UIColor greenColor];
    [self.view addSubview:left];
    _leftView = left;
    // main
    UIView *main = [[UIView alloc] initWithFrame:self.view.bounds];
    main.backgroundColor = [UIColor grayColor];
    [self.view addSubview:main];
    _mainView = main;

    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(main.frame.size.width/2 -30, main.frame.size.height-60, 60, 60);
    [btn setImage:[UIImage imageNamed:imageiocn] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.frame.size.height/2;
    [main addSubview:btn];
    _btnn = btn;

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self.view];
    CGPoint preP = [touch previousLocationInView:self.view];
    CGFloat offsetX = curP.x - preP.x;
    _mainView.frame = [self frameWithOffsetX:offsetX];
    CGRect frame = _btnn.frame;
    frame.origin.x -=offsetX/2 ;
    _btnn.frame = frame;
}

- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = _mainView.frame;
    frame.size.height = screenH;
    frame.size.width = screenW;
    frame.origin.x += offsetX;
    frame.origin.y = 0;
    return frame;
}

#define RigthX 220
#define LeftX -220
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGFloat targetX = 0;
     CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    if (_mainView.frame.origin.x > screenW * 0.5) { // 移动到右边
        targetX = RigthX;
    }else if (CGRectGetMaxX(_mainView.frame) < screenW * 0.5){
        // 移动到左边
        targetX = LeftX;
    }
    CGFloat offsetX = targetX - _mainView.frame.origin.x;
    [UIView animateWithDuration:0.25 animations:^{
        
        if (targetX) {
            _mainView.frame = [self frameWithOffsetX:offsetX];
            if (_mainView.frame.origin.x > 0) {
                CGRect frame = _btnn.frame;
                frame.origin.x = 0;
                _btnn.frame = frame;
            }else if(_mainView.frame.origin.x < 0){
            CGRect frame = _btnn.frame;
            frame.origin.x = screenW-60;
            _btnn.frame = frame;
            }
            
        }else{
           _mainView.frame = self.view.bounds;
           CGRect frame = _btnn.frame;
           frame.origin.x = screenW * 0.5 -_btnn.frame.size.width/2;
          _btnn.frame = frame;
        }
    }];
}


@end
