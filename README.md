# MIPS Assembly Sorting Program

## Overview
This MIPS assembly program implements a sorting algorithm for an integer array. The array is declared in the static data section, and it is reserved 20 bytes in memory (4 bytes per integer, and the array can hold up to 5 elements). The program also includes necessary string declarations for messages used during the implementation.

## Instructions
1. The program prompts for the number of array elements (between 0 and 5).
2. The user is asked to input the array elements.
3. The array is sorted using selection sort.
4. The sorted array is printed.
5. A final message is displayed indicating the program has finished execution.

## Requirements
- MIPS assembler (QTSPIM or MARS emulator recommended)
- Understanding of MIPS assembly language, stack operations, and memory management

## Notes
- The program handles nested function calls and ensures that the return address is properly saved and restored using the stack.
- The `sll` instruction is used to navigate through the array by shifting the address to point to the next integer in memory.
- The array size is limited to 5 elements, and memory space is allocated accordingly (20 bytes).
