//
//  ViewController.m
//  Adonis_20170627_Algorithm
//
//  Created by Adonis_HongYang on 2018/6/27.
//  Copyright © 2018年 The Way Of University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** <#Description#> */
@property (nonatomic, strong) NSMutableArray *mTempArr;
@end

@implementation ViewController

- (NSMutableArray *)mTempArr {
    if (!_mTempArr) {
        _mTempArr = @[].mutableCopy;
    }
    return _mTempArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray *mutableArray = @[@1, @3, @2, @5, @7, @8, @10, @9, @6, @4].mutableCopy;
    self.mTempArr = mutableArray.mutableCopy;
    
//    [self bubbleSortWithMutableArray:mutableArray];
    //    [self selectionSortWithMutableArray:mutableArray];
    //    [self quickSortWithMutableArray:mutableArray leftIndex:1 rightIndex:5];
    //    [self mergeSortWithMutableArray:mutableArray lowIndex:0 highIndex:9];
    //    NSLog(@"%@/%@",mutableArray, self.mTempArr);
    //    [self reverseSortWithMutableArray:mutableArray];
//    [self binarySearchWithArray:mutableArray target:1];
    
//    [self gcdWithNumber1:10 Number2:20];
    
    NSLog(@"%s--最小公倍数: %ld", __func__, (long)[self lcmWithNumber1:31 Number2:10]);
    
}

/**
 冒泡排序   (依次循环旁边的比较放到后边去)
    最坏时间复杂度是O(n^2)
    平均时间复杂度：O(n^2)
    平均空间复杂度：O(1)
 1.比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 2.对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
 3.针对所有的元素重复以上的步骤，除了最后一个。
 4.持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。[1]
 
 @param mutableArray 排序的目标数组
 */
- (void)bubbleSortWithMutableArray:(NSMutableArray *)mutableArray {
    for (int i = 0; i < mutableArray.count - 1; i++) {
        for (int j = 0; j < mutableArray.count - 1 -i; j++) {
            if (mutableArray[j] > mutableArray[j+1] ) {
                id temp = mutableArray[j];
                mutableArray[j] = mutableArray[j+1];
                mutableArray[j+1] = temp;
            }
        }
    }
    NSLog(@"%s-冒泡排序: %@", __func__, mutableArray);
}


/**
 选择排序   (拿前边的和后边的依次比较放到前边去，就是先排好前边的)
 每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完。
 最好时间复杂度是O(n)
 最坏时间复杂度是O(n^2)
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 @param mutableArray 排序的目标数组
 */
- (void)selectionSortWithMutableArray:(NSMutableArray *)mutableArray {
    for (int i = 0; i < mutableArray.count; i++) {
        int index = i;
        for (int j = i+1; j < mutableArray.count; j++) {
            if (mutableArray[index] > mutableArray[j]) {
                index = j;
            }
        }
        if (index != i) {
            NSString *temp = mutableArray[i];
            mutableArray[i] = mutableArray[index];
            mutableArray[index] = temp;
        }
    }
    NSLog(@"%s-选择排序: %@", __func__, mutableArray);
}

/**
 快速排序
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
 @param mutableArray 排序的数组
 @param leftIndex 左边索引
 @param rightIndex 右边索引
 */
- (void)quickSortWithMutableArray:(NSMutableArray *)mutableArray leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    if (leftIndex >= rightIndex) {
        return;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准
    NSInteger key = [mutableArray[i] integerValue];
    while (i < j) {
        // 先从右边j开始查找比基准数小的值
        // 如果比基准数大，继续查找
        while (i < j && [mutableArray[j] integerValue] >= key) {
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        mutableArray[i] = mutableArray[j];
        
        // 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值
        // 如果比基准数小，继续查找
        while (i < j && [mutableArray[i] integerValue] <= key) {
            i++;
        }
        
        // 如果比基准数大，则将查找到的大值调换到j的位置
        mutableArray[j] = mutableArray[i];
    }
    
    //一轮遍历完成后就能确认基准数的位置了，并调整到正确位置
    mutableArray[i] = @(key);
    
    // 排序后，从基准数位置将数据分为两部分，递归运算
    [self quickSortWithMutableArray:mutableArray leftIndex:leftIndex rightIndex:i-1];
    [self quickSortWithMutableArray:mutableArray leftIndex:i+1 rightIndex:rightIndex];
    
    NSLog(@"%s-快速排序: %@", __func__, mutableArray);
}



/**
  归并排序
 归并过程为：比较a[i]和b[j]的大小，若a[i]≤b[j]，则将第一个有序表中的元素a[i]复制到r[k]中，并令i和k分别加上1；否则将第二个有序表中的元素b[j]复制到r[k]中，并令j和k分别加上1，如此循环下去，直到其中一个有序表取完，然后再将另一个有序表中剩余的元素复制到r中从下标k到下标t的单元。归并排序的算法我们通常用递归实现，先把待排序区间[s,t]以中点二分，接着把左边子区间排序，再把右边子区间排序，最后把左区间和右区间用一次归并操作合并成有序的区间[s,t]。
 归并算法并不难理解，但代码的递归实现有点难理解，可在程序中打断点一步一步的理解。
 
 @param array 排序数组
 */
- (void)mergeSortArray:(NSMutableArray *)array {
    //创建一个副本数组
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    
    //对数组进行第一次二分，初始范围为0到array.count-1
    [self mergeSort:array auxiliary:auxiliaryArray low:0 high:array.count-1];
}
- (void)mergeSort:(NSMutableArray *)array auxiliary:(NSMutableArray *)auxiliaryArray low:(NSInteger)low high:(NSInteger)high {
    //递归跳出判断
    if (low>=high) {
        return;
    }
    //对分组进行二分
    NSInteger middle = (high - low)/2 + low;
    
    //对左侧的分组进行递归二分 low为第一个元素索引，middle为最后一个元素索引
    [self mergeSort:array auxiliary:auxiliaryArray low:low high:middle];
    
    //对右侧的分组进行递归二分 middle+1为第一个元素的索引，high为最后一个元素的索引
    [self mergeSort:array auxiliary:auxiliaryArray low:middle + 1 high:high];
    
    //对每个有序数组进行回归合并
    [self merge:array auxiliary:auxiliaryArray low:low middel:middle high:high];
}

- (void)merge:(NSMutableArray *)array auxiliary:(NSMutableArray *)auxiliaryArray low:(NSInteger)low middel:(NSInteger)middle high:(NSInteger)high {
    //将数组元素复制到副本
    for (NSInteger i=low; i<=high; i++) {
        auxiliaryArray[i] = array[i];
    }
    //左侧数组标记
    NSInteger leftIndex = low;
    //右侧数组标记
    NSInteger rightIndex = middle + 1;
    
    //比较完成后比较小的元素要放的位置标记
    NSInteger currentIndex = low;
    
    while (leftIndex <= middle && rightIndex <= high) {
        //此处是使用NSNumber进行的比较，你也可以转成NSInteger再比较
        if ([auxiliaryArray[leftIndex] compare:auxiliaryArray[rightIndex]]!=NSOrderedDescending) {
            //左侧标记的元素小于等于右侧标记的元素
            array[currentIndex] = auxiliaryArray[leftIndex];
            currentIndex++;
            leftIndex++;
        }else{
            //右侧标记的元素小于左侧标记的元素
            array[currentIndex] = auxiliaryArray[rightIndex];
            currentIndex++;
            rightIndex++;
        }
    }
    //如果完成后左侧数组有剩余
    if (leftIndex <= middle) {
        for (int i = 0; i<=middle - leftIndex; i++) {
            array[currentIndex +i] = auxiliaryArray[leftIndex +i ];
        }
    }
}


/**
 逆序排列
 就是将一串数列前后颠倒排序。
 这个在iOS中直接有API，直接调用reverseObjectEnumerator就好了，十分方便。
 如果不用系统自带的，也可以自己创建一个可变数组，从后往前取目标数组的值就好了。
 
 @param mutableArray 参数要为可变数组
 */
- (void)reverseSortWithMutableArray:(NSMutableArray *)mutableArray{
    
    NSArray *reversedArray = [[mutableArray reverseObjectEnumerator] allObjects];
    NSLog(@"倒序排序结果：%@",reversedArray);
}


/**
 二分法查找
 二分查找的前提是：数组必须是有序的。
 假设表中元素是按升序排列，将表中间位置记录的关键字与查找关键字比较，如果两者相等，则查找成功；否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的关键字大于查找关键字，则进一步查找前一子表，否则进一步查找后一子表。重复以上过程，直到找到满足条件的记录，使查找成功，或直到子表不存在为止，此时查找不成功
 
 @param orderArray 遍历的数组对象 (要求数组是有序的)
 @param target 目标值
 @return 返回目标值在数组中的 index，如果没有返回 -1
 */
- (NSUInteger)binarySearchWithArray:(NSArray *)orderArray target:(NSInteger)target {
    if (!orderArray.count) {
        return -1;
    }
    NSUInteger  low = 0;
    NSUInteger  high = orderArray.count - 1;
    int times = 0;
    while (low<=high) {
        NSUInteger mid = low + (high-low)/2;
        NSInteger  num = [[orderArray objectAtIndex:mid] integerValue];
        if (target == num) {
            NSLog(@"%s--查找%d次", __func__, times);
            return mid;
        }
        else if(num > target){
            high = mid -1;
        }
        else{
            low = mid +1;
        }
        times ++;
    }
    return -1;
}

/**
 最大公约数
 
 @param num1 整数1
 @param num2 整数2
 @return 返回两个整数的最大公约数
 */
- (NSInteger)gcdWithNumber1:(NSInteger)num1 Number2:(NSInteger)num2 {
    
    while(num1 != num2){
        if(num1 > num2){
            num1 = num1-num2;
        } else {
            num2 = num2-num1;
        }
    }
    NSLog(@"%s--最大公约数: %ld", __func__, (long)num1);
    return num1;
}

/**
 最小公倍数
 
 @param num1 整数1
 @param num2 整数2
 @return 返回两个整数的最小公倍数
 */
- (NSInteger)lcmWithNumber1:(NSInteger)num1 Number2:(NSInteger)num2{
    
    NSInteger gcd = [self gcdWithNumber1:num1 Number2:num2];
    // 最小公倍数 = 两整数的乘积 ÷ 最大公约数
    return num1 * num2 / gcd;
}


@end
