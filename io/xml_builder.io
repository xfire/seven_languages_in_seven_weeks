curlyBrackets := method(
    r := Map clone
    call message arguments foreach(arg, r doMessage(arg))
    r
)
Map atPutNumber := method(
    self atPut(call evalArgAt(0) asMutable strip("\""),
               call evalArgAt(1) asMutable strip("\""))
)
Sequence : := method(call sender atPutNumber(call target asString, call message next asString))


Builder := Object clone

Builder indentionLevel := 0
Builder indent := method(self indentionLevel := indentionLevel + 4)
Builder dedent := method(self indentionLevel := indentionLevel - 4)
Builder prefix := method(" " repeated(indentionLevel))

Builder asAttributeList := method(m, m map(k, v, k .. "=\"" .. v .. "\"") join(" "))

Builder forward := method(
    args := call message arguments

    attrs := ""
    if(args at(0) name in(list("curlyBrackets", "Map")),
        attrs = " " .. asAttributeList(self doMessage(args at(0)))
        args = args slice(1)
    )

    writeln(prefix, "<", call message name, attrs, ">")

    indent
    args foreach(arg,
        content := self doMessage(arg);
        if(content type == "Sequence", writeln(prefix, content))
    )
    dedent
    writeln(prefix, "</", call message name, ">")
)


Builder ul(li("Io"),
           li("Lua"),
           li("Javascript"))

Builder a(b(c(d(e(f("foo"))))))

Builder book(Map with("author", "Tate"))
Builder book({ "author": "Tate", "date": "sometimes"},
             content("Lorem ipsum dolor sit amet")
            )
