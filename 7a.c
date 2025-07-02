#include <stdio.h>
#include <fcntl.h> // Note: fcntl.h and unistd.h are not needed for this program
#include <setjmp.h>
#include <stdlib.h>

static jmp_buf buf;

static void f2(void) {
    // 4. JUMP! This restores the CPU state to what it was at step 2.
    // The stack pointer jumps back, and execution resumes inside the 'if'.
    longjmp(buf, 1);
}

static void f1(int i, int j, int k, int l, int m) {
    // 3. This function is called. Its arguments are on the stack.
    printf("in f1(): gv: %d, av: %d, vv: %d, rv: %d, sv: %d\n", i, j, k, l, m);
    f2();
}

int main(void) {
    static int gv = 1;      // Global scope, lives in data segment. Value is 1.
    int av = 2;             // Auto local. Compiler will likely try to put this in a register. Value is 2.
    volatile int vv = 3;    // Volatile. MUST live in memory on the stack. Value is 3.
    register int rv = 4;    // Register hint. Almost certainly in a register. Value is 4.
    static int sv = 5;      // Static local, lives in data segment like a global. Value is 5.

    // 1. setjmp is called for the first time.
    // It saves the state of the CPU registers and the stack pointer.
    // It returns 0, so the 'if' block is skipped.
    if (setjmp(buf) != 0) {
        // 5. Execution resumes here after longjmp.
        // setjmp now returns 1.
        printf("\nafter longjmp:\n");
        
        // --- PRINTING THE VALUES ---
        // gv: Lives in memory. Its value is still 95.
        // av: LIVES IN A REGISTER. longjmp restored the old register value, so it's 2 again.
        // vv: VOLATILE, lives in memory. Its value is still 97.
        // rv: REGISTER, lives in a register. longjmp restored the old register value, so it's 4 again.
        // sv: Lives in memory. Its value is still 99.
        printf("gv: %d, av: %d, vv: %d, rv: %d, sv: %d\n", gv, av, vv, rv, sv);
        
        return 1;
    }

    // 2. We are in the 'else' part of the first run.
    // Modify all the variables.
    gv = 95;
    av = 96;
    vv = 97; // This write goes directly to memory.
    rv = 98;
    sv = 99;

    printf("before f1():\n");
    printf("gv: %d, av: %d, vv: %d, rv: %d, sv: %d\n", gv, av, vv, rv, sv);

    f1(gv, av, vv, rv, sv);
    
    return 0; // This line is never reached.
}