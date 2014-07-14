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

@property (nonatomic, strong) CKLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation CKDrawView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.finishedLines = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor grayColor];
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

-(void) drawRect:(CGRect)rect{
    [[UIColor blackColor]set];
    for (CKLine *line in self.finishedLines) 
        [self strokeLine:line];
    }
}


@end
