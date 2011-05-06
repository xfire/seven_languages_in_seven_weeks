(defn big [st n] (> (count st) n))
(println "string 'foo' longer as 4 chars -> " (big "foo" 4))
(println "string 'foo' longer as 2 chars -> " (big "foo" 2))
