class Solution:
    def mostCommonWord(self, paragraph: str, banned: List[str]) -> str:
        import re
        p = re.sub(r"[!?',;.]"," ",paragraph.lower())
        maxi = 0
        occ = {}
        maxi_v = ""
        for i in p.split():
            if i not in banned:
                if i in occ:
                    occ[i]+=1 
                else:
                    occ[i]=1
                if occ[i]>maxi:
                            maxi = occ[i]
                            maxi_v = i
        return maxi_v