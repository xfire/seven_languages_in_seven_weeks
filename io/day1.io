Car := Object clone
Car desc := "a car"
Car m := method("some method" println)


audi := Car clone

audi desc println

audi m
audi getSlot("m") call
