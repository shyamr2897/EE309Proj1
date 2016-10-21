--Two bit input XOR gate
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity XORTwo is
	port(a,b: in std_logic;
		c: out std_logic);
end entity;

architecture Struct of XORTwo is
	signal na, nb, t1, t2: std_logic;
begin
	n1: INVERTER port map (a => a, b=> na);
	n2: INVERTER port map (a => b, b=> nb);
	
	a1: ANDTwo port map (a => a, b => nb, c => t1);
	a2: ANDTwo port map (a => na, b => b, c => t2);

	o1: ORTwo port map (a => t1, b => t2, c => c);

end Struct;

--------------------------------------------------------------------------
-- Two bit input full adder
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FullAdder is
	port(x,y,ci: in std_logic;
		s, co: out std_logic);
end entity;

architecture Struct of FullAdder is
	signal s1, c1, c2 : std_logic;
begin
	x1: XORTwo port map (a => x, b => y, c => s1);
	x2: XORTwo port map (a => s1, b => ci, c => s);

	a1: ANDTwo port map (a => x, b => y, c => c1);
	a2: ANDTwo port map (a => ci, b => s1, c => c2);

	o1: ORTwo port map (a => c1, b => c2, c => co);
end Struct;

-------------------------------------------------------------------------------
--Two's Complement of an eight bit vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity TwosComplement is
	port (x: in std_logic_vector (7 downto 0);
		t: out std_logic_vector (7 downto 0));
end entity;

architecture Struct of TwosComplement is
	signal i: std_logic_vector (7 downto 0);
	signal o: std_logic_vector (7 downto 0) := "00000001";
begin
	n0: INVERTER port map (a => x(0), b => i(0));
	n1: INVERTER port map (a => x(1), b => i(1));
	n2: INVERTER port map (a => x(2), b => i(2));
	n3: INVERTER port map (a => x(3), b => i(3));
	n4: INVERTER port map (a => x(4), b => i(4));
	n5: INVERTER port map (a => x(5), b => i(5));
	n6: INVERTER port map (a => x(6), b => i(6));
	n7: INVERTER port map (a => x(7), b => i(7));

	f0: EightBitAdder port map (x => i, y => o, s => t);
end Struct;

-------------------------------------------------------------------------------
--Two's Complement of a sixteen bit vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity TwosComplementSixteen is
port (x: in std_logic_vector (15 downto 0);
t: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of TwosComplementSixteen is
signal i: std_logic_vector (15 downto 0);
signal o: std_logic_vector (15 downto 0) := "0000000000000001";
signal c: std_logic;
begin
n0: INVERTER port map (a => x(0), b => i(0));
n1: INVERTER port map (a => x(1), b => i(1));
n2: INVERTER port map (a => x(2), b => i(2));
n3: INVERTER port map (a => x(3), b => i(3));
n4: INVERTER port map (a => x(4), b => i(4));
n5: INVERTER port map (a => x(5), b => i(5));
n6: INVERTER port map (a => x(6), b => i(6));
n7: INVERTER port map (a => x(7), b => i(7));
n8: INVERTER port map (a => x(8), b => i(8));
n9: INVERTER port map (a => x(9), b => i(9));
n10: INVERTER port map (a => x(10), b => i(10));
n11: INVERTER port map (a => x(11), b => i(11));
n12: INVERTER port map (a => x(12), b => i(12));
n13: INVERTER port map (a => x(13), b => i(13));
n14: INVERTER port map (a => x(14), b => i(14));
n15: INVERTER port map (a => x(15), b => i(15));

f0: SixteenBitAdder port map (x => i, y => o, s => t, c_out => c);
end Struct;

----------------------------------------------------------------------------
-- 2:1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity Multiplexer is
	port(a, b, s: in std_logic; c: out std_logic);
end entity;

architecture Struct of Multiplexer is
	signal t1, t2, t3: std_logic;
begin
	i1: INVERTER port map (a => s, b => t1);
	
	a1: ANDTwo port map (a => t1, b => a, c => t2);
	a2: ANDTwo port map (a => s, b => b, c => t3);

	o1: ORTwo port map (a => t2, b => t3, c => c);
end Struct;

-----------------------------------------------------------------------------
--4:1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FourOneMux is
	port (a, b, c, d: in std_logic; s: in std_logic_vector (1 downto 0);
		o: out std_logic);
end entity;

architecture Struct of FourOneMux is
	signal t1, t2: std_logic;
begin
	m1: Multiplexer port map (a => a, b => b, s => s(0), c => t1);
	m2: Multiplexer port map (a => d, b => c, s => s(0), c => t2);

	m3: Multiplexer port map (a => t1, b => t2, s => s(1), c => o);
end Struct;

----------------------------------------------------------------------------
-- 2:1 Multiplexer for 16 bit Vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity MuxTwo is
	port(i0, i1: in std_logic_vector (15 downto 0);
        s: in std_logic;
        o: out std_logic_vector(15 downto 0));
end entity;

architecture Struct of MuxTwo is
begin
	o <= i0 when s = '0' else
        i1 when s = '1' else
        i0;
end Struct;

-----------------------------------------------------------------------------
--4:1 Multiplexer for 16 bit Vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity MuxFour is
	port (i00, i01, i10, i11: in std_logic_vector(15 downto 0);
        s: in std_logic_vector (1 downto 0);
		o: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of MuxFour is
begin
	o <= i00 when s = "00" else
        i01 when s = "01" else
        i10 when s = "10" else
        i11 when s = "11" else
        i00;

end Struct;

-----------------------------------------------------------------------------
--8:1 Multiplexer for 16 bit Vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity MuxEight is
	port (i000, i001, i010, i011, i100, i101, i110, i111: in std_logic_vector(15 downto 0);
        s: in std_logic_vector (2 downto 0);
		o: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of MuxEight is
begin
	o <= i000 when s = "000" else
        i001 when s = "001" else
        i010 when s = "010" else
        i011 when s = "011" else
        i100 when s = "100" else
        i101 when s = "101" else
        i110 when s = "110" else
        i111 when s = "111" else
        i000;

end Struct;

-------------------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity EightBitAdder is
	port(x,y: in std_logic_vector (7 downto 0);
		s: out std_logic_vector(7 downto 0));
end entity;

architecture Struct of EightBitAdder is
	signal m: std_logic := '0';
	signal c: std_logic_vector (7 downto 0);
begin
	f0: FullAdder port map (x => x(0), y => y(0), ci => m, s => s(0), co => c(0));
	f1: FullAdder port map (x => x(1), y => y(1), ci => c(0), s => s(1), co => c(1));
	f2: FullAdder port map (x => x(2), y => y(2), ci => c(1), s => s(2), co => c(2));
	f3: FullAdder port map (x => x(3), y => y(3), ci => c(2), s => s(3), co => c(3));
	f4: FullAdder port map (x => x(4), y => y(4), ci => c(3), s => s(4), co => c(4));
	f5: FullAdder port map (x => x(5), y => y(5), ci => c(4), s => s(5), co => c(5));
	f6: FullAdder port map (x => x(6), y => y(6), ci => c(5), s => s(6), co => c(6));
	f7: FullAdder port map (x => x(7), y => y(7), ci => c(6), s => s(7), co => c(7));
end Struct;

-------------------------------------------------------------------------------
--Eight Bit Subtractor

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity EightBitSubtractor is
	port(x,y: in std_logic_vector (7 downto 0);
		s: out std_logic_vector(7 downto 0));
end entity;

architecture Struct of EightBitSubtractor is
	signal t: std_logic_vector (7 downto 0);
begin
	t0: TwosComplement port map (x => y, t => t);

	e1: EightBitAdder port map (x => x, y => t, s => s);
end Struct;
-----------------------------------------------------------------------------
--Eight Bit Left Shift
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ShiftLeft is
	port (x,y: in std_logic_vector (7 downto 0);
	r: out std_logic_vector (7 downto 0));
end entity ShiftLeft;

architecture Struct of ShiftLeft is
	signal k, l: std_logic_vector (7 downto 0);
	signal m: std_logic := '0';
begin
	m00: Multiplexer port map (a => x(0), b => m, s => y(0), c => k(0));
	m01: Multiplexer port map (a => x(1), b => x(0), s => y(0), c => k(1));
	m02: Multiplexer port map (a => x(2), b => x(1), s => y(0), c => k(2));
	m03: Multiplexer port map (a => x(3), b => x(2), s => y(0), c => k(3));
	m04: Multiplexer port map (a => x(4), b => x(3), s => y(0), c => k(4));
	m05: Multiplexer port map (a => x(5), b => x(4), s => y(0), c => k(5));
	m06: Multiplexer port map (a => x(6), b => x(5), s => y(0), c => k(6));
	m07: Multiplexer port map (a => x(7), b => x(6), s => y(0), c => k(7));

	m10: Multiplexer port map (a => k(0), b => m, s => y(1), c => l(0));
	m11: Multiplexer port map (a => k(1), b => m, s => y(1), c => l(1));
	m12: Multiplexer port map (a => k(2), b => k(0), s => y(1), c => l(2));
	m13: Multiplexer port map (a => k(3), b => k(1), s => y(1), c => l(3));
	m14: Multiplexer port map (a => k(4), b => k(2), s => y(1), c => l(4));
	m15: Multiplexer port map (a => k(5), b => k(3), s => y(1), c => l(5));
	m16: Multiplexer port map (a => k(6), b => k(4), s => y(1), c => l(6));
	m17: Multiplexer port map (a => k(7), b => k(5), s => y(1), c => l(7));

	m20: Multiplexer port map (a => l(0), b => m, s => y(2), c => r(0));
	m21: Multiplexer port map (a => l(1), b => m, s => y(2), c => r(1));
	m22: Multiplexer port map (a => l(2), b => m, s => y(2), c => r(2));
	m23: Multiplexer port map (a => l(3), b => m, s => y(2), c => r(3));
	m24: Multiplexer port map (a => l(4), b => l(0), s => y(2), c => r(4));
	m25: Multiplexer port map (a => l(5), b => l(1), s => y(2), c => r(5));
	m26: Multiplexer port map (a => l(6), b => l(2), s => y(2), c => r(6));
	m27: Multiplexer port map (a => l(7), b => l(3), s => y(2), c => r(7));	
end Struct;

-----------------------------------------------------------------------------
--Eight Bit Right Shift
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ShiftRight is
	port (x,y: in std_logic_vector (7 downto 0);
		r: out std_logic_vector (7 downto 0));
end entity;

architecture Struct of ShiftRight is
	signal p, q: std_logic_vector (7 downto 0);
begin
	p(0)<=x(7);
	p(1)<=x(6);
	p(2)<=x(5);
	p(3)<=x(4);
	p(4)<=x(3);
	p(5)<=x(2);
	p(6)<=x(1);
	p(7)<=x(0);

	sl: ShiftLeft port map (x=>p, y=>y, r=>q);

	r(0)<=q(7);
	r(1)<=q(6);
	r(2)<=q(5);
	r(3)<=q(4);
	r(4)<=q(3);
	r(5)<=q(2);
	r(6)<=q(1);
	r(7)<=q(0);
end Struct;

-----------------------------------------------------------------------------
--Two input NAND gate
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity NANDTwo is
    port (a, b: in std_logic;
        c: out std_logic);
end entity;

architecture Struct of NANDTwo is
    signal t1: std_logic;
begin
    a1: ANDTwo port map(a => a, b => b, c => t1);
    n1: INVERTER port map (a => t1, b => c);
end Struct;

----------------------------------------------------------------------------
--DataRegister
library ieee;
use ieee.std_logic_1164.all;

entity DataRegister is
    generic (data_width:integer);
    port (Din: in std_logic_vector(data_width-1 downto 0);
        Dout: out std_logic_vector(data_width-1 downto 0);
        clk, enable: in std_logic);
end entity;

architecture Behave of DataRegister is
begin
    process(clk)
    begin
        if(clk'event and (clk  = '1')) then
            if(enable = '1') then
                Dout <= Din;
            end if;
        end if;
    end process;
end Behave;
-----------------------------------------------------------------------------
--RF_outMUX
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity out_Mux is
    port(r0, r1, r2, r3, r4, r5, r6, r7: in std_logic_vector(15 downto 0);
        a: in std_logic_vector(2 downto 0);
        o: out std_logic_vector(15 downto 0));
end entity;
architecture Behave of out_Mux is
begin
    process(a,r0,r1,r2,r3,r4,r5,r6,r7)
    begin
        if(a = "000") then o <= r0;
        elsif(a = "001") then o <= r1;
        elsif(a = "010") then o <= r2;
        elsif(a = "011") then o <= r3;
        elsif(a = "100") then o <= r4;
        elsif(a = "101") then o <= r5;
        elsif(a = "110") then o <= r6;
        elsif(a = "111") then o <= r7;
        else o <= "XXXXXXXXXXXXXXXX";
        end if;
    end process;
end Behave;

-------------------------------------------------------------------------------
--Priority Decoder

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity PriorityDecoder is
    port(x: in std_logic_vector (7 downto 0);
        s: in std_logic_vector(2 downto 0);
        y: out std_logic_vector(7 downto 0));
end entity;

architecture Behave of PriorityDecoder is
begin
    y(0) <= x(0) and (not(not s(2) and not s(1) and not s(0)));
    y(1) <= x(1) and (not(not s(2) and not s(1) and s(0)));
    y(2) <= x(2) and (not(not s(2) and s(1) and not s(0)));
    y(3) <= x(3) and (not(not s(2) and s(1) and s(0)));
    y(4) <= x(4) and (not( s(2) and not s(1) and not s(0)));
    y(5) <= x(5) and (not( s(2) and not s(1) and s(0)));
    y(6) <= x(6) and (not( s(2) and s(1) and not s(0)));
    y(7) <= x(7) and (not( s(2) and s(1) and s(0)));
end Behave;

-------------------------------------------------------------------------------
--Comparator
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity Comparator is
    port(x,y: in std_logic_vector (15 downto 0);
    z_out: out std_logic);
end entity;

architecture Behave of Comparator is

begin
    z_out <= '1' when x = y else
            '0';
end Behave;
-------------------------------------------------------------------------------
--Zero Comparator
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ZeroComparator is
    port(x: in std_logic_vector (15 downto 0);
    z_out: out std_logic);
end entity;

architecture Behave of ZeroComparator is

begin
    z_out <= '1' when x = "0000000000000000" else
            '0';
end Behave;

-------------------------------------------------------------------------------
--Six Bit Sign Extender
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixBitSignExtender is
    port(x: in std_logic_vector (5 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of SixBitSignExtender is
    signal m: std_logic;
begin
    m <= x(5);
    y(5 downto 0) <= x(5 downto 0);
    y(6) <= m;
    y(7) <= m;
    y(8) <= m;
    y(9) <= m;
    y(10) <= m;
    y(11) <= m;
    y(12) <= m;
    y(13) <= m;
    y(14) <= m;
    y(15) <= m;
end Struct;

-------------------------------------------------------------------------------
--Nine Bit Sign Extender
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity NineBitSignExtender is
    port(x: in std_logic_vector (8 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of NineBitSignExtender is
signal m: std_logic;
begin
m <= x(8);
y(8 downto 0) <= x(8 downto 0);
y(9) <= m;
y(10) <= m;
y(11) <= m;
y(12) <= m;
y(13) <= m;
y(14) <= m;
y(15) <= m;
end Struct;

-------------------------------------------------------------------------------
--Pad Nine
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity PadNine is
    port(x: in std_logic_vector (8 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of PadNine is
begin
y <= x & "0000000";
end Struct;
