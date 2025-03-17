# Up-Down Counter in SystemVerilog

This project implements a **4-bit Up-Down Counter** in SystemVerilog and verifies its behavior using a testbench. The testbench demonstrates different types of concurrent execution using `fork...join`, `fork...join_any`, and `fork...join_none`.

---

## 📌 1️⃣ Module: `up_down_counter`
This module defines a **4-bit up-down counter** with the following functionalities:  
✅ **Counts Up or Down** based on `up_down` signal.  
✅ **Loads a preset value** when `load_en` is enabled.  
✅ **Resets to zero** when `rst` is active.  

---

## 📌 2️⃣ Testbench: `tb_up_down_counter`
The testbench performs verification using `fork...join`, `fork...join_any`, and `fork...join_none`.  
- **`fork...join`** – Ensures all verification tasks complete before moving forward.  
- **`fork...join_any`** – Proceeds as soon as any one task completes.  
- **`fork...join_none`** – Starts tasks but does not wait for completion.  

---

## 📌 3️⃣ Simulation Output  
The following output was generated using **VCS on EDA Playground**:

```
Checking count at 20, count= 1
Checking count at 30, count= 2
...
Checking count at 170, count= 0  // Counter rolled over
Checking count at 180, count= 1
...
All fork-join tasks completed at 210
[ANY] Loaded value = 5 at 225
At least one fork-join_any task completed at 225
All fork-join_none tasks started without waiting at 225
[NONE] Reset applied asynchronously at 240
[NONE] Up-Down toggled at 255, new mode = UP
[ANY] Down counting check, count= 0 at 260
[ANY] Up counting check, count= 3 at 290
[NONE] Final roll-over check passed at 425, count= 0
$finish at simulation time 625
```

---

## ✅ **Key Observations**
| **Fork Type**        | **Execution Behavior** |
|----------------------|----------------------|
| `fork...join`       | Waits for all tasks to finish before proceeding |
| `fork...join_any`   | Moves forward when **at least one** task finishes |
| `fork...join_none`  | Starts all tasks but **does not wait** for completion |

---

## 🚀 **How to Run the Simulation**
### **Using EDA Playground**
1. Open [EDA Playground](https://www.edaplayground.com/)
2. Select **Synopsys VCS** as the simulator
3. Copy and paste the code into the editor
4. Click **Run** and check the output

### **Using QuestaSim/VCS Locally**
1. Save the files as `up_down_counter.sv` and `tb_up_down_counter.sv`
2. Compile:  
   ```bash
   vlogan -sverilog up_down_counter.sv tb_up_down_counter.sv
   ```
3. Simulate:  
   ```bash
   vcs -R tb_up_down_counter
   ```
4. View the output in the console.

---

## 📌 **Conclusion**
- This project successfully demonstrates **SystemVerilog concurrency** using `fork...join`, `fork...join_any`, and `fork...join_none`.
- The testbench ensures **proper functionality of the Up-Down Counter**.
- **EDA Playground & VCS** were used for simulation.

---
Happy Coding! 🚀
