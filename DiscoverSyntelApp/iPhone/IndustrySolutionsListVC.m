//
//  IndustrySolutionsListVC.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 12/13/16.
//  Copyright © 2016 Mobile Computing. All rights reserved.
//

#import "IndustrySolutionsListVC.h"

@interface IndustrySolutionsListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *industrySolutionList;
}
@end

@implementation IndustrySolutionsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndustrySolutions"];
    if(cell ==  nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndustrySolutions"];
    }
    
    IndustrySolutionsData *industrySolData = [industrySolutionList objectAtIndex:indexPath.row];
    [cell.textLabel setText:industrySolData.title];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IndustrySolutionsData *industrySolData = [industrySolutionList objectAtIndex:indexPath.row];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return industrySolutionList.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
