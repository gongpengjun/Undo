//
//  GpjViewController.m
//  Undo
//
//  Created by 巩 鹏军 on 14-7-8.
//  Copyright (c) 2014年 gongpengjun.com. All rights reserved.
//

#import "GpjViewController.h"

@interface GpjViewController ()
{
    NSUndoManager *_undoManager;
}
@property (weak, nonatomic) IBOutlet UIView   *editingView;
@property (weak, nonatomic) IBOutlet UIButton *changeColorButton;
@property (weak, nonatomic) IBOutlet UIButton *redoButton;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;
@end

@implementation GpjViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _undoManager = [[NSUndoManager alloc] init];
    //[self setBackgroundColor:[UIColor redColor]];
    [self updateUI];
}

- (void)updateUI
{
    if([_undoManager canUndo]) {
        _undoButton.enabled = YES;
    } else {
        _undoButton.enabled = NO;
    }
    
    if([_undoManager canRedo]) {
        _redoButton.enabled = YES;
    } else {
        _redoButton.enabled = NO;
    }
}

- (IBAction)changeColorAction:(id)sender
{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    UIColor *newBgColor = [self randomColor];
    [self setBackgroundColor:newBgColor];
    [self updateUI];
}

- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

- (void)setBackgroundColor:(UIColor*)backgroundColor
{
    UIColor *currentBgColor = _editingView.backgroundColor;
    if(backgroundColor != currentBgColor) {
        [[_undoManager prepareWithInvocationTarget:self] setBackgroundColor:currentBgColor];
    }
    _editingView.backgroundColor = backgroundColor;
}

- (IBAction)undoAction:(id)sender
{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    [_undoManager undo];
    [self updateUI];
}

- (IBAction)redoAction:(id)sender
{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    [_undoManager redo];
    [self updateUI];
}

@end
