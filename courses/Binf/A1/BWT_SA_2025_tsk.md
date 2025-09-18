-----

### **Assignment: BWT, Suffix Array, and FM-Index Implementation**

**Objective:** The goal of this assignment is to implement the core components of the Burrows-Wheeler Transform (BWT) and the FM-Index for substring searching. This will solidify your understanding of how these powerful bioinformatics algorithms work.

-----

### **Tasks**

You will implement three main functionalities in Python. You may only use modules from the standard Python library.

1.  **BWT Computation**: Write a function to compute the Burrows-Wheeler Transform of an arbitrary DNA sequence. The alphabet to consider is `$ACGTN`, where `$` is the lexicographically smallest character.
2.  **BWT Inversion**: Write a function to perfectly reconstruct the original DNA sequence from its BWT string.
3.  **FM-Index Search**: Implement the complete backward search algorithm to find all occurrences of a query string within a larger text. Your implementation must report the 0-based starting positions of all matches.

-----

### **Deliverables and Usage**

You must deliver two Python files. Please replace `<name>` with your own name (e.g., `julian_regalado`).

#### **1. `<name>_bwt.py`**

This file will handle BWT construction and inversion. It must be executable from the command line as follows:

  * **To compute the BWT:**

    ```bash
    python <name>_bwt.py bwt <string>
    ```

    *Example:*

    ```bash
    $ python julian_regalado_bwt.py bwt ACGTTGTGC
    C$GATTCGTG
    ```

  * **To invert the BWT:**

    ```bash
    python <name>_bwt.py unbwt <bwt_string>
    ```

    *Example:*

    ```bash
    $ python julian_regalado_bwt.py unbwt C$GATTCGTG
    ACGTTGTGC$
    ```

#### **2. `<name>_fmi.py`**

This file will handle the FM-Index search. It must be executable from the command line and print the number of occurrences, followed by the 0-based positions, each on a new line.

  * **To search for a substring:**
    ```bash
    python <name>_fmi.py <string> <query>
    ```
    *Example:*
    ```bash
    $ python julian_regalado_fmi.py AACCGTCGGTTCGTAC CGT
    3
    11
    ```

-----

### **Hints and Guidelines**

  * Your implementation will be tested with strings up to **1,000 characters** and query patterns up to **100 characters**.
  * It's recommended to compute the BWT from the **Suffix Array**, as this is more efficient than computing and sorting all rotations.
  * A complete FM-Index requires four main data structures: the **BWT string (`L`)**, the **Counts table (`C`)**, the **Occurrences table (`Occ`)**, and the **Suffix Array (`SA`)**.
  * The use of AI tools like Gemini or GPT to help you understand concepts and debug code is **allowed and encouraged**.

-----

### **Grading Criteria**

  * **Correctness**: The assignment will be graded solely on the correctness of the output. Your code must produce the expected results for all test cases. Performance and memory efficiency will not be graded.
