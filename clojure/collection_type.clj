(defn collection-type [col] 
    (cond (vector? col) :vector
          (map? col)    :map
          (list? col)   :list))

(println (collection-type '(1 2 3 4 5)))
(println (collection-type [1 2]))
(println (collection-type {:a 1, :b 2}))
