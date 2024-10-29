#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f *.vcd

~/Documents/iac/lab0-devtools/tools/attach_usb.sh

# run Verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace top.sv --exe top_tb.cpp

# build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f Vtop.mk Vtop

# run executable simulation file
echo "\nRunning simulation"
obj_dir/Vtop
echo "\nSimulation completed"
