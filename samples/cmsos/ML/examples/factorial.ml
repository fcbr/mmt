cml
 let val x = ref 0 in
  let fun fat x = if (x < 1) then 1 else x * fat (x - 1) in
     x := (fat (10))
   end
 end
