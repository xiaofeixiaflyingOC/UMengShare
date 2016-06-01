//
//  ViewController.m
//  UMengShare
//
//  Created by shengxin on 16/5/31.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "ViewController.h"
#import "ShareModelHelper.h"
#import "ShareActionManager.h"
#import "ShareActionModel.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *iPlatformTextArr;
@property (nonatomic, strong) NSArray *iPlatformArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享(及时刷新)" style:UIBarButtonItemStyleDone target:self action:@selector(sharePress:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)sharePress:(id)sender{
    self.iPlatformArr = [[ShareModelHelper sharedInstance] getSharePlatformTypeAndIsComeInternal:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"微信好友", [NSNumber numberWithInt:kSharePlatformWXSceneSession],@"微信朋友圈", [NSNumber numberWithInt:kSharePlatformWXSceneTimeline],@"QQ空间", [NSNumber numberWithInt:kSharePlatformQQZone],@"QQ好友", [NSNumber numberWithInt:kSharePlatformQQFriends],@"新浪微博", [NSNumber numberWithInt:kSharePlatformSinaWeibo],@"邮件", [NSNumber numberWithInt:kSharePlatformEmail],@"复制链接", [NSNumber numberWithInt:kShareCopyLink],@"浏览器打开", [NSNumber numberWithInt:kShareOpenUrlWithSafari],@"刷新", [NSNumber numberWithInt:kShareRefresh],nil];
    self.iPlatformTextArr = [NSMutableArray array];
    for(id key in  self.iPlatformArr){
        [ self.iPlatformTextArr  addObject:[dict objectForKey:key]];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.iPlatformTextArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = [self.iPlatformTextArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kSharePlatformType type = [[self.iPlatformArr objectAtIndex:indexPath.row] integerValue];
    
    ShareActionModel *model = [[ShareActionModel alloc] init];
    model.shareUrl = @"http://m.zol.com.cn/article/5848683.html?site=zolapp";
    model.wxImageUrl = @"http://article.fd.zol-img.com.cn/t_s160x120c4/g5/M00/0E/05/ChMkJ1dFCV6Ifo77AAEDStvs_HgAAR23QHe__EAAQNi151.jpg";
    model.titleStr = @"3GB内存/10核心  腾讯OS手机配置曝光";
    model.commentStr = @"中关村在线消息：我们刚刚报道过腾讯将联手富可视在5月30日推出首款搭载TencentOS系统的新机。官方只公布了发布时间";
    model.shareImageUrl = @"http://article.fd.zol-img.com.cn/t_s160x120c4/g5/M00/0E/05/ChMkJ1dFCV6Ifo77AAEDStvs_HgAAR23QHe__EAAQNi151.jpg";
    [[ShareActionManager shareInstance] shareToPlatformType:type FromViewController:self andPostShareModel:model];
}

@end
