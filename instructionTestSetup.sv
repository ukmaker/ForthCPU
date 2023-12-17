/************************************************
* Very high-level tests which just drive the bus
*************************************************/
`define CLOCK_CYCLE 100
`define INSTRUCTION_CYCLE 400
`define TICK #(50)
`define TOCK #(50)
`define TICKTOCK #(`CLOCK_CYCLE)
`define STEP     #(`INSTRUCTION_CYCLE)

`define assert(what, expected, actual) \
    if (expected !== actual) begin \
        $display("[T=%0t] FAILED in %m: %s expected %b != actual %b", $realtime, what, expected, actual); \
    end

`define asserth(what, expected, actual) \
    if (expected !== actual) begin \
        $display("[T=%0t] FAILED in %m: %s expected %04x != actual %04x", $realtime, what, expected, actual); \
    end

`define mark(n)  \
	$display("[T=%09t] %d", $realtime, n);
	
`define ALU_STEP(n, addr, instruction, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]",  n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE [T=%09t]",  n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]",  n, $realtime); \
	`TICKTOCK;

`define ST_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime,addr, instruction, m); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	`asserth("ADDR_BUF", st_addr, ADDR_BUF) \
	`asserth("DOUT_BUF", st_data, DOUT_BUF) \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`asserth("ADDR_BUF", st_addr, ADDR_BUF) \
	`asserth("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 0, WRN0_BUF) \
	`assert("WRN1_BUF", 0, WRN1_BUF) \
	`TOCK;
	

`define ST_LOW_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	`asserth("ADDR_BUF", st_addr, ADDR_BUF) \
	`asserth("DOUT_BUF", st_data, DOUT_BUF) \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`asserth("ADDR_BUF", st_addr, ADDR_BUF) \
	`asserth("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 0, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;
	
	

`define ST_HIGH_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	`asserth("ADDR_BUF", st_addr, ADDR_BUF) \
	`asserth("DOUT_BUF", st_data, DOUT_BUF) \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`asserth("ADDR_BUF", st_addr, ADDR_BUF) \
	`asserth("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 0, WRN1_BUF) \
	`TOCK;
	
	
`define LD_STEP(n, addr, instruction, ld_addr,ld_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = ld_data; \
	`asserth("ADDR_BUF", ld_addr, ADDR_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;
	
	
`define LD_HERE_STEP(n, addr, ld_data, rr) \
	$display("%04d LDI    [T=%09t] R%02x, %04x", n, $realtime, rr, ld_data); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = {`GROUP_LOAD_STORE, 1'b0, `LDSOPF_LD, `MODE_LDS_REG_HERE, rr, 4'b0000}; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	DIN = ld_data; \
	`asserth("ADDR_BUF", addr+2, ADDR_BUF) \
	`assert("WRN0_BUF", 1,      WRN0_BUF) \
	`assert("WRN1_BUF", 1,      WRN1_BUF) \
	`TICKTOCK;
	
`define JMP_STEP(n, pc_addr, instruction, dest, taken, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, pc_addr, instruction, m); \
	#1 \
	`asserth("ADDR", pc_addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE   [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT   [T=%09t]", n, $realtime); \
	`TICK; \
	`TOCK; \
	$display("%04d FETCH    [T=%09t] {%04x} :: {%04x} %s", n, $realtime, dest, instruction, m); \
	#1 \
	`asserth("ADDR", taken, ADDR_BUF) \
	#49 DIN = 16'h0000; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`TOCK;
	
	
`define JMP_HERE_STEP(n, pc_addr, instruction, taken, m) \
	$display("%04d FETCH1   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, pc_addr, instruction, m); \
	#1 \
	`asserth("ADDR", pc_addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE1  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE1 [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT1  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = taken; \
	`asserth("ADDR_BUF", pc_addr+2, ADDR_BUF) \
	`assert("WRN0_BUF", 1,      WRN0_BUF) \
	`assert("WRN1_BUF", 1,      WRN1_BUF) \
	`TOCK; \
	$display("%04d FETCH2    [T=%09t] {%04x} :: {%04x} %s", n, $realtime, taken, instruction, m); \
	#1 \
	`asserth("ADDR", taken, ADDR_BUF) \
	#49 DIN = 16'h0000; \
	#50 \
	$display("%04d DECODE2   [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE2  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT2   [T=%09t]", n, $realtime); \
	`TICK; \
	`TOCK;
	
`define JMP_HERE_N_STEP(n, pc_addr, instruction, m) \
	$display("%04d FETCH1   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, pc_addr, instruction, m); \
	#1 \
	`asserth("ADDR", pc_addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`asserth("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE1  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE1 [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT1  [T=%09t]", n, $realtime); \
	`TICK; \
	`asserth("ADDR_BUF", pc_addr, ADDR_BUF) \
	`assert("WRN0_BUF", 1,      WRN0_BUF) \
	`assert("WRN1_BUF", 1,      WRN1_BUF) \
	`TOCK;
	
`define SYS_STEP(n, addr, instruction, sys_addr, sys_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`asserth("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = sys_data; \
	`asserth("ADDR_BUF", sys_addr, ADDR_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;

`define MOV(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("MOV R%1x,R%1x", a, b))

`define MOVI(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_U4, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("MOVI R%1x,%1x", a, b))
	
`define MOVAI(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("MOVAI %1x", a))
	
`define MOVAS(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_S8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("MOVAS %1x", a))
`define ADD(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ADD R%1x,R%1x", a, b))

`define ADDI(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_U4, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ADDI R%1x,%1x", a, b))
	
`define ADDAI(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REGA_U8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ADDAI %1x", a))
	
`define ADDAS(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REGA_S8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ADDAS %1x", a))
`define AND(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REG_REG, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("AND R%1x,R%1x", a, b))

`define ANDI(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REG_U4, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ANDI R%1x,%1x", a, b))
	
`define ANDAI(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REGA_U8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ANDAI %1x", a))
	
`define ANDAS(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REGA_S8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("ANDAS %1x", a))

`define SUB(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SUB,`MODE_ALU_REG_REG, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("SUB R%1x,R%1x", a, b))

`define SUBI(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SUB,`MODE_ALU_REG_U4, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("SUBI R%1x,%1x", a, b))
	
`define SUBAI(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SUB,`MODE_ALU_REGA_U8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("SUBAI %1x", a))
	
`define SUBAS(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SUB,`MODE_ALU_REGA_S8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("SUBAS %1x", a))

`define CMP(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_CMP,`MODE_ALU_REG_REG, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("CMP R%1x,R%1x", a, b))

`define CMPI(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_CMP,`MODE_ALU_REG_U4, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("CMPI R%1x,%1x", a, b))
	
`define CMPAI(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_CMP,`MODE_ALU_REGA_U8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("CMPAI %1x", a))
	
`define CMPAS(n, addr, a) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_CMP,`MODE_ALU_REGA_S8, a}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("CMPAS %1x", a))

`define LD(n, pc_addr, addr, data, a, b) \
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_REG, a, b}; \
	`LD_STEP(  n, pc_addr,   INSTR, addr, data, $sformatf("LD R%1x,R%1x", a, b))

`define LDI(n, pc_addr, data, a) \
	`LD_HERE_STEP(  n, pc_addr, data, a)

`define ST(n, pc_addr, addr, data, a, b) \
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,a, b}; \
	`ST_STEP(   n, pc_addr,   INSTR, addr, data, $sformatf("ST R%1x,R%1x", a, b))

`define JP(n, pc_addr, dest, taken, skip, cond, reg) \
	INSTR = {`GROUP_JUMP, skip, cond, `MODE_JMP_ABS_REG, 1'b0, 3'b0, reg};\
	`JMP_STEP(n, pc_addr, INSTR, dest, taken, $sformatf("JP R%1x",reg))
	
`define JPI(n, pc_addr, dest, skip, cond) \
	INSTR = {`GROUP_JUMP, skip, cond, `MODE_JMP_ABS_HERE, 8'h00};\
	`JMP_HERE_STEP(n, pc_addr, INSTR, dest, $sformatf("JPI %4x",dest))
	
`define JPI_N(n, pc_addr, dest, skip, cond) \
	INSTR = {`GROUP_JUMP, skip, cond, `MODE_JMP_ABS_HERE, 8'h00};\
	`JMP_HERE_N_STEP(n, pc_addr, INSTR, $sformatf("JPI %4x",dest))
	
	