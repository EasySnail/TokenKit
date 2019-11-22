//
//  BaseTextFieldController.m
//  TokenKit
//
//  Created by easy on 2019/11/19.
//  Copyright © 2019 easy. All rights reserved.
//

#import "BaseTextFieldController.h"

@interface BaseTextFieldController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseTextFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor colorWithWhite:0xdd/255.0 alpha:1];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArray[indexPath.row].cellHeight;
}

#pragma mark - 监听键盘

- (void)keyboardWillShow:(NSNotification *)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    CGFloat dy = [self.tableView convertPoint:CGPointMake(0, self.tableView.frame.size.height) toView:[UIApplication sharedApplication].keyWindow].y;
     CGFloat sheight = [UIScreen mainScreen].bounds.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight - (sheight-dy), 0);
}

- (void)keyboardWillHidden:(NSNotification *)notification{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    if (parent == nil) {
        [self removeKeyboardObserver];
    }else{
        [self addKeyboardObserver];
    }
}

- (void)addKeyboardObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeKeyboardObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



@interface JTextFieldCell()<UITextFieldDelegate>
@property(nonatomic,retain)UILabel *jLabel;
@end
@implementation JTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellHeight = 80;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.jLabel = [[UILabel alloc] init];
        _jLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_jLabel];
        
        self.textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = [UIColor darkGrayColor];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_textField];
        
        
        [_jLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(40);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
- (void)updateTitle:(NSString *)title{
    self.jLabel.text = title;
    self.textField.placeholder = [NSString stringWithFormat:@"请输入%@",title];
}

@end
