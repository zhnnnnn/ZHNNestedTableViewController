# ZHNNestedTableViewController
 <div  align="center">    
 <img src="https://raw.githubusercontent.com/zhnnnnn/ZHNNestedTableViewController/master/demo.gif" width = "218" height = "440" alt="图片名称" align=center />
 </div>
 
 ## 0x0 前言
 
  针对淘宝首页嵌套滑动的方案，几年前我也尝试过动力学模拟手势的方式来处理。代码在这里 -> https://github.com/zhnnnnn/bantang 这个方案并不完美，存在一系列的问题。现在针对这个效果找到了一个比较完美的实现方式，解决了手势穿透的问题，能够让阻尼减速在两个tableView直接完美传递。这边写个demo希望能帮到大家。
 
 ## 0x1 结构
 嵌套首页的一般结构如下：
 
 ```
 -- tableView
  
  -- section1
    
    -- cells
  
  -- section2
    
    -- cell
     
      -- pageControl
     
      -- pageScrollView
      
        -- tableViews
     
  ```
     
 ## 0x2 使用
 1.ViewController继承`ZHNNestedPageViewController`
 
 2.针对上面tableView section1部分的数据实现如下方法
 
```
 - (NSInteger)ZHNNestedPageNumOfRowsInMainTableView:(UITableView *)tableView;
 
 - (CGFloat)ZHNNestedPageMainTableView:(UITableView *)tableView heightForRow:(NSInteger)row;
   
 - (UITableViewCell *)ZHNNestedPageMainTableView:(UITableView *)tableView cellforRow:(NSInteger)row;
 
 ```

 
 3.针对下半部分section2的数据需要实现一个继承自`ZHNNestedPageTableViewCell`的cell
 
 4.cell里pageScrollView里的tableViews需要添加到cell`contentScrollViews`里
 
 5.pageControl需要通过`- (CGFloat)pageControlHeight;`返回一个高度
 
 6.pageScrollView左右滑动的时候需要通过delegate的`- (void)ZHNNestedPageDidScrollViewScrollToCenter:(UIScrollView *)scrollView;`传递给控制器
 
 ## 0x3 warning
 功能思路很完美，但是没在项目中应用过，可能存在一些小问题。
 

