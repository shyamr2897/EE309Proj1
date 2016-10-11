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

    component SixteenBitNand is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0));
    end component;

    component PriorityEncoder is
        port(x: in std_logic_vector (7 downto 0);
            s: out std_logic_vector(2 downto 0);
            N: out std_logic);
    end component;
end EE224_Components;

