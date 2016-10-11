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
