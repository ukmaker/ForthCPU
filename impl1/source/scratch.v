	/**
	* Outputs for debugging
	**/
	output reg [1:0] GPF,   // Instruction group field
	output reg [3:0] SYSF,  // System operation field
	output reg [1:0] INCF,  // Increment/decrement field
	output reg [1:0] LDSF,  // Load/store operation field
	output reg [1:0] MODEF, // Addressing mode field
	output reg [1:0] SKIPF, // Condition handling field
	output reg [1:0] CCF,   // Condition code select field
	output reg [1:0] JPF,   // Jump type field
	output reg [3:0] ALUF,  // ALU operation field
	output reg [1:0] ARGF,  // ALU argument type field
	
	/**
	* Real outputs to control functional blocks
	**/
	output reg [1:0] REGX,        // Register operation
	output reg [3:0] ARGA,        // Register address A
	output reg [3:0] ARGB,        // Register address B
	output reg [3:0] REG_SOURCEX, // Data source for register file
	output reg [3:0] ALU_SOURCEX, // Data sources for ALU
	output reg [1:0] ALUX,        // ALU operation
	output reg [1:0] ADDRX,       // Address bus control
	output reg [1:0] DATAX,       // Data bus control
	
	output reg WRITEX,             // Write to memory
	output reg READX               // Read from memory