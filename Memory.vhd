library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.EE224_Components.all;

entity Memory is
    port(Mem_write, Mem_read: in std_logic;
        Mem_ad, Mem_dat: in std_logic_vector (15 downto 0);
        edb: out std_logic_vector(15 downto 0);
        clk,rst: in std_logic);
end entity;

architecture Behave of Memory is
    type arr is array(natural range <>) of std_logic_vector(7 downto 0);
    signal mem_byte: arr(65535 downto 0);
    signal ad_of_lsb, ad_of_msb : std_logic_vector (15 downto 0);
begin
    ad_of_lsb <= Mem_ad(14 downto 0) & '0';
    ad_of_msb <= Mem_ad(14 downto 0) & '1';

    edb <= mem_byte(to_integer(unsigned(ad_of_msb))) &
                        mem_byte(to_integer(unsigned(ad_of_lsb))) when Mem_read = '1' else
            "XXXXXXXXXXXXXXXX";
            
    process(clk)
    begin
        if(clk'event and (clk  = '1')) then
            if(Mem_write = '1') then
                mem_byte(to_integer(unsigned(ad_of_lsb))) <= Mem_dat(7 downto 0);
                mem_byte(to_integer(unsigned(ad_of_msb))) <= Mem_dat(15 downto 8);
            end if;
        end if;
    end process;
end Behave;
