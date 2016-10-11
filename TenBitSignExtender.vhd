library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity TenBitSignExtender is
    port(x: in std_logic_vector (9 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of TenBitSignExtender is
signal m: std_logic;
begin
m <= x(9);
y(9 downto 0) <= x(9 downto 0);
y(10) <= m;
y(11) <= m;
y(12) <= m;
y(13) <= m;
y(14) <= m;
y(15) <= m;
end Struct;
