# sadly this don't work in a script...
# see http://stackoverflow.com/questions/4339137/io-operators-cant-seem-to-create-them-in-a-file
# in the interpreter it's ok. try
#   io -i xor_operator.io

OperatorTable addOperator("xor", 11)

true xor  := method(bool, if(bool, false, true))
false xor := method(bool, if(bool, true, false))

## lead to wrong results
# (true xor true) println
# (false xor false) println
# 
# "" println
# 
# (true xor false) println
# (false xor true) println
