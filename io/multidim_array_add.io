sum1 := method(a, a flatten sum)
sum2 := method(a, a flatten reduce(+))

array := list(list(1,2,3),
              list(4,5,6),
              list(7,8,9))

array println

sum1(array) println
sum2(array) println
