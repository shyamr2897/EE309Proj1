library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity TopLevel is
	port (

		clk, rst: in std_logic
	     );
end entity;

architecture Struct of TopLevel is

signal sig_mem_ad_a, sig_mem_ad_b, sig_alu1_a, sig_alu1_b, sig_alu1_c, sig_alu2_a, sig_alu2_b,
        sig_alu2_c, sig_pc_a, sig_pc_b, sig_a2_a, sig_t1_a, sig_t5_a, sig_t6_a, sig_a3_a,
        sig_a3_b, sig_d3_a, sig_d3_b, sig_mem_d_a, sig_pad9_a : std_logic;
signal sig_c,sig_z,sig_z_temp,sig_comp_temp: std_logic;
signal sig_pcw, sig_irw, sig_memr, sig_memw, sig_rfw, sig_t5e, sig_t6e, sig_t3e, sig_c_en,
        sig_z_en, sig_z_temp_en, sig_comp_temp_en,sig_alu_op : std_logic;
signal sig_instr: std_logic_vector(15 downto 0);
signal sig_clk, sig_rst: std_logic;

begin
    sig_clk <= clk;
    sig_rst <= rst;
    cp: ControlPath port map (
    mem_ad_a => sig_mem_ad_a, mem_ad_b => sig_mem_ad_b, alu1_a => sig_alu1_a, alu1_b => sig_alu1_b,
     alu1_c => sig_alu1_c, alu2_a => sig_alu2_a, alu2_b => sig_alu2_b, alu2_c => sig_alu2_c,
            pc_a => sig_pc_a, pc_b => sig_pc_b, a2_a => sig_a2_a, t1_a => sig_t1_a, t5_a => sig_t5_a,
            t6_a => sig_t6_a, a3_a => sig_a3_a, a3_b => sig_a3_b, d3_a => sig_d3_a, d3_b => sig_d3_b,
                                        mem_d_a => sig_mem_d_a, pad9_a => sig_pad9_a,
            c => sig_c,z => sig_z,z_temp => sig_z_temp,comp_temp => sig_comp_temp,
            pcw => sig_pcw, irw => sig_irw, memr => sig_memr, memw => sig_memw, rfw => sig_rfw, t5e => sig_t5e,
             t6e => sig_t6e, t3e => sig_t3e, c_en =>sig_c_en, z_en => sig_z_en, z_temp_en => sig_z_temp_en,
              comp_temp_en => sig_comp_temp_en,alu_op => sig_alu_op,
            instr => sig_instr,
            clk => sig_clk, rst => sig_rst);

    dp: DataPath port map (
    mem_ad_a => sig_mem_ad_a, mem_ad_b => sig_mem_ad_b, alu1_a => sig_alu1_a, alu1_b => sig_alu1_b,
     alu1_c => sig_alu1_c, alu2_a => sig_alu2_a, alu2_b => sig_alu2_b, alu2_c => sig_alu2_c,
            pc_a => sig_pc_a, pc_b => sig_pc_b, a2_a => sig_a2_a, t1_a => sig_t1_a, t5_a => sig_t5_a,
            t6_a => sig_t6_a, a3_a => sig_a3_a, a3_b => sig_a3_b, d3_a => sig_d3_a, d3_b => sig_d3_b,
                                        mem_d_a => sig_mem_d_a, pad9_a => sig_pad9_a,
            c => sig_c,z => sig_z,z_temp => sig_z_temp,comp_temp => sig_comp_temp,
            pcw => sig_pcw, irw => sig_irw, memr => sig_memr, memw => sig_memw, rfw => sig_rfw, t5e => sig_t5e,
             t6e => sig_t6e, t3e => sig_t3e, c_en =>sig_c_en, z_en => sig_z_en, z_temp_en => sig_z_temp_en,
              comp_temp_en => sig_comp_temp_en,alu_op => sig_alu_op,
            instr => sig_instr,
            clk => sig_clk, rst => sig_rst);
end Struct;

