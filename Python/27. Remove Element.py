'''
27. Remove Element

本人二流子沙雕解法。国内LC时间不对就不分享了，总之是挺快的。
'''
class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        go_on = True
        try:
            while go_on:
                nums1 = nums.copy()
                nums.remove(val) 
                if nums1 == nums:
                    go_on = False
        except:
            pass