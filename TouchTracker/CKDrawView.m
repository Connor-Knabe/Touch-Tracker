//
//  CKDrawView.m
//  TouchTracker
//
//  Created by Administrator on 7/13/14.
//  Copyright (c) 2014 Connor. All rights reserved.
//

#import "CKDrawView.h"
#import "CKLine.h"

@interface CKDrawView()

//@property (nonatomic, strong) CKLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;


@end

@implementation CKDrawView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.linesInProgress = [[NSMutableDictionary alloc]init];
        self.finishedLines = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}


-(void)strokeLine:(CKLine *)line{
    
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
    
}

-(void)drawRect:(CGRect)rect{
    [[UIColor blackColor]set];
    for (CKLine *line in self.finishedLines){
        [self strokeLine:line];
    }
    [[UIColor redColor]set];
    for (NSValue *key in self.linesInProgress){
        [self strokeLine:self.linesInProgress[key]];
    }


}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    
    for (UITouch *t in touches){
        CGPoint location = [t locationInView:self];
        CKLine *line = [[CKLine alloc]init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
        
        
    }
    
    
    
    [self setNeedsDisplay];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches){
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        CKLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
        
    }
    
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches){
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        CKLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
                        
        
    }
    
    [self setNeedsDisplay];



}


@end
