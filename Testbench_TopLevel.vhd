library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_TopLevel is
end entity;
architecture Behave of Testbench_TopLevel is

    component TopLevel is
        port (

            clk, rst: in std_logic
             );
    end component;

  signal clk: std_logic := '0';
  signal rst: std_logic;

  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

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

  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
    alias lx: bit_vector(1 to x'length) is x;
    variable ret_var : std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else 
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_std_logic_vector;

begin
  clk <= not clk after 5 ns; -- assume 10ns clock.

    -- reset process
  process
  begin
     wait until clk = '1';
     rst <= '1';
     wait until clk = '0';
     wait until clk = '1';
     rst <= '0';
     wait;
  end process;

  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "TRACEFILE.txt";
    FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

    ---------------------------------------------------
    -- edit the next few lines to customize
    variable rst_var: bit;
    ----------------------------------------------------
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
    
  begin

    wait until clk = '1';

   
    while not endfile(INFILE) loop 
    	  

          LINE_COUNT := LINE_COUNT + 1;
	
	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, rst_var);

          --------------------------------------
          -- from input-vector to DUT inputs
	  --rst <= to_std_logic(rst_var);
          --------------------------------------

          --wait until clk = '1';

          --------------------------------------
	  -- check outputs.

          --------------------------------------
    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

  dut: TopLevel
     port map(clk => clk,
              rst => rst);

end Behave;

