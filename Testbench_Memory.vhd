library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_Memory is
end entity;
architecture Behave of Testbench_Memory is
component Memory is
    port(Mem_write, Mem_read: in std_logic;
        Mem_ad, Mem_dat: in std_logic_vector (15 downto 0);
        edb: out std_logic_vector(15 downto 0);
        clk,rst: in std_logic);
end component;

signal imw,imr : std_logic;
signal imad,imdt : std_logic_vector(15 downto 0);
signal oedb : std_logic_vector(15 downto 0);


  signal clk: std_logic := '0';
  signal rst: std_logic := '1';

function to_std_logic(z: bit) return std_logic is
variable ret_val: std_logic;
begin
if (z = '1') then
ret_val := '1';
else
ret_val := '0';
end if;
return(ret_val);
end to_std_logic;

function to_string(z: string) return string is
variable ret_val: string(1 to z'length);
alias lz : string (1 to z'length) is z;
begin
ret_val := lz;
return(ret_val);
end to_string;

begin
clk <= not clk after 5 ns; -- assume 10ns clock.

  -- reset process
  process
  begin
     wait until clk = '1';
     rst <= '0';
     wait;
  end process;

process
variable err_flag : boolean := false;
File INFILE: text open read_mode is "Memory.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable v_imw,v_imr : bit;
variable v_imad,v_imdt : bit_vector(15 downto 0);
variable v_oedb : bit_vector(15 downto 0);
----------------------------------------------------
variable INPUT_LINE: Line;
variable OUTPUT_LINE: Line;
variable LINE_COUNT: integer := 0;

begin
wait until clk = '1';

while not endfile(INFILE) loop
LINE_COUNT := LINE_COUNT + 1;

readLine (INFILE, INPUT_LINE);
read (INPUT_LINE, v_imw);
read (INPUT_LINE, v_imr);
read (INPUT_LINE, v_imad);
read (INPUT_LINE, v_imdt);

--read (INPUT_LINE, v_oedb);

--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
imw <= to_std_logic(v_imw);
imr <= to_std_logic(v_imr);
imad <= to_stdlogicvector(v_imad);
imdt <= to_stdlogicvector(v_imdt);

wait until clk = '1';
end loop;

assert (err_flag) report "SUCCESS, all tests passed." severity note;
assert (not err_flag) report "FAILURE, some tests failed." severity error;

wait;
end process;

dut: Memory
port map (Mem_write => imw, Mem_read => imr,
        Mem_ad => imad, Mem_dat => imdt,
        edb => oedb,
        clk => clk,rst => rst);

end Behave;
