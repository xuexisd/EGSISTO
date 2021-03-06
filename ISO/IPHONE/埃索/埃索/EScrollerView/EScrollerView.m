//
//  EScrollerView.m
//  埃索
//
//  Created by yeetong on 13-7-7.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "EScrollerView.h"
#import "UIImageView+AFNetworking.h"

@implementation EScrollerView
@synthesize delegate;

-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr
{
    
	if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
        titleArray=titArr;
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
        [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
        [tempArray addObject:[imgArr objectAtIndex:0]];
		imageArray=[NSArray arrayWithArray:tempArray];
		viewSize=rect;
        NSUInteger pageCount=[imageArray count];
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        for (int i=0; i<pageCount; i++) {
            NSString *imgURL=[imageArray objectAtIndex:i];
            UIImageView *imgView=[[UIImageView alloc] init];
            //UIImageView *showImgView=[[UIImageView alloc] init];
            if ([imgURL hasPrefix:@"http://"]) {
                //网络图片
                //[imgView setImageWithURL:[NSURL URLWithString:imgURL]];
                
                NSArray *pathList=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *firstDocument=[pathList objectAtIndex:0];
                NSString *path=[firstDocument stringByAppendingPathComponent:@"ESSOHTTPClientImages/"];
                
                //Store this image on the same server as the weather canned files
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imgURL]];
                AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                                    imageProcessingBlock:nil
                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                                    imgView.image = image;  
                                                                                    [self saveImage:image withFilename:[imgURL lastPathComponent]];
                                                                                }
                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                                    UIImage *img=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,[imgURL lastPathComponent]]];
                                                                                    [imgView setImage:img];
                                                                                }];
                [operation start];
                
                
//                [showImgView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imgURL]]
//                                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
//                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                                   imgView.image = image;                                                   
//                                                   //only required if no placeholder is set to force the imageview on the cell to be laid out to house the new image.
//                                                   //if(showImgView.imageView.frame.size.height==0 || showImgView.imageView.frame.size.width==0 ){
//                                                   //[showImgView setNeedsLayout];
//                                                   //}
//                                               }
//                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                                   
//                                               }];
            }
            else
            {
                
                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
                [imgView setImage:img];
            }
            
            [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
            imgView.tag=i;
            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:Tap];
            [scrollView addSubview:imgView];
        }
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        [self addSubview:scrollView];
        
        
        
        //说明文字层
        UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
        [noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5]];
        
        float pageControlWidth=(pageCount-2)*10.0f+40.f;
        float pagecontrolHeight=20.0f;
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth),6, pageControlWidth, pagecontrolHeight)];
        pageControl.currentPage=0;
        pageControl.numberOfPages=(pageCount-2);
        [noteView addSubview:pageControl];
        
        noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 20)];
        [noteTitle setText:[titleArray objectAtIndex:0]];
        [noteTitle setBackgroundColor:[UIColor clearColor]];
        [noteTitle setFont:[UIFont systemFontOfSize:13]];
        [noteView addSubview:noteTitle];
        
        [self addSubview:noteView];
	}
	return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    
    pageControl.currentPage=(page-1);
    int titleIndex=page-1;
    if (titleIndex==[titleArray count]) {
        titleIndex=0;
    }
    if (titleIndex<0) {
        titleIndex=[titleArray count]-1;
    }
    [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (currentPageIndex==0) {
        
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
        
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        
    }
    
}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}

-(void)saveImage:(UIImage *)image withFilename:(NSString *)filename{
    
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ESSOHTTPClientImages/"];
	
    
    BOOL isDir;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
        if(!isDir){
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }
    }
    
    path = [path stringByAppendingPathComponent:filename];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:path atomically:YES];
}

@end