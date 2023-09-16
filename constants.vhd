
library ieee;
use ieee.std_logic_1164.all;

package constants is

	constant PC_OP_NOP  : std_logic_vector(1 downto 0) := "00";
	constant PC_OP_2    : std_logic_vector(15 downto 0) := X"0002";
	constant PC_OP_NEXT : std_logic_vector(1 downto 0) := "01";
	constant PC_OP_SKIP : std_logic_vector(1 downto 0) := "10";
	constant PC_OP_LD   : std_logic_vector(1 downto 0) := "11";
	
end package constants;