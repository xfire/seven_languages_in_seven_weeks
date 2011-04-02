List myAverage := method(
    self foreach(i,
        (i hasProto(Number)) ifFalse(Exception raise("list contains not only numbers")))
    (self size == 0) ifTrue(return 0) ifFalse(return self sum / self size)
)

list() myAverage println

list(1,2,3,4,5) average println
list(1,2,3,4,5) myAverage println

e := try ( list(1, "a") myAverage println )
e catch ( Exception, "Exception successfully catched" println)
