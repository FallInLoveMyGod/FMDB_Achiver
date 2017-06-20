//
//  ViewController.m
//  FMDB_Demo
//
//  Created by 田耀琦 on 2017/6/19.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

// http://www.cnblogs.com/ios8/p/ios-archive.html 归档参考
// UIImage 不可直接存储

#import "ViewController.h"
#import "FMDBManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testArchiver];
    
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // 基础数据对象类型可直接归档
    NSString *homeDic = NSHomeDirectory();
    NSString *path = [homeDic stringByAppendingPathComponent:@"haha"];
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UIImage imageNamed:@"1.jpg"] toFile:path];
    NSLog(@"%d",flag);
    
}
// FMDB
- (void)testFMDB {
    UserModel *model = [[UserModel alloc] init];
    model.userName = @"haha";
    model.age = 15;
    model.image = [UIImage imageNamed:@"1.jpg"];
    [[FMDBManager shareInstance] insertUser:model];
    
    NSArray *arr = [[FMDBManager shareInstance] selectAllUsers];
    for (UserModel *temp in arr) {
        NSLog(@"userName:%@,age:%ld,image:%@",temp.userName,(long)temp.age,temp.image);
    }

}

// 归档
- (void)testArchiver {
    UserModel *model = [[UserModel alloc] init];
    model.userName = @"ggogog666";
    model.age = 13;
    model.image = [UIImage imageNamed:@"1.jpg"];
    NSLog(@"image = %@",model.image);
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:model forKey:@"user"];
    [archiver finishEncoding];
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingString:@"/users"];
    [data writeToFile:path atomically:YES];
}

// 解档
- (void)testUnarchiver {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingString:@"/users"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    UserModel *model = [unarchiver decodeObjectForKey:@"user"];
    [unarchiver finishDecoding];
    
    NSLog(@"userName = %@,age = %ld,image = %@",model.userName,(long)model.age ,model.image);
}

- (void)btnAction:(id)btn {
    //[self testUnarchiver];
    NSString *homeDic = NSHomeDirectory();
    NSString *path = [homeDic stringByAppendingPathComponent:@"haha"];

    NSString *image = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",image);
}








@end
