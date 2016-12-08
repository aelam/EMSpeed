//
//  PageControl.m
//  PageControlDemo
//
/**
 * Created by honcheng on 5/14/11.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the 
 * "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, sublicense, and/or sell copies of the Software, and to 
 * permit persons to whom the Software is furnished to do so, subject 
 * to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT 
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR 
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
 * IN CONNECTION WITH THE SOFTWARE OR 
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author 		Muh Hon Cheng <honcheng@gmail.com> http://twitter.com/honcheng
 * @copyright	2011	Muh Hon Cheng
 * 
 */

#import "StyledPageControl.h"


@implementation StyledPageControl

#define COLOR_GRAY [UIColor colorWithRed:180.f/255.f green:180.f/255.f blue:180.f/255.f alpha:1]
#define COLOR_GRAYISHBLUE [UIColor colorWithRed:140.f/255.f green:140.f/255.f blue:140.f/255.f alpha:1]

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.strokeWidth = 1;
        self.gapWidth = 5;
        self.diameter = 5;
        self.pageControlStyle = PageControlStyleDefault;
        
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
//        [self addGestureRecognizer:tapGestureRecognizer];
//        [tapGestureRecognizer release];
    }
    return self;
}

//- (void)onTapped:(UITapGestureRecognizer*)gesture
//{
//    CGPoint touchPoint = [gesture locationInView:[gesture view]];
//    
//    if (touchPoint.x < self.frame.size.width/2)
//    {
//        // move left
//        if (self._currentPage>0)
//        {
//            self._currentPage -= 1;
//        }
//        
//    }
//    else
//    {
//        // move right
//        if (self._currentPage<self._numberOfPages-1)
//        {
//            self._currentPage += 1;
//        }
//    }
//    [self setNeedsDisplay];
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//}

- (void)drawRect:(CGRect)rect
{
    UIColor *acoreNormalColor, *acoreSelectedColor, *astrokeNormalColor, *astrokeSelectedColor;
    
    if (self.coreNormalColor) acoreNormalColor = self.coreNormalColor;
    else acoreNormalColor = COLOR_GRAYISHBLUE;
    
    if (self.coreSelectedColor) acoreSelectedColor = self.coreSelectedColor;
    else
    {
        if (self.pageControlStyle==PageControlStyleStrokedCircle || self.pageControlStyle==PageControlStyleWithPageNumber)
        {
            acoreSelectedColor = COLOR_GRAYISHBLUE;
        }
        else
        {
            acoreSelectedColor = COLOR_GRAY;
        }
    }
    
    if (self.strokeNormalColor) astrokeNormalColor = self.strokeNormalColor;
    else 
    {
        if (self.pageControlStyle==PageControlStyleDefault && self.coreNormalColor)
        {
            astrokeNormalColor = self.coreNormalColor;
        }
        else
        {
            astrokeNormalColor = COLOR_GRAYISHBLUE;
        }
        
    }
    
    if (self.strokeSelectedColor) astrokeSelectedColor = self.strokeSelectedColor;
    else
    {
        if (self.pageControlStyle==PageControlStyleStrokedCircle || self.pageControlStyle==PageControlStyleWithPageNumber)
        {
            astrokeSelectedColor = COLOR_GRAYISHBLUE;
        }
        else if (self.pageControlStyle==PageControlStyleDefault && self.coreSelectedColor)
        {
            astrokeSelectedColor = self.coreSelectedColor;
        }
        else
        {
            astrokeSelectedColor = COLOR_GRAY;
        }
    }
    
    // Drawing code
    if (_hidesForSinglePage && self.numberOfPages==1)
	{
		return;
	}
	
	CGContextRef myContext = UIGraphicsGetCurrentContext();
	
	int gap = self.gapWidth;
    float adiameter = self.diameter - 2*self.strokeWidth;
    
    if (self.pageControlStyle==PageControlStyleThumb)
    {
        if (self.thumbImage && self.selectedThumbImage)
        {
            adiameter = self.thumbImage.size.width;
        }
    }
	
	int total_width = self.numberOfPages*adiameter + (self.numberOfPages-1)*gap;
	
	if (total_width>self.frame.size.width)
	{
		while (total_width>self.frame.size.width)
		{
			adiameter -= 2;
			gap = adiameter + 2;
			while (total_width>self.frame.size.width) 
			{
				gap -= 1;
				total_width = self.numberOfPages*adiameter + (self.numberOfPages-1)*gap;
				
				if (gap==2)
				{
					break;
//					total_width = self._numberOfPages*adiameter + (self._numberOfPages-1)*gap;
				}
			}
			
			if (adiameter==2)
			{
				break;
//				total_width = self._numberOfPages*adiameter + (self._numberOfPages-1)*gap;
			}
		}
		
		
	}
	
	int i;
	for (i=0; i<self.numberOfPages; i++)
	{
		int x = (self.frame.size.width-total_width)/2 + i*(adiameter+gap);

        if (self.pageControlStyle==PageControlStyleDefault)
        {
            if (i==self.currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [acoreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
                CGContextSetStrokeColorWithColor(myContext, [astrokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
            else
            {
                CGContextSetFillColorWithColor(myContext, [acoreNormalColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
                CGContextSetStrokeColorWithColor(myContext, [astrokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
        }
        else if (self.pageControlStyle==PageControlStyleStrokedCircle)
        {
            CGContextSetLineWidth(myContext, self.strokeWidth);
            if (i==self.currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [acoreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
                CGContextSetStrokeColorWithColor(myContext, [astrokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
            else
            {
                CGContextSetStrokeColorWithColor(myContext, [astrokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
        }
        else if (self.pageControlStyle==PageControlStyleWithPageNumber)
        {
            CGContextSetLineWidth(myContext, self.strokeWidth);
            if (i==self.currentPage)
            {
                int _currentPageDiameter = adiameter*1.6;
                x = (self.frame.size.width-total_width)/2 + i*(adiameter+gap) - (_currentPageDiameter-adiameter)/2;
                CGContextSetFillColorWithColor(myContext, [acoreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2,_currentPageDiameter,_currentPageDiameter));
                CGContextSetStrokeColorWithColor(myContext, [astrokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2,_currentPageDiameter,_currentPageDiameter));
            
                NSString *pageNumber = [NSString stringWithFormat:@"%i", i+1];
                CGContextSetFillColorWithColor(myContext, [[UIColor whiteColor] CGColor]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [pageNumber drawInRect:CGRectMake(x,(self.frame.size.height-_currentPageDiameter)/2-1,_currentPageDiameter,_currentPageDiameter) withFont:[UIFont systemFontOfSize:_currentPageDiameter-2] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
#pragma clang diagnostic pop
            }
            else
            {
                CGContextSetStrokeColorWithColor(myContext, [astrokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
        }
        else if (self.pageControlStyle==PageControlStylePressed1 || self.pageControlStyle==PageControlStylePressed2)
        {
            if (self.pageControlStyle==PageControlStylePressed1)
            {
                CGContextSetFillColorWithColor(myContext, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2-1,adiameter,adiameter));
            }
            else if (self.pageControlStyle==PageControlStylePressed2)
            {
                CGContextSetFillColorWithColor(myContext, [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2+1,adiameter,adiameter));
            }
            
            
            if (i==self.currentPage)
            {
                CGContextSetFillColorWithColor(myContext, [acoreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
                CGContextSetStrokeColorWithColor(myContext, [astrokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
            else
            {
                CGContextSetFillColorWithColor(myContext, [acoreNormalColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
                CGContextSetStrokeColorWithColor(myContext, [astrokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter));
            }
        }
        else if (self.pageControlStyle==PageControlStyleThumb)
        {
            if (self.thumbImage && self.selectedThumbImage)
            {
                if (i==self.currentPage)
                {
                    [self.selectedThumbImage drawInRect:CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter)];
                }
                else
                {
                    [self.thumbImage drawInRect:CGRectMake(x,(self.frame.size.height-adiameter)/2,adiameter,adiameter)];
                }
            }
        }
	}
}


- (void)dealloc
{
    self.coreSelectedColor = nil;
    self.coreNormalColor = nil;
    self.strokeNormalColor = nil;
    self.strokeSelectedColor = nil;
    
}

- (void)setPageControlStyle:(PageControlStyle)style
{
    _pageControlStyle = style;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(int)page
{
    _currentPage = page;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(int)numOfPages
{
    _numberOfPages = numOfPages;
    [self setNeedsDisplay];
}

@end
