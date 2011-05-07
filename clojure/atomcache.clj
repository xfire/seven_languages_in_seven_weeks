(defn create [] (atom {}))

(defn query [cache key] (@cache key))

(defn put
  ([cache value-map] (swap! cache merge value-map))
  ([cache key value] (swap! cache assoc key value)))

(def ac (create))
(put ac :quote "foo bar")
(println (str "cached atom: " (query ac :quote)))
