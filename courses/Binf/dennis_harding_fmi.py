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
    # build empty occ tavble (dic) and and fill with values 
    ls = len(s) + 1
    occ = {c: [0] * ls for c in set(s)}
    for j, char in enumerate(bwt, start=1):
        for c in occ:
            occ[c][j] = occ[c][j-1] + (1 if c == char else 0)
    return occ


def qfinder(s: str, q: str):
    # backward search for query q in string s
    s += "$"
    CT = ct(s)
    BWT = bwt(s)
    OCC = occ(s, BWT)
    SA = sa(s)

    top, bot = 0, len(s)
    for c in q[::-1]:
        top = CT[c] + OCC[c][top]
        bot = CT[c] + OCC[c][bot]

    if top > bot:
        return "substring does not exist"

    return "\n".join(map(str, sorted(SA[top:bot])))

if __name__ == "__main__":
    try:
        string = sys.argv[1]
        query = sys.argv[2]
    except IndexError:
        print("use format: python <dennis_harding_fmi.py <string> <query>")
    except NameError:
        print("use format: python <dennis_harding_fmi.py <string> <query>")

    if type(string) == str and type(query) == str and len(string) > len(query):
        print(qfinder(string, query))
    elif len(string) < len(query):
        print("query needs to be shorter than string")
    else:
        print("use format: python <dennis_harding_fmi.py <string> <query>")