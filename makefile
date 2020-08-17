micomp: insmem adder reg_im_id reg_id_ex reg_ex_mem reg_mem_wb mux2_1 RegisterFile alu control datamem alu_control
	ghdl -a ../cpu.vhdl
	ghdl -c ../cpu.vhdl

insmem:
	ghdl -a ../InsMem/InsMem.vhdl
	ghdl -c ../InsMem/InsMem.vhdl

mux2_1:
	ghdl -a ../mux2_1_d/mux2_1.vhdl
	ghdl -c ../mux2_1_d/mux2_1.vhdl


adder:
	ghdl -a ../adder_d/adder.vhdl
	ghdl -c ../adder_d/adder.vhdl


reg_im_id:
	ghdl -a ../reg_im_id/reg_im_id.vhdl
	ghdl -c ../reg_im_id/reg_im_id.vhdl


reg_id_ex:
	ghdl -a ../reg_id_ex/reg_id_ex.vhdl
	ghdl -c ../reg_id_ex/reg_id_ex.vhdl


reg_ex_mem:
	ghdl -a ../reg_ex_mem/reg_ex_mem.vhdl
	ghdl -c ../reg_ex_mem/reg_ex_mem.vhdl

reg_mem_wb:
	ghdl -a ../reg_mem_wb/reg_mem_wb.vhdl
	ghdl -c ../reg_mem_wb/reg_mem_wb.vhdl

RegisterFile:
	ghdl -a ../RegFile/RegFile.vhdl
	ghdl -c ../RegFile/RegFile.vhdl

alu: neger divider multiplier adder mux2_1 mux8_1
	ghdl -a ../alu/alu.vhdl
	ghdl -c ../alu/alu.vhdl

mux8_1:
	ghdl -a ../mux8_1_d/mux8_1.vhdl
	ghdl -c ../mux8_1_d/mux8_1.vhdl


control:
	ghdl -a ../control/control.vhdl
	ghdl -c ../control/control.vhdl

alu_control:
	ghdl -a ../alu_control/alu_control.vhdl
	ghdl -c ../alu_control/alu_control.vhdl

datamem:
	ghdl -a ../DataMem/DataMem.vhdl
	ghdl -c ../DataMem/DataMem.vhdl

neger:
	ghdl -a ../neger_d/neger.vhdl
	ghdl -c ../neger_d/neger.vhdl

multiplier:
	ghdl -a ../multiplier_d/multiplier.vhdl
	ghdl -c ../multiplier_d/multiplier.vhdl

divider:
	ghdl -a ../divider_d/divider.vhdl
	ghdl -c ../divider_d/divider.vhdl
