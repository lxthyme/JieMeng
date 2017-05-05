//
//  PhotoListVC.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/4.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "PhotoListVC.h"

#import <SnapKit/SnapKit-Swift.h>
#import "PhotoCell.h"

#import "LXCAAnimation-Swift.h"

#define kCellReuseIdentifier @"kCellReuseIdentifier"
@interface PhotoListVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
{

}
@property (nonatomic,retain)UICollectionView *collection;
@end

@implementation PhotoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)setup {
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.view addSubview:self.collection];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:@"cuk.png"];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
#pragma mark - collection
- (UICollectionView *)collection {
    if(!_collection){
        _collection = [Component _collectionViewWithItemSize:CGSizeMake(Component.mWidth, Component.mHeight)];
    }
    return _collection;
}
- (void)masonry {
    self.collection.snma
}

@end
