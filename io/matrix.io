Matrix := List clone
Matrix set := method(x, y, value,
    self at(y) atPut(x, value)
)
Matrix get := method(x, y, self at(y) at(x))
Matrix transpose := method(
    new := dim(self size, self at(0) size)
    for(x, 0, self size - 1,
        for(y, 0, self at(0) size - 1,
            new set(x, y, self get(y, x))))
    new
)
Matrix writeToFile := method(fileName,
    f := File with(fileName)
    f remove
    f openForUpdating
    f write(self serialized())
    f close
)
Matrix readFromFile := method(fileName,
    new := Matrix clone
    new copy(doFile(fileName))
)

Object dim := method(x, y,
    s := List clone
    for(i, 1, x, s push(nil))
    new := Matrix clone
    for(i, 1, y, new push(s clone))
    new
)

"dim\n-------" println
matrix := dim(2,3)
matrix type println
matrix println

"\nset\n-------" println
for(x, 0, 1,
    for(y, 0, 2, matrix set(x, y, 1 + x + y)))
matrix println

"\nget\n-------" println
for(x, 0, 1,
    for(y, 0, 2, matrix get(x, y) print; " - " print; (1 + x + y) println))

"\ntranspose\n-------" println
new_matrix := matrix transpose
new_matrix println
for(x, 0, 1,
    for(y, 0, 2, (matrix get(x, y) == new_matrix get(y, x)) ifTrue("passed" println) ifFalse("you failed!" println)))

"\nwrite and read to file\n--------------------" println
matrix writeToFile("matrix.txt")
readMatrix := matrix readFromFile("matrix.txt")
readMatrix type println
readMatrix println
readMatrix get(0,0) type println
