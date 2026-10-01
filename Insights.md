### Hardware vs. Software Distinctions

* **Execution Paradigm:** Unlike software, which executes sequentially step-by-step and calculates only what is selected (e.g., an `if/else` in a calculator program), designing an ALU requires placing actual physical circuits that process signals continuously.
* **Parallel Computation:** Signals for operands are available to all internal logic gates simultaneously. Therefore, **all results are calculated in parallel, and a Multiplexer (MUX) simply selects which computed result reaches the final output.**
* **Power Implications:** Because all internal logic blocks evaluate simultaneously regardless of which operation is chosen, unnecessary power is supplied to and consumed by unselected gates.
* **Low-Power Design Solutions to be explored:**
  * **Switching / Dynamic Power:** The power consumed whenever logic gates flip states ($0 \to 1$ or $1 \to 0$) during continuous, parallel computation.
  * **Clock Gating:** Disables the clock signal to inactive circuit blocks to prevent unnecessary state toggling.
  * **Operand Isolation:** Prevents input signals from propagating into inactive sub-blocks when their outputs are not selected by the MUX, cutting down redundant dynamic power.
