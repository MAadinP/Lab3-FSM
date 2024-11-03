#include "vbuddy.cpp"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1_fsm.h"

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {

    int simcyc;     // simulation clock count
    int tick;       // each clk cycle has two ticks for two edges    

    Verilated::commandArgs(argc, argv);
    Vf1_fsm* top = new Vf1_fsm;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sigdelay.vcd");

    if (vbdOpen()!=1) return(-1);
    vbdHeader("L3T2:Delay");
    vbdSetMode(1);

    for(simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {

    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval();
    }

    top->en = vbdFlag();
    top->rst = (simcyc < 2);
    vbdBar(top->data_out & 0xFF);

    vbdCycle(simcyc);

    // either simulation finished, or 'q' is pressed
    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) exit(0);

    }
}