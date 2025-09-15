import sys
# Suffix Array
def sa(s: str) -> str:
    # sort suffixes lexicographically, return start indices as list
    srange = range(len(s))
    return sorted(srange, key=lambda i: s[i:])

# Burrows–Wheeler Transform
def bwt(s: str) -> str:
    # build suffix array 
    SA = sa(s)

    # take char before each suffix
    return "".join([s[i-1] for i in SA])

def unbwt(bwt: str) -> str:
    # build rotation matrix
    n = len(bwt)
    table = [""] * n
    for _ in range(n):
        table = sorted([bwt[i] + table[i] for i in range(n)])
    
    # pick row ending with "$"
    for row in table:
        if row.endswith("$"):
            return row


if __name__ == "__main__":
    # save input commands
    command = sys.argv[1]
    text = sys.argv[2]

    # determine funciton
    if command == "bwt":
        if text[-1] != "$":
            text += "$"
        print(bwt(str(text)))
    elif command == "unbwt":
        print(unbwt(text))
    else:
        print("Unknown command:", command)
        print("Usage: python <name>_bwt.py [bwt|unbwt] <string>")