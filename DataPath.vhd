library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity DataPath is
	port (
		mem_ad_a, mem_ad_b, alu1_a, alu1_b, alu1_c, alu2_a, alu2_b, alu2_c,
        pc_a, pc_b, a2_a, t1_a, t5_a, t6_a, a3_a, a3_b, d3_a, d3_b,
                                                    mem_d_a, pad9_a: in std_logic;
		c,z,z_temp,comp_temp: out std_logic;
        pcw, irw, memr, memw, rfw, t5e, t6e, t3e,t1e, c_en, z_en, z_temp_en, comp_temp_en,
        alu_op,frce,flg: in std_logic;
        instr: out std_logic_vector (15 downto 0);
		clk, rst: in std_logic
	     );
end entity;

architecture Mixed of DataPath is

    --temporary register signals
    signal T1_data, T2_data, T3_data, T4_data, T5_data : std_logic_vector (15 downto 0);
    signal T1_in, T2_in, T3_in, T4_in, T5_in : std_logic_vector (15 downto 0);
    signal T6_data : std_logic_vector (7 downto 0);
    signal T6_in : std_logic_vector (7 downto 0);
    signal T1_enable, T2_enable, T3_enable, T4_enable, T5_enable, T6_enable : std_logic;

    --instruction register signals
    signal instr_data, instr_in : std_logic_vector (15 downto 0);
    signal instr_enable : std_logic;

    --ccr signals
    signal c_data, z_data, c_in, z_in, comp_temp_in, z_temp_in,
            z_temp_data, comp_temp_data : std_logic_vector (0 downto 0);
    signal c_enable, z_enable, z_temp_enable, comp_temp_enable : std_logic;

    --alu signals
    signal alu1, alu2, alu_out :  std_logic_vector (15 downto 0);
    signal alu_z_out, alu_c_out :  std_logic_vector (0 downto 0);
    signal alu_op_sig :  std_logic_vector (1 downto 0);

    --register file signals
    signal rfa1, rfa2, rfa3 :  std_logic_vector (2 downto 0);
    signal rfd3, rfpc_in, rfpc_out, rfd1, rfd2, rfpcold :  std_logic_vector (15 downto 0);
    signal rfa3_s, rfd3_s, rfpci_s:  std_logic_vector (1 downto 0);

    --comparator signals
    signal comp_x, comp_y, zcomp_x : std_logic_vector (15 downto 0);
    signal comp_out, zcomp_out : std_logic_vector (0 downto 0);

    --sign extender and pad9 signals
    signal e6_x: std_logic_vector (5 downto 0);
    signal e9_x, p9_x: std_logic_vector (8 downto 0);
    signal e6_y, e9_y, p9_y: std_logic_vector (15 downto 0);

    --priority encoder signals
    signal pri_x, t6new : std_logic_vector (7 downto 0);
    signal num_sig : std_logic_vector (2 downto 0);
    signal pri_N : std_logic;

    --mux signals
    signal t1mux_out, Mem_ad_mux_out, Mem_dat_mux_out : std_logic_vector (15 downto 0);
    signal t5mux_out : std_logic_vector (15 downto 0);
    signal mem_ad_s : std_logic_vector (1 downto 0);
    signal alu1_s, alu2_s : std_logic_vector (2 downto 0);

    --memory signals
    signal Mem_write_sig, Mem_read_sig: std_logic;
    signal Mem_ad_sig, Mem_dat_sig, edb_sig : std_logic_vector (15 downto 0);

    --constants
    signal const0_16, const1_16 : std_logic_vector (15 downto 0);
begin

    -------------------------------------------------
    -- constants related logic.
    -------------------------------------------------
    const0_16 <= (others => '0');
    const1_16 <= (0 => '1', others => '0');
    -------------------------------------------------
    -- Memory related logic.
    -------------------------------------------------
    Mem_write_sig <= memw;
    Mem_read_sig <= memr;
    Mem_ad_sig <= Mem_ad_mux_out;
    Mem_dat_sig <= Mem_dat_mux_out;
    
    mem_ad_s <= mem_ad_b & mem_ad_a;

    memadmux: MuxFour port map (i00 => rfpc_out, i01 => T4_data, i10 => T1_data,
                                i11 => rfpc_out, s => mem_ad_s, o => Mem_ad_mux_out);

    memdatmux: MuxTwo port map (i0 => T1_data, i1 => T2_data, s => mem_d_a,
                                                        o=> Mem_dat_mux_out);

    mem: Memory port map (Mem_write => Mem_write_sig, Mem_read => Mem_read_sig,
                Mem_ad => Mem_ad_sig, Mem_dat => Mem_dat_sig, edb => edb_sig,
                clk => clk, rst => rst);

    -------------------------------------------------
    -- T1 related logic.
    -------------------------------------------------
    t1mux2: MuxTwo port map (i0 => rfd1, i1 => T4_data, s => t1_a, o => t1mux_out);
    T1_enable <= t1e;
    T1_in <= t1mux_out;
    t1r: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => T1_in, Dout => T1_data,
				Enable => T1_enable, clk => clk);

    -------------------------------------------------
    -- T2 related logic.
    -------------------------------------------------
    T2_enable <= '1';
    T2_in <= rfd2;
    t2r: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => T2_in, Dout => T2_data,
				Enable => T2_enable, clk => clk);

    -------------------------------------------------
    -- T3 related logic.
    -------------------------------------------------
    T3_enable <= t3e;
    T3_in <= rfpc_out;
    t3r: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => T3_in, Dout => T3_data,
				Enable => T3_enable, clk => clk);
    -------------------------------------------------
    -- T4 related logic.
    -------------------------------------------------
    T4_enable <= '1';
    T4_in <=  alu_out;
    t4r: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => T4_in, Dout => T4_data,
				Enable => T4_enable, clk => clk);

    -------------------------------------------------
    -- T5 related logic.
    -------------------------------------------------
    t5mux2: MuxTwo port map (i0 => alu_out, i1 => edb_sig, s => t5_a, o => t5mux_out);
    T5_enable <= t5e;
    T5_in <= t5mux_out;
    t5r: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => T5_in, Dout => T5_data,
				Enable => T5_enable, clk => clk);

    -------------------------------------------------
    -- T6 related logic.
    -------------------------------------------------
    T6_enable <= t6e;
    T6_in <= t6new when t6_a = '1' else instr_data(7 downto 0);
    t6r: DataRegister
             generic map (data_width => 8)
             port map (
			 Din => T6_in, Dout => T6_data,
				Enable => T6_enable, clk => clk);

    -------------------------------------------------
    -- IR related logic.
    -------------------------------------------------
    instr_enable <= irw;
    instr_in <= edb_sig;
    instr <= instr_data;
    ire: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => instr_in, Dout => instr_data,
				Enable => instr_enable, clk => clk);

    -------------------------------------------------
    -- carry related logic.
    -------------------------------------------------
    c_enable <= c_en or rst;
    c_in <= "0" when rst = '1' else alu_c_out;
    c <= c_data(0);
    cr: DataRegister
             generic map (data_width => 1)
             port map (
			 Din => c_in, Dout => c_data,
				Enable => c_enable, clk => clk);

    -------------------------------------------------
    -- zero related logic.
    -------------------------------------------------
    z_enable <= z_en or rst;
    z_in <= "0" when rst = '1' else alu_z_out;
    z <= z_data(0);
    zr: DataRegister
             generic map (data_width => 1)
             port map (
			 Din => z_in, Dout => z_data,
				Enable => z_enable, clk => clk);

    -------------------------------------------------
    -- comp temp related logic.
    -------------------------------------------------
    comp_temp_enable <= comp_temp_en or rst;
    comp_temp_in <= "0" when rst = '1' else comp_out;
    comp_temp <= comp_temp_data(0);
    comptemp: DataRegister
             generic map (data_width => 1)
             port map (
			 Din => comp_temp_in, Dout => comp_temp_data,
				Enable => comp_temp_enable, clk => clk);

    -------------------------------------------------
    -- zero temp related logic.
    -------------------------------------------------
    z_temp_enable <= z_temp_en or rst;
    z_temp_in <= "0" when rst = '1' else zcomp_out;
    z_temp <= z_temp_data(0);
    zerotemp: DataRegister
             generic map (data_width => 1)
             port map (
			 Din => z_temp_in, Dout => z_temp_data,
				Enable => z_temp_enable, clk => clk);

    -------------------------------------------------
    -- alu related logic.
    -------------------------------------------------
    alu_op_sig <= alu_op & '0';
    alu1_s <= alu1_c & alu1_b & alu1_a;
    alu2_s <= alu2_c & alu2_b & alu2_a;

    alu1mux8: MuxEight port map (i000 => rfpc_out, i001 => T3_data, i010 => T1_data,
                                i011 => T5_data, i100 => T2_data, i101 => rfpc_out,
                                i110 => rfpc_out, i111 => rfpc_out, s => alu1_s, o => alu1);

    alu2mux8: MuxEight port map (i000 => const0_16, i001 => T2_data, i010 => e6_y,
                                i011 => e9_y, i100 => const1_16, i101 => const0_16,
                                i110 => const0_16, i111 => const0_16, s => alu2_s, o => alu2);
    abc: ALU port map (op => alu_op_sig, x => alu1, y => alu2,
                            s => alu_out, c_out => alu_c_out(0), z_out => alu_z_out(0));

    -------------------------------------------------
    -- rf related logic.
    -------------------------------------------------
    rfa1 <= instr_data ( 11 downto 9 );
    rfa2 <= num_sig when a2_a = '1' else instr_data( 8 downto 6);

    rfa3_s <= a3_b & a3_a;
    rfa3 <= instr_data ( 11 downto 9 ) when rfa3_s = "00" else
            instr_data (5 downto 3) when rfa3_s = "01" else
            instr_data (8 downto 6) when rfa3_s = "10" else
            num_sig when rfa3_s = "11" else
            instr_data ( 11 downto 9 );


    rfd3_s <= d3_b & d3_a;
    rfd3 <= p9_y when rfd3_s = "00" else
            T4_data when rfd3_s = "01" else
            T5_data when rfd3_s = "10" else
            rfpc_out when rfd3_s = "11" else
            T4_data;

    rfpci_s <=pc_b & pc_a;
    rfpc_in <= alu_out when rfpci_s = "00" else
                T5_data when rfpci_s = "01" else
                T2_data when rfpci_s = "10" else
                const0_16 when rfpci_s = "11" else
                alu_out;

    rfpcold <= T3_data;

    rf: RF2 port map(RF_write => rfw, PC_write => pcw, A1 => rfa1, A2 => rfa2, A3 => rfa3,
                    D3 => rfd3, PC_in => rfpc_in, d1 => rfd1, d2 => rfd2, PC_out => rfpc_out,
                     flag => flg, force => frce, PC_old =>rfpcold, rst => rst, clk => clk);


    -------------------------------------------------
    -- priority encoder related logic.
    -------------------------------------------------
    pri_x <= T6_data;

    prien: PriorityEncoder port map ( x => pri_x, s => num_sig, N => pri_N, tnew => t6new);

    -------------------------------------------------
    -- Comparator related logic.
    -------------------------------------------------
    comp_x <= rfd1;
    comp_y <= rfd2;
    cmp1: Comparator port map (x => comp_x, y => comp_y, z_out => comp_out(0));

    -------------------------------------------------
    -- Zero Comparator related logic.
    -------------------------------------------------
    zcomp_x <= p9_y;
    zcmp1: ZeroComparator port map (x => zcomp_x, z_out => zcomp_out(0));

    -------------------------------------------------
    -- Six Bit Sign Extender related logic.
    -------------------------------------------------
    e6_x <= instr_data (5 downto 0);
    sbe: SixBitSignExtender port map (x => e6_x, y => e6_y);

    -------------------------------------------------
    -- Nine Bit Sign Extender related logic.
    -------------------------------------------------
    e9_x <= instr_data (8 downto 0);
    nbe : NineBitSignExtender port map (x => e9_x, y => e9_y);

    -------------------------------------------------
    -- Pad Nine related logic.
    -------------------------------------------------
    p9_x <= ('0' & t6new) when pad9_a = '1' else instr_data (8 downto 0);
    pnine: PadNine port map (x => p9_x, y => p9_y);

end Mixed;
