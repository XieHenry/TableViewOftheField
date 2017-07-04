//
//  ViewController.m
//  TableViewDemo
//
//  Created by XieHenry on 2017/7/4.
//  Copyright © 2017年 XieHenry. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "NSArray+SafeExtension.h"


@interface ViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UITableView *_tableView;
    NSMutableArray *_writeArray;
    NSInteger lastIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"UITextField文本消失解决demo";
    
    [self initTableView];
    [self initDataArray];
    
    [self setRightBarButtonItemTitle:@"提交"];
    
}

- (void)setRightBarButtonItemTitle:(NSString *)title {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = - 5;
    self.navigationItem.rightBarButtonItems = @[spacer,rightItem];
}


-(void)initDataArray {
    //1.首先对数据进行初始化，可以对初始数据进行为空赋值，防止崩溃，也为了进行无文本赋值，在下面插入的时候造成的后续问题
    _writeArray = [NSMutableArray array];
    
    for (int i=0; i<40; i++) {
        [_writeArray addObject:[NSString stringWithFormat:@""]];
    }
    [_tableView reloadData];

}


- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _writeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"id"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
    //2.对输入框tag绑定，并设置代理
    cell.label.tag = indexPath.row;
    cell.label.delegate = self;
    
 
    cell.label.text = [_writeArray safe_objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


//3.对输入的文本插入到数组中
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [_writeArray replaceObjectAtIndex:textField.tag withObject:textField.text];

}

//4.获取lastIndex
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    lastIndex = textField.tag;

    return YES;
}


- (void)rightAction {
    //5.对最后一个放弃第一响应者，才会对最后一个操作输入框插入数据
    TableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:lastIndex inSection:0]];
    [cell.label resignFirstResponder];
    
    NSLog(@"提交的数据---%@",_writeArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
