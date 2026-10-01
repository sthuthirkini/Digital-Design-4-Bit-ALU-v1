# Digital-Design-4-Bit-ALU-v1
## Mental Model

An ALU is a physical datapath containing logic circuitry capable of performing multiple operations. Control signals determine which result is selected and how shared hardware behaves.

---

### Key Principles

* **Physical Datapath:** Operands flow through physical logic circuits (adders, logic gates) that compute operations in parallel.
* **Control Signals:** Act as selector lines (e.g., controlling a multiplexer) to determine which computed result is passed to the output.
* **Shared Hardware:** Components like full adders are reused across multiple operations (e.g., addition and subtraction via 2's complement) rather than duplicating circuitry.

### Operations: Basic Operations Are Physical Logic

#### Addition and Subtraction: Hardware Idea
The same full adder hardware can be reused for both addition and subtraction. A ripple carry adder connects 4 full adders together, where the carry must propagate from the least significant bit (LSB) toward the most significant bit (MSB).

* **Performance Impact:** This carry propagation creates a **ripple-carry delay**, as each subsequent stage must wait for the carry bit of the previous stage to settle before producing its final result.
* Subtraction can be done by using addition: $A - B$ is $A + \text{(2's complement of } B\text{)}$.
* Coincidentally, after given a specific encoding, the subtraction operation signal itself can be used as a condition in the adder: if the sub encoding matches op, $C_{in} = 1$.
* $B$ becomes a modified $B$ which is its bits inverted.
* When passed as input to the adder instance, we get the sum $A + \sim B + 1$, which is essentially $A - B$.
* Note that modified $B$ is obtained by XORing $B$ with 1 (needed when `sub = 1`).
* If $B$ is to be retained as it is, XOR $B$ with 0 (during the addition case, when `sub = 0`).

# Post Calculation of Operations
* **Operation Encoding:** Each ALU operation is assigned a unique binary control code
* * **Multiplexer Selection:** The encoded control signals act as select lines for a Multiplexer (MUX).
  * The input to the MUX are the already computed results of inidividial operations,ready to be assigned to final result of ALU as per the select lines(encodings of operations).
* **Output Assignment:** The MUX filters out the unused results and assigns only the selected operation's output to the final result line.
