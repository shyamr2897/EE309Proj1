library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixteenBitSubtractor is
    port(x,y: in std_logic_vector (15 downto 0);
        s: out std_logic_vector(15 downto 0);
        b: out std_logic);
end entity;

architecture Struct of SixteenBitSubtractor is
    signal t: std_logic_vector (15 downto 0);
begin
t0: TwosComplementSixteen port map (x => y, t => t);

e1: SixteenBitAdder port map (x => x, y => t, s => s, c_out => b);
end Struct;
