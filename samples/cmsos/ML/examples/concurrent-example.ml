cml 
 let chan c in 
     (spawn (fn x => send (c, 10)) ;
      spawn (fn x => send (c, 20)) ;
      spawn (fn x => receive c))
 end

