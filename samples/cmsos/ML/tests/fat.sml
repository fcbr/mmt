let fun f x = if x < 2 then x
              else x * f (x - 1)
in f 10
end
