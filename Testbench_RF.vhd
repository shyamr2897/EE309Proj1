library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_RF is
end entity;
architecture Behave of Testbench_RF is
component RF is
    port(RF_write, PC_write: in std_logic;
        A1,A2,A3: in std_logic_vector (2 downto 0);
        D3,PC_in: in std_logic_vector(15 downto 0);
        D1,D2,PC_out: out std_logic_vector(15 downto 0);
        rst, clk: in std_logic);
end component;

signal irfw,ipcw : std_logic;
signal ia1,ia2,ia3 : std_logic_vector(2 downto 0);
signal id3,ipci : std_logic_vector(15 downto 0);
signal od1,od2,opco : std_logic_vector(15 downto 0);


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
File INFILE: text open read_mode is "RF.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable v_irfw,v_ipcw : bit;
variable v_ia1,v_ia2,v_ia3 : bit_vector(2 downto 0);
variable v_id3,v_ipci : bit_vector(15 downto 0);
variable v_od1,v_od2,v_opco : bit_vector(15 downto 0);
----------------------------------------------------
variable INPUT_LINE: Line;
variable OUTPUT_LINE: Line;
variable LINE_COUNT: integer := 0;

begin
wait until clk = '1';

while not endfile(INFILE) loop
LINE_COUNT := LINE_COUNT + 1;

readLine (INFILE, INPUT_LINE);
read (INPUT_LINE, v_irfw);
read (INPUT_LINE, v_ipcw);
read (INPUT_LINE, v_ia1);
read (INPUT_LINE, v_ia2);
read (INPUT_LINE, v_ia3);
read (INPUT_LINE, v_id3);
read (INPUT_LINE, v_ipci);

--read (INPUT_LINE, v_od1);
--read (INPUT_LINE, v_od2);
--read (INPUT_LINE, v_opco);

--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
irfw <= to_std_logic(v_irfw);
ipcw <= to_std_logic(v_ipcw);
ia1 <= to_stdlogicvector(v_ia1);
ia2 <= to_stdlogicvector(v_ia2);
ia3 <= to_stdlogicvector(v_ia3);
id3 <= to_stdlogicvector(v_id3);
ipci <= to_stdlogicvector(v_ipci);

wait until clk = '1';
end loop;

assert (err_flag) report "SUCCESS, all tests passed." severity note;
assert (not err_flag) report "FAILURE, some tests failed." severity error;

wait;
end process;

dut: RF
port map (RF_write => irfw, PC_write  => ipcw,
        A1 => ia1, A2 => ia2, A3 => ia3,
        D3 => id3,PC_in => ipci,
        D1 => od1,D2 => od2,PC_out =>opco,
        rst => rst, clk => clk);

end Behave;
