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
