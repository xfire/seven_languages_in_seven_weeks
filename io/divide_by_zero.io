Number origDivide := Number getSlot("/")

Number / := method(n, if(n == 0, 0, origDivide(n)))

(1 origDivide(0)) println
(1 / 0) println
