Range

fibRecursive := method(n, if(n > 1, fibRecursive(n-1) + fibRecursive(n - 2), 1))

fibLoop := method(n,
    n_1 := 1
    n_2 := 0
    acc := 0
    for(i, 0, n - 1, acc = n_1 + n_2; n_2 = n_1; n_1 = acc)
)

"recursive - looping" println
1 to(10) foreach(n, fibRecursive(n) print; " - " print; fibLoop(n) println)
