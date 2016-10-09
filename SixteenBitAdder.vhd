library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixteenBitAdder is
    port(x,y: in std_logic_vector (15 downto 0);
    s: out std_logic_vector(15 downto 0);
    c_out: out std_logic);
end entity;

architecture Struct of SixteenBitAdder is
    signal m: std_logic := '0';
    signal c: std_logic_vector (14 downto 0);
begin
    f0: FullAdder port map (x => x(0), y => y(0), ci => m, s => s(0), co => c(0));
    f1: FullAdder port map (x => x(1), y => y(1), ci => c(0), s => s(1), co => c(1));
    f2: FullAdder port map (x => x(2), y => y(2), ci => c(1), s => s(2), co => c(2));
    f3: FullAdder port map (x => x(3), y => y(3), ci => c(2), s => s(3), co => c(3));
    f4: FullAdder port map (x => x(4), y => y(4), ci => c(3), s => s(4), co => c(4));
    f5: FullAdder port map (x => x(5), y => y(5), ci => c(4), s => s(5), co => c(5));
    f6: FullAdder port map (x => x(6), y => y(6), ci => c(5), s => s(6), co => c(6));
    f7: FullAdder port map (x => x(7), y => y(7), ci => c(6), s => s(7), co => c(7));
    f8: FullAdder port map (x => x(8), y => y(8), ci => c(7), s => s(8), co => c(8));
    f9: FullAdder port map (x => x(9), y => y(9), ci => c(8), s => s(9), co => c(9));
    f10: FullAdder port map (x => x(10), y => y(10), ci => c(9), s => s(10), co => c(10));
    f11: FullAdder port map (x => x(11), y => y(11), ci => c(10), s => s(11), co => c(11));
    f12: FullAdder port map (x => x(12), y => y(12), ci => c(11), s => s(12), co => c(12));
    f13: FullAdder port map (x => x(13), y => y(13), ci => c(12), s => s(13), co => c(13));
    f14: FullAdder port map (x => x(14), y => y(14), ci => c(13), s => s(14), co => c(14));
    f15: FullAdder port map (x => x(15), y => y(15), ci => c(14), s => s(15), co => c_out);
end Struct;
