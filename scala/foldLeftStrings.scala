val l = List("foo", "bar", "spam", "eggs")

val s = l.foldLeft(0)((acc, v) => acc + v.length)

println(l)
println(s)

// vim: set ts=2 sw=2 et:
