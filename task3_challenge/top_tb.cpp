#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"
#include "vbuddy.cpp" // include vbuddy code
#define MAX_SIM_CYC 100000

int main(int argc, char **argv, char **env)
{
    int simcyc;     // SIMULATION CLOCK
    int tick;       // TWO TICKS FOR ONE CLOCK CYCLE


    Verilated::commandArgs(argc, argv);
    Vtop *top = new Vtop;
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("NAME.vcd");

    if (vbdOpen() != 1) return (-1);
    vbdHeader("TITLE");
    vbdSetMode(1);

    // INITIALISATIONS
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->Number = vbdValue();

    // MAIN CLOCK CYCLES
    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // DUMP LOOP
        for (tick = 0; tick < 2; tick++)
        {
            tfp->dump(2 * simcyc + tick);
            top->clk = !top->clk;
            top->eval();
        }

        // EXTRA CODE HERE
        top->rst = (simcyc < 2);
        top->en = (simcyc > 2);
        top->Number = vbdValue(); 
        vbdBar(top->dout);

        if (Verilated::gotFinish() || (vbdGetkey() == 'q')) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}
