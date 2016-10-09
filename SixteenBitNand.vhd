library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixteenBitNand is
    port(x,y: in std_logic_vector (15 downto 0);
    s: out std_logic_vector(15 downto 0));
end entity;

architecture Struct of SixteenBitNand is
begin
    nn0: NANDTwo port map (a => x(0), b => y(0), c => s(0));
    nn1: NANDTwo port map (a => x(1), b => y(1), c => s(1));
    nn2: NANDTwo port map (a => x(2), b => y(2), c => s(2));
    nn3: NANDTwo port map (a => x(3), b => y(3), c => s(3));
    nn4: NANDTwo port map (a => x(4), b => y(4), c => s(4));
    nn5: NANDTwo port map (a => x(5), b => y(5), c => s(5));
    nn6: NANDTwo port map (a => x(6), b => y(6), c => s(6));
    nn7: NANDTwo port map (a => x(7), b => y(7), c => s(7));
    nn8: NANDTwo port map (a => x(8), b => y(8), c => s(8));
    nn9: NANDTwo port map (a => x(9), b => y(9), c => s(9));
    nn10: NANDTwo port map (a => x(10), b => y(10), c => s(10));
    nn11: NANDTwo port map (a => x(11), b => y(11), c => s(11));
    nn12: NANDTwo port map (a => x(12), b => y(12), c => s(12));
    nn13: NANDTwo port map (a => x(13), b => y(13), c => s(13));
    nn14: NANDTwo port map (a => x(14), b => y(14), c => s(14));
    nn15: NANDTwo port map (a => x(15), b => y(15), c => s(15));
end Struct;
