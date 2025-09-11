import sys

def bwt(s: str):
    # build Burrows-Wheeler Transform using suffix array
    SA = sa(s)
    return [s[i-1] for i in SA]
            
def sa(s: str):
    # return suffix array (sorted suffix indices)
    srange = range(len(s))
    return sorted(srange, key=lambda i: s[i:])

def ct(s: str):
    # count table: first occurrence of each char in sorted text
    ss = sorted(s)
    cdic = {}
    for i, char in enumerate(ss):
        if char not in cdic:
            cdic[char] = i
    return cdic

def occ(s: str, bwt: str):
    # occurrence table: prefix counts of each char in BWT
    ls = len(s) + 1
    occ = {}
    for i in set(s):
        occ[i] = [[0] for i in range(ls)]
    j = 1
    for i in bwt:
        occ[i][j:] = [[x[0] + 1] for x in occ[i][j:]]
        j += 1
    return occ

def qfinder(s: str, q: str):
    # backward search for query q in string s
    s += "$"
    CT = ct(s)
    BWT = bwt(s)
    OCC = occ(s, BWT)
    SA = sa(s)

    top = 1
    bot = len(s)
    for c in q[::-1]:
        top = CT[c] + OCC[c][top][0]
        bot = CT[c] + OCC[c][bot][0]
        print("bot", bot, "top", top, "char", c)

    return sorted(SA[top-1:bot])

if __name__ == "__main__":

    string = sys.argv[1]
    query = sys.argv[2]

    qfinder(string, query) 

    for i in
    