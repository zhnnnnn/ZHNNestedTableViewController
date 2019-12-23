# ZHNNestedTableViewController
 <div  align="center">    
 <img src="https://raw.githubusercontent.com/zhnnnnn/ZHNNestedTableViewController/master/demo.gif" width = "218" height = "440" alt="图片名称" align=center />
 </div>
 
 ## 0x0 结构
 嵌套首页的一般结构如下：
 -- tableView
 
  -- section1
  
   -- cells
   
  -- section2
  
   -- cell
   
    -- pageControl
    
    -- pageScrollView
    
     -- tableViews
     
     
 ## 0x1 使用
 1.ViewController继承`ZHNNestedPageViewController`
 
 2.针对上面tableView section1部分的数据实现如下方法

` - (NSInteger)ZHNNestedPageNumOfRowsInMainTableView:(UITableView *)tableView;`
 
` - (CGFloat)ZHNNestedPageMainTableView:(UITableView *)tableView heightForRow:(NSInteger)row;`
    
` - (UITableViewCell *)ZHNNestedPageMainTableView:(UITableView *)tableView cellforRow:(NSInteger)row;`

 
 3.针对下半部分section2的数据需要实现一个继承自`ZHNNestedPageTableViewCell`的cell
 
 4.cell里pageScrollView里的tableViews需要添加到cell`contentScrollViews`里
 
 5.pageControl需要通过`- (CGFloat)pageControlHeight;`返回一个高度
 
 6.pageScrollView左右滑动的时候需要通过delegate的`- (void)ZHNNestedPageDidScrollViewScrollToCenter:(UIScrollView *)scrollView;`传递给控制器
 
 ## 0x2 warning
 功能思路很完美，但是没在项目中应用过，可能存在一些小问题。
 

