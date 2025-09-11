import sys
# Suffix Array
def sa(s: str):
    # sort suffixes lexicographically, return start indices
    srange = range(len(s))
    return sorted(srange, key=lambda i: s[i:])

# Burrows–Wheeler Transform
def bwt(s: str):
    # build suffix array, take char before each suffix
    if s[-1] =! "$":
        s + "$"
    SA = sa(s)
    return "".join([s[i-1] for i in SA])

def unbwt(bwt: str):
    # invert Burrows-Wheeler Transform
    n = len(bwt)
    table = [""] * n
    for _ in range(n):
        table = sorted([bwt[i] + table[i] for i in range(n)])
    for row in table:
        if row.endswith("$"):
            return row


if __name__ == "__main__":

    command = sys.argv[1]
    text = sys.argv[2]

    if command == "bwt":
        print(bwt(str(text)))
    elif command == "unbwt":
        print(unbwt(text))
    else:
        print("Unknown command:", command)
        print("Usage: python <name>_bwt.py [bwt|unbwt] <string>")
"""

print(unbwt(bwt("BANANA")))
"""