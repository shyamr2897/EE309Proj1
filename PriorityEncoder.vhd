library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity PriorityEncoder is
    port(x: in std_logic_vector (7 downto 0);
        s: out std_logic_vector(2 downto 0);
        N: out std_logic);
end entity;

architecture Struct of PriorityEncoder is
begin
    N <= not(x(7) or x(6) or x(5) or x(4) or x(3) or x(2) or x(1) or x(0));

    s(0) <= (x(1) and not x(0)) or
            (x(3) and not x(2) and not x(1) and not x(0)) or (x(5) and not x(4) and not x(3) and not x(2) and
            not x(1) and not x(0)) or (x(7) and not x(6) and not x(5) and not x(4) and not x(3) and not
            x(2) and not x(1));

    s(1) <= (x(2) and not x(1) and not x(0)) or (x(3) and not x(2) and not x(1) and not x(0)) or
            (x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(7) and not x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0));

    s(2) <= (x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(7) and not x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0));
end Struct;

