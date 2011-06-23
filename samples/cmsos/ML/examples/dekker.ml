cml let val cz1 = ref 0 and cz2 = ref 0 and ir1 = ref 0 and ir2 = ref 0 and
            c1 = ref 0 and c2 = ref 0 and turn = ref 1
    in let val p1 = (fn () => while 1 = 1 do
                           (c1 := 1;
                            while (! c2) = 1 do
                             (if (! turn) = 2 then
                               (c1 := 0; (while (! turn) = 2 do ()) ; c1 := 1)
                              else ()) ;
                            cz1 := 1; cz1 := 0;
                            turn := 2;
                            c1 := 0; ir1 := 1; ir1 := 0)) and
               p2 = (fn () => while 1 = 1 do
                           (c2 := 1 ;
                            while (! c1) = 1 do
                             (if (! turn) = 1 then
                               (c2 := 0; (while (! turn) = 1 do ()) ; c2 := 1)
                              else ()) ;
                            cz2 := 1; cz2 := 0;
                            turn := 1;
                            c2 := 0; ir2 := 1; ir2 := 0))
        in (spawn p1 ; spawn p2) end
    end
