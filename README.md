# CPE 463 - Activity No. 3: Basic Assembly Graphics

## Description
This activity enables the students to create a simplified directive assembly program environment that would display graphical outputs.

## Course Information
* **Course:** CPE463 (Comp.Org with Assembly Lang.)
* **Topics Covered:** Basic Assembly[cite: 2]
* **Name:** Wilfred Justin D. Peteros 
* **Section:** BSCpE - 4

## Objectives
* To develop an assembly program with simple programming structure.
* To use clear screen and set cursor functions for graphical displays.

## How It Works
This 16-bit DOS Assembly program utilizes low-level hardware interrupts to render a colorful text-mode user interface:
* **Drawing Blocks (INT 10h, AH=06h):** Calls BIOS video services to scroll or clear the window. By setting specific coordinates (CH, CL for top-left; DH, DL for bottom-right) and a color attribute (BH), it draws the background, the top banner, the main center rectangle, and the vertical side stripes.
* **Positioning (INT 10h, AH=02h):** Moves the blinking cursor to precise rows and columns before placing text.
* **Printing Text (INT 21h, AH=09h):** Calls DOS services to print the string variables (stored in the data segment and terminated with a `$`) at the established cursor positions.
* **Program Exit (INT 21h, AH=4Ch):** Safely terminates the program and returns control to the operating system without overwriting the drawn interface.

## Prerequisites & Execution
To run this code on a modern operating system:
1. Install **Visual Studio Code**.
2. Install the **MASM/TASM** extension (by dosxrelau).
3. Open the `activity3.asm` file, right-click inside the editor, and select **Run ASM code**. The extension will automatically bundle DOSBox and execute the graphical interface.
