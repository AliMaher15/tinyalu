if [file exists "work"] {vdel -all}
vlib work

# Comment out either the SystemVerilog or VHDL DUT.
# There can be only one!

transcript file log/RUN_LOG.log

#VHDL DUT
vcom -f dut.f

# SystemVerilog DUT
# vlog ../misc/tinyalu.sv

vlog -f tb.f
vopt top -o top_optimized  +acc +cover=sbfec+tinyalu(rtl).

vsim top_optimized -coverage +UVM_TESTNAME=fibonacci_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value fibonacci_test
coverage save functional_coverage/fibonacci_test.ucdb

vsim top_optimized -coverage +UVM_TESTNAME=parallel_test 
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value parallel_test
coverage save functional_coverage/parallel_test.ucdb

vsim top_optimized -coverage +UVM_TESTNAME=full_test 
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value full_test
coverage save functional_coverage/full_test.ucdb

vcover merge    functional_coverage/tinyalu.ucdb \
                functional_coverage/fibonacci_test.ucdb \
                functional_coverage/parallel_test.ucdb \
                functional_coverage/full_test.ucdb
                
vcover report functional_coverage/tinyalu.ucdb -cvg -details -output functional_coverage/tinyalu_coverage.txt

coverage report    -output code_coverage/short.txt

transcript file ()


#quit