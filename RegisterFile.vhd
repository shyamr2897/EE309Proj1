library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity RF is
    port(RF_write: in std_logic;
        A1,A2,A3: in std_logic_vector (2 downto 0);
        D3: in std_logic_vector(15 downto 0);
        D1,D2: out std_logic_vector(15 downto 0);
        clk: in std_logic);
end entity;

architecture Struct of RF is
    signal R0_data, R1_data, R2_data, R3_data: std_logic_vector(15 downto 0);
    signal R4_data, R5_data, R6_data, R7_data: std_logic_vector(15 downto 0);

    signal R0_in, R1_in, R2_in, R3_in: std_logic_vector(15 downto 0);
    signal R4_in, R5_in, R6_in, R7_in: std_logic_vector(15 downto 0);

    signal R0_enable, R1_enable, R2_enable, R3_enable: std_logic;
    signal R4_enable, R5_enable, R6_enable, R7_enable: std_logic;
begin
    --Read related logic
    m1: out_Mux port map(r0 => R0_data, r1 => R1_data, r2 => R2_data, r3 => R3_data,
                        r4 => R4_data, r5 => R5_data, r6 => R6_data, r7 => R7_data,
                        a => A1, o => D1);

    m2: out_Mux port map(r0 => R0_data, r1 => R1_data, r2 => R2_data, r3 => R3_data,
                        r4 => R4_data, r5 => R5_data, r6 => R6_data, r7 => R7_data,
                        a => A2, o => D2);


    --Write related logic
    ----------------------
    --R0 related logic
    ----------------------
    R0_in <= D3;
    R0_enable <= RF_write and ( not(A3(2)) and not(A3(1)) and not(A3(0)) );
    R0: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R0_in, Dout => R0_data,
				Enable => R0_enable, clk => clk);


    ----------------------
    --R1 related logic
    ----------------------
    R1_in <= D3;
    R1_enable <= RF_write and ( not(A3(2)) and not(A3(1)) and A3(0) );
    R1: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R1_in, Dout => R1_data,
				Enable => R1_enable, clk => clk);


    ----------------------
    --R2 related logic
    ----------------------
    R2_in <= D3;
    R2_enable <= RF_write and ( not(A3(2)) and A3(1) and not(A3(0)) );
    R2: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R2_in, Dout => R2_data,
				Enable => R2_enable, clk => clk);

    ----------------------
    --R3 related logic
    ----------------------
    R3_in <= D3;
    R3_enable <= RF_write and ( not(A3(2)) and A3(1) and A3(0) );
    R3: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R3_in, Dout => R3_data,
				Enable => R3_enable, clk => clk);

    ----------------------
    --R4 related logic
    ----------------------
    R4_in <= D3;
    R4_enable <= RF_write and ( A3(2) and not(A3(1)) and not(A3(0)) );
    R4: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R4_in, Dout => R4_data,
				Enable => R4_enable, clk => clk);

    ----------------------
    --R5 related logic
    ----------------------
    R5_in <= D3;
    R5_enable <= RF_write and ( A3(2) and not(A3(1)) and A3(0) );
    R5: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R5_in, Dout => R5_data,
				Enable => R5_enable, clk => clk);

    ----------------------
    --R6 related logic
    ----------------------
    R6_in <= D3;
    R6_enable <= RF_write and ( A3(2) and A3(1) and not(A3(0)) );
    R6: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R6_in, Dout => R6_data,
				Enable => R6_enable, clk => clk);

    ----------------------
    --R7 related logic
    ----------------------
    R7_in <= D3;
    R7_enable <= RF_write and ( A3(2) and A3(1) and A3(0) );
    R7: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R7_in, Dout => R7_data,
				Enable => R7_enable, clk => clk);

end Struct;
