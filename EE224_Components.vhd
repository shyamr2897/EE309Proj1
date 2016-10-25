library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package EE224_Components is
    
	component INVERTER is
		port (a: in std_logic; b : out std_logic);
   	end component;

  	component ANDTwo is
		port (a, b: in std_logic; c : out std_logic);
   	end component;

	component ORTwo is
		port (a, b: in std_logic; c : out std_logic);
   	end component;

	component XORTwo is 
		port (a,b: in std_logic; c: out std_logic);
	end component;

    component NANDTwo is
        port (a, b: in std_logic; c: out std_logic);
    end component;

	component FullAdder is
		port (x, y, ci: in std_logic; s, co: out std_logic);
	end component;

	component EightBitAdder is
		port (x,y: in std_logic_vector (7 downto 0); 
		  	s: out std_logic_vector (7 downto 0));
	end component;

	component EightBitSubtractor is
		port (x,y: in std_logic_vector (7 downto 0); 
		  	s: out std_logic_vector (7 downto 0));
	end component;
	
	component TwosComplement is 
		port (x: in std_logic_vector (7 downto 0); 
		  	t: out std_logic_vector (7 downto 0));
	end component;

    component TwosComplementSixteen is
        port (x: in std_logic_vector (15 downto 0);
            t: out std_logic_vector (15 downto 0));
    end component;

	component Multiplexer is
		port(a, b, s: in std_logic; c: out std_logic);
	end component;

	component ShiftLeft is
		port (x,y: in std_logic_vector (7 downto 0);
		  	r: out std_logic_vector (7 downto 0));
	end component;

	component ShiftRight is
		port (x,y: in std_logic_vector (7 downto 0);
		  	r: out std_logic_vector (7 downto 0));
	end component;

	component FourOneMux is
		port (a, b, c, d: in std_logic; s: in std_logic_vector (1 downto 0);
			o: out std_logic);
	end component;

    component SixteenBitAdder is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0);
            c_out: out std_logic);
    end component;

    component SixteenBitSubtractor is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0);
            b: out std_logic);
    end component;

    component SixteenBitNand is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0));
    end component;

    component PriorityEncoder is
        port(x: in std_logic_vector (7 downto 0);
            s: out std_logic_vector(2 downto 0);
            N: out std_logic;
            tnew: out std_logic_vector (7 downto 0));
    end component;

    component PriorityDecoder is
        port(x: in std_logic_vector (7 downto 0);
            s: in std_logic_vector(2 downto 0);
            y: out std_logic_vector(7 downto 0));
    end component;

    component SixBitSignExtender is
        port(x: in std_logic_vector (5 downto 0);
            y: out std_logic_vector (15 downto 0));
    end component;

    component NineBitSignExtender is
        port(x: in std_logic_vector (8 downto 0);
            y: out std_logic_vector (15 downto 0));
    end component;

    component DataRegister is
        generic (data_width:integer);
        port (Din: in std_logic_vector(data_width-1 downto 0);
            Dout: out std_logic_vector(data_width-1 downto 0);
            clk, enable: in std_logic);
    end component DataRegister;

    component out_Mux is
        port(r0, r1, r2, r3, r4, r5, r6, r7: in std_logic_vector(15 downto 0);
            a: in std_logic_vector(2 downto 0);
            o: out std_logic_vector(15 downto 0));
    end component;

    component MuxTwo is
        port(i0, i1: in std_logic_vector (15 downto 0);
            s: in std_logic;
            o: out std_logic_vector(15 downto 0));
    end component;

    component MuxFour is
        port (i00, i01, i10, i11: in std_logic_vector(15 downto 0);
            s: in std_logic_vector (1 downto 0);
            o: out std_logic_vector (15 downto 0));
    end component;

    component MuxEight is
        port (i000, i001, i010, i011, i100, i101, i110, i111: in std_logic_vector(15 downto 0);
            s: in std_logic_vector (2 downto 0);
            o: out std_logic_vector (15 downto 0));
    end component;

    component ALU is
        port(x,y: in std_logic_vector (15 downto 0);
            op: in std_logic_vector (1 downto 0);
            s: out std_logic_vector(15 downto 0);
            c_out,z_out: out std_logic);
    end component;

    component RF is
        port(RF_write, PC_write: in std_logic;
            A1,A2,A3: in std_logic_vector (2 downto 0);
            D3,PC_in: in std_logic_vector(15 downto 0);
            D1,D2,PC_out: out std_logic_vector(15 downto 0);
            rst, clk: in std_logic);
    end component;

    component Memory is
        port(Mem_write, Mem_read: in std_logic;
            Mem_ad, Mem_dat: in std_logic_vector (15 downto 0);
            edb: out std_logic_vector(15 downto 0);
            clk,rst: in std_logic);
    end component;

    component Comparator is
        port(x,y: in std_logic_vector (15 downto 0);
        z_out: out std_logic);
    end component;

    component ZeroComparator is
        port(x: in std_logic_vector (15 downto 0);
        z_out: out std_logic);
    end component;

    component ControlPath is
        port (
		mem_ad_a, mem_ad_b, alu1_a, alu1_b, alu1_c, alu2_a, alu2_b, alu2_c,
        pc_a, pc_b, a2_a, t1_a, t5_a, t6_a, a3_a, a3_b, d3_a, d3_b,
                                                    mem_d_a, pad9_a: out std_logic;
		c,z,z_temp,comp_temp,rfcomp: in std_logic;
        pcw, irw, memr, memw, rfw, t5e, t6e, t3e, t1e, c_en, z_en, z_temp_en, comp_temp_en,
        alu_op, flg, frce: out std_logic;
        instr: in std_logic_vector (15 downto 0);
		clk, rst: in std_logic
	     );
    end component;

    component DataPath is
        port (
            mem_ad_a, mem_ad_b, alu1_a, alu1_b, alu1_c, alu2_a, alu2_b, alu2_c,
            pc_a, pc_b, a2_a, t1_a, t5_a, t6_a, a3_a, a3_b, d3_a, d3_b,
                                                        mem_d_a, pad9_a: in std_logic;
            c,z,z_temp,comp_temp,rfcomp: out std_logic;
            pcw, irw, memr, memw, rfw, t5e, t6e, t3e, t1e, c_en, z_en, z_temp_en, comp_temp_en,
            alu_op,frce,flg: in std_logic;
            instr: out std_logic_vector (15 downto 0);
            clk, rst: in std_logic
             );
    end component;

    component PadNine is
        port(x: in std_logic_vector (8 downto 0);
            y: out std_logic_vector (15 downto 0));
    end component;

    component RF2 is
        port(RF_write, PC_write, flag, force: in std_logic;
            A1,A2,A3: in std_logic_vector (2 downto 0);
            D3,PC_in, PC_old: in std_logic_vector(15 downto 0);
            D1,D2,PC_out: out std_logic_vector(15 downto 0);
            RF_comp: out std_logic;
            rst, clk: in std_logic);
    end component;

    component TopLevel is
        port (

            clk, rst: in std_logic
             );
    end component;

    end EE224_Components;

