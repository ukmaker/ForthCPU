
`define debugWrite(reg, value) \
	$display("[T=%09t] WRITE", $realtime); \
	PIN_DEBUG_ADDR = reg; \
	DEBUG_SEND = value; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#100; \
	DEBUG_SEND = 8'hzz; \
	#1000;  

`define debugRead(reg, expected) \
	$display("[T=%09t] READ", $realtime); \
	PIN_DEBUG_ADDR = reg; \
	DEBUG_SEND = 8'hzz; \
	#100; \
	PIN_DEBUG_RDN = 1'b0; \
	#100; \
	PIN_DEBUG_RDN = 1'b1; \
	#100;

`define debugReadReg(what, reg, expected) \
	$display("[T=%09t] READ %s", $realtime, what); \
	PIN_DEBUG_ADDR = reg; \
	DEBUG_SEND = 8'hzz; \
	#100; \
	PIN_DEBUG_RDN = 1'b0; \
	#100; \
	`assert(what, expected, PIN_DEBUG_DATA) \
	PIN_DEBUG_RDN = 1'b1; \
	#100;

`define debugReadWord \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) \
	$display("[T=%09t]   READ DH", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)	\
	#800;
	
`define debugExpectWord(expected) \
	TEST_EXPECTED_BYTE = 8'hff & expected; \
	`debugReadReg("MEM Low Byte", `DEBUG_REG_ADDR_DL,  TEST_EXPECTED_BYTE) \
	TEST_EXPECTED_BYTE = 8'hff & (expected >> 8); \
	`debugReadReg("MEM High Byte", `DEBUG_REG_ADDR_DH, TEST_EXPECTED_BYTE) \
	#600;
	
`define debugReadRegistersStart \
	$display("[T=%09t] READ REGISTERS START[0]", $realtime); \
	`debugStop \
	`debugWrite( `DEBUG_REG_ADDR_OP, {`DEBUG_OPX_RD_REG, `DEBUG_ADDR_INCX_INC}) \
	`debugCycle \
	`debugCycle \
	$display("[T=%09t] READ REGISTERS START[1]", $realtime); \

`define debugReadRegisters \
	`debugReadRegistersStart \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord 	
	
`define debugReadPC(expected) \
	$display("[T=%09t] READ PC", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_PC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) \
	$display("[T=%09t]   READ DH", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)

`define debugReadInstruction(expected) \
	$display("[T=%09t] READ INSTRUCTION", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_INSTRUCTION, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) \
	$display("[T=%09t]   READ DH", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)

`define debugReadCC(expected) \
	$display("[T=%09t] READ CC", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_CC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) 

`define debugStop \
	$display("[T=%09t] STOP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;

`define debugReset \
	$display("[T=%09t] RESET", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_RESET; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;

`define debugStep \
	$display("[T=%09t] STEP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_REQ; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;
	
`define debugCycle \
	$display("[T=%09t] STEP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_REQ | `DEBUG_MODEX_DEBUG; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;
	
    	
`define debugStepCheck(addr, asm, instr) \
	`step(addr, asm) \
	`debugStep \
	`debugReadPC(addr) \
	`debugReadInstruction(instr)
	
`define debugStepCheckST(addr, asm, instr) \
	`step(addr, asm) \
	`debugStep \
	`debugReadPC(addr) \
	`debugReadInstruction(instr)

`define debugStepCheckCC(addr, asm, instr, cc) \
	`step(addr, asm) \
	`debugStep \
	`debugReadPC(addr) \
	`debugReadInstruction(instr) \
	`debugReadCC(cc)

	