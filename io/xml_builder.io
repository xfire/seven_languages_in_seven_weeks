Builder := Object clone

Builder indentionLevel := 0
Builder indent := method(self indentionLevel := indentionLevel + 4)
Builder dedent := method(self indentionLevel := indentionLevel - 4)
Builder prefix := method(" " repeated(indentionLevel))

Builder forward := method(
    writeln(prefix, "<", call message name, ">")
    indent
    call message arguments foreach(arg,
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
