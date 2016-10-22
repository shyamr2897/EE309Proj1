library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ControlPath is
	port (
		mem_ad_a, mem_ad_b, alu1_a, alu1_b, alu1_c, alu2_a, alu2_b, alu2_c,
        pc_a, pc_b, a2_a, t1_a, t5_a, t6_a, a3_a, a3_b, d3_a, d3_b,
                                                    mem_d_a, pad9_a: out std_logic;
		c,z,z_temp,comp_temp: in std_logic;
        pcw, irw, memr, memw, rfw, t5e, t6e, t3e, c_en, z_en, z_temp_en, comp_temp_en,
        alu_op, flg, frce: out std_logic;
        instr: in std_logic_vector (15 downto 0);
		clk, rst: in std_logic
	     );
end entity;

architecture Behave of ControlPath is
   type FsmState is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13);
   signal fsm_state : FsmState;
begin

   process(fsm_state, c,z,z_temp,comp_temp,instr, clk, rst)
      variable next_state: FsmState;
      variable x_mem_ad_a, x_mem_ad_b, x_alu1_a, x_alu1_b, x_alu1_c, x_alu2_a, x_alu2_b,
      x_alu2_c,
        x_pc_a, x_pc_b, x_a2_a, x_t1_a, x_t5_a, x_t6_a, x_a3_a, x_a3_b, x_d3_a, x_d3_b,
                    x_mem_d_a, x_pad9_a: std_logic;
        variable x_pcw, x_irw, x_memr, x_memw, x_rfw, x_t5e, x_t6e, x_t3e, x_c_en, x_z_en,
        x_z_temp_en, x_comp_temp_en, x_alu_op, x_flg, x_frce: std_logic;

   begin
       -- defaults
       next_state := fsm_state;

        x_mem_ad_a:= '0'; x_mem_ad_b:= '0'; x_alu1_a:= '0'; x_alu1_b:= '0'; x_alu1_c:= '0';
        x_alu2_a:= '0';
        x_alu2_b:= '0'; x_alu2_c:= '0'; x_pc_a:= '0'; x_pc_b:= '0'; x_a2_a:= '0'; x_t1_a:= '0';
        x_t5_a:= '0'; x_t6_a:= '0'; x_a3_a:= '0'; x_a3_b:= '0'; x_d3_a:= '0'; x_d3_b:= '0';
                    x_mem_d_a:= '0'; x_pad9_a := '0';

        x_pcw:= '0'; x_irw := '0';x_memr:= '0'; x_memw:= '0'; x_rfw:= '0';
        x_t5e:= '0'; x_t6e:= '0'; x_t3e:= '0'; x_c_en:= '0'; x_z_en:= '0'; x_z_temp_en:= '0';
        x_comp_temp_en:= '0'; x_alu_op:= '0'; x_flg := '0'; x_frce := '0';

       case fsm_state is 
          when S0 =>
               next_state := S2;
               x_mem_ad_a := '0';
               x_mem_ad_b := '0';   --PC -> mem_ad

               x_alu1_c:= '0';
                x_alu1_b := '0';
                x_alu1_a := '0';    --PC -> alu1

                x_alu2_c := '1';
                x_alu2_b := '0';
                x_alu2_a := '0';    -- +1 -> alu2

                x_pc_b := '0';
                x_pc_a := '0';      -- alu -> PC

                x_t3e := '1';       --t3enable = 1

                x_pcw := '1';
                x_irw := '1';
                x_memr := '1';

            when S1 =>
                next_state := S0;
                x_flg := '1';
                
          when S2 =>
                x_t1_a := '0';   -- D1 -> T1
                x_a2_a := '0';      -- I8-6 ->A2

                x_alu1_c:= '0';
                x_alu1_b := '0';
                x_alu1_a := '1';  -- T3 -> alu1

                x_t5_a := '0';  -- alu -> T5
                x_t5e := '1';    -- T5write = 1

                x_t6_a := '0';  -- I7-0 -> t6
                x_t6e := '1';   -- T6write = 1

                x_d3_b := '0';
                x_d3_a := '0'; --PAD9 -> D3
                x_a3_b := '0';
                x_a3_a := '0'; -- I11-9 -> A3

                x_pad9_a := '0';  -- I8-0 -> PAD9

                x_comp_temp_en := '1';

                x_z_temp_en := '1';

                x_alu_op := '0';       --add

            if(instr(15 downto 12) = "0000" or instr(15 downto 12) = "0010") then      --R-type

                    if( ( instr(1 downto 0) = "00" ) or ( c = '1' and instr(1) = '1' )
                                                        or ( z = '1' and instr(0) = '1' ) ) then
                        next_state := S3;
                    else
                        next_state := S1;
                    end if;


               elsif(instr(15 downto 12) = "0011")   then                               --LHI
                    next_state := S1;

                    x_rfw := '1';       --RF_write = 1

                elsif(instr(15 downto 13) = "010")   then                               --LW/SW
                    next_state := S5;

                elsif(instr(15 downto 12) = "0001")     then                            -- ADI
                    next_state := S5;

                elsif(instr(15 downto 12) = "1100")  then                                --BEQ
                    next_state := S10;

                    x_alu2_c := '0';
                    x_alu2_b := '1';
                    x_alu2_a := '0';  -- SE6 -> alu2

                elsif(instr(15 downto 13) = "100")    then                           -- JAL/JLR
                    next_state := S11;

                    x_alu2_c := '0';
                    x_alu2_b := '1';
                    x_alu2_a := '1';  -- SE9 -> alu2

                elsif(instr(15 downto 13) = "011")   then                               -- LM/SM
                    next_state := S12;

                else
                    next_state := S1;
                end if;

          when S3 =>
                next_state := S4;

                x_alu_op := instr(13);
                x_z_en := '1';
                if(instr(13) = '1') then
                    x_alu_op := '1';  --nand
                    x_c_en := '0';
                else
                    x_alu_op := '0';  --add
                    x_c_en := '1';
                end if;


          when S4 =>
                next_state := S1;

               x_rfw := '1';    --rf_write = 1
               x_a3_b := '0';
               x_a3_a := '1';   -- I5-3 -> A3
               x_d3_b := '0';
               x_d3_a := '1';   -- t4 -> D3

        when S5 =>
            x_alu2_c := '0';
            x_alu2_b := '1';
            x_alu2_a := '0';  -- SE6 -> alu2

            x_t1_a := '0';   -- D1->t1

            x_alu_op := '0';       --add

            if (instr(15 downto 12) = "0001" ) then             --ADI
                next_state := S6;

                x_alu1_c:= '0';
                x_alu1_b := '1';
                x_alu1_a := '0';  -- T1 -> alu1

            elsif (instr(15 downto 12) = "0100") then                 --LW
                next_state := S7;

                x_alu1_c:= '1';
                x_alu1_b := '0';
                x_alu1_a := '0';  -- T2 -> alu1

            else                                                --SW
                next_state := S9;

                x_alu1_c:= '1';
                x_alu1_b := '0';
                x_alu1_a := '0';  -- T2 -> alu1
            end if;

        when S6 =>
            next_state := S1;

            x_a3_b := '1';
            x_a3_a := '0';   -- I8-5 -> A3
            x_d3_b := '0';
            x_d3_a := '1';   -- t4 -> D3
            x_rfw := '1';    --rfwrite = 1

        when S7 =>
            next_state := S8;

            x_mem_ad_b := '0';
            x_mem_ad_a := '1';  -- t4 -> mem_ad
            x_memr := '1';  --mem_read = 1
            x_t5e := '1';    --t5_enable = '1'
            x_t5_a := '1';   --edb->t5

        when S8 =>
            next_state := S1;

            x_alu_op := '0';    --add

            x_rfw := '1';   --rfwrite = 1
            x_z_en := '1';  --zero_enable = 1

            x_a3_b := '0';
           x_a3_a := '0';   -- I11-9 -> A3
           x_d3_b := '1';
           x_d3_a := '0';   -- t5 -> D3

            x_alu1_c := '0';
            x_alu1_b := '1';
            x_alu1_a := '1';  -- t5 -> alu1

            x_alu2_c := '0';
            x_alu2_b := '0';
            x_alu2_a := '0';  -- 0 -> alu2

        when S9 =>
            next_state := S1;

            x_memw := '1';  --mem_write = 1

            x_mem_ad_b := '0';
            x_mem_ad_a := '1';  -- t4 -> mem_ad

            x_mem_d_a := '0';  -- t1 -> mem_ad

        when S10 =>
            next_state := S1;

            x_pc_b := '0';
            x_pc_a := '1';      -- t5 -> pc

            if(comp_temp = '1') then
                x_pcw := '1';
            end if;

        when S11 =>
            next_state := S1;

            x_rfw := '1';       --rfwrite = '1'
            x_pcw := '1';       --pcwrite = '1'

            if(instr(12) = '0') then                                   -- JAL
                x_pc_b := '0';
                x_pc_a := '1';      --t5 -> pc
            else                                                        --JLR
                x_pc_b := '1';
                x_pc_a := '0';      --t2 -> pc
            end if;

            x_a3_b := '0';
           x_a3_a := '0';   -- I11-9 -> A3
           x_d3_b := '1';
           x_d3_a := '1';   -- t5 -> D3

        when S12 =>
            if(z_temp = '1') then
                next_state := S1;
            else
                next_state := S13;
            end if;

            x_alu_op := '0';    --add

            x_pad9_a := '1';     --t6new -> pad9

            x_z_temp_en := '1';

            x_alu1_c := '0';
            x_alu1_b := '1';
            x_alu1_a := '0';  -- t1 -> alu1

            x_alu2_c := '1';
            x_alu2_b := '0';
            x_alu2_a := '0';  -- 1 -> alu2

            x_mem_ad_b := '1';
            x_mem_ad_a := '0';  -- t1 -> mem_ad
            x_memr := '1';  --mem_read = 1
            x_t5e := '1';    --t5_enable = '1'
            x_t5_a := '1';   --edb->t5

            x_a2_a := '1';  --num-> A2


        when S13 =>
            if(z_temp = '1') then
                next_state := S1;
            else
                next_state := S12;
            end if;

            x_t1_a := '1'; --t4 -> t1

            x_t6_a := '1';  --t6new->t6
            x_t6e := '1';

            if(instr(12) = '0') then                        --LM
                x_a3_b := '1';
               x_a3_a := '1';   -- num -> A3
               x_d3_b := '1';
               x_d3_a := '0';   -- t5 -> D3
               x_rfw := '1';     --rfwrite = 1

            else
                x_memw := '1';  --mem_write = 1

                x_mem_ad_b := '1';
                x_mem_ad_a := '0';  -- t1 -> mem_ad

                x_mem_d_a := '1';  -- t2 -> mem_ad
            end if;


     end case;

    mem_ad_a <= x_mem_ad_a; mem_ad_b <= x_mem_ad_b; alu1_a <= x_alu1_a; alu1_b <= x_alu1_b;
    alu1_c <= x_alu1_c;
    alu2_a <= x_alu2_a; alu2_b <= x_alu2_b; alu2_c <= x_alu2_c; pc_a <= x_pc_a;
     pc_b <= x_pc_b; a2_a <= x_a2_a; t1_a <= x_t1_a; t5_a <= x_t5_a; t6_a <= x_t6_a;
     a3_a <= x_a3_a;
    a3_b <= x_a3_b; d3_a <= x_d3_a; d3_b <= x_d3_b; mem_d_a <= x_mem_d_a; pad9_a <= x_pad9_a;

    pcw <= x_pcw; memr <= x_memr; memw <= x_memw; rfw <= x_rfw; t5e <= x_t5e; t6e <= x_t6e;
    t3e <= x_t3e; c_en <= x_c_en; z_en <= x_z_en; z_temp_en <= x_z_temp_en;
         comp_temp_en <= x_comp_temp_en; alu_op <= x_alu_op; flg <= x_flg; frce <= x_frce;
  
     if(clk'event and (clk = '1')) then
	if(rst = '1') then
             fsm_state <= S0;
        else
             fsm_state <= next_state;
        end if;
     end if;
   end process;
end Behave;
