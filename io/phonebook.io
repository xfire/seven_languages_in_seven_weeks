# OperatorTable don't work in a script, so I implement
# the : message on Sequence.
#   OperatorTable addAssignOperator(":", "atPutNumber")

curlyBrackets := method(
    r := Map clone
    call message arguments foreach(arg,
        r doMessage(arg)
    )
    r
)

Map atPutNumber := method(
    self atPut(call evalArgAt(0) asMutable strip("\""),
               call evalArgAt(1) asMutable strip("\""))
)

Sequence : := method(
    call sender atPutNumber(call target asString, call message next asString)
)

phoneNumbers := { "Mr. Foo": "12345"
                , "Mr. Bar": "98765" }

phoneNumbers asJson println
