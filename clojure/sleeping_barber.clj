(def customers (ref clojure.lang.PersistentQueue/EMPTY))
(def counter (atom 0))
(def running? (atom true))
(def seats 3)
(def timeoutInSeconds 10)

(defn haircut [customer]
  (println "doing haircut for" customer)
  (Thread/sleep 20)
  (swap! counter inc))

(defn popCustomer []
  (dosync
    (let [customer (peek @customers)]
      (if-not (nil? customer)
        (alter customers pop))
      customer)))

(defn barber []
  (let [customer (popCustomer)]
    (if-not (nil? customer)
      (haircut customer)
      (Thread/sleep 50)))
  (if @running? (recur)))

(defn pushCustomer [customer]
  (dosync
    (if (< (count @customers) seats)
      (do (println customer "take seat")
          (alter customers conj customer))
      (println customer "turning away"))))

(defn shop [cnt]
  (Thread/sleep (+ 10 (rand-int 20)))
  (if @running?
    (do (pushCustomer (str "customer [" cnt "]"))
        (recur (inc cnt)))))

(.start (Thread. barber))
(.start (Thread. #(shop 0)))

(Thread/sleep (* 1000 timeoutInSeconds))
(swap! running? not)
(println "there were" @counter "haircuts in" timeoutInSeconds "seconds")
