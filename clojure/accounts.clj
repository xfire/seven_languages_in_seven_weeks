(defprotocol AccountList
  (add [self account value])
  (balance [self account])
  (debit [self account value])
  (credit [self account value]))

(defrecord ConcurrentAccountList [accounts]
  AccountList
    (add [_ account value] (swap! accounts (fn [accounts] (assoc accounts account (ref value)))))
    (balance [_ account] @(@accounts account))
    (debit [_ account value] (dosync (alter (@accounts account) (fn [balance] (- balance value)))))
    (credit [_ account value] (dosync (alter (@accounts account) (fn [balance] (+ balance value))))))

(defn newAccountList [] (ConcurrentAccountList. (atom {})))

(defn testAccountList []
  (do
    (def accounts (newAccountList))
    (add accounts :foo 23)
    (add accounts :bar 42)
    (println "balance for :foo is ->" (balance accounts :foo))
    (println "balance for :bar is ->" (balance accounts :bar))

    (println "\ndoing some debits of 5 and 11")
    (debit accounts :foo 5)
    (debit accounts :bar 11)
    (println "balance for :foo is now ->" (balance accounts :foo))
    (println "balance for :bar is now ->" (balance accounts :bar))

    (println "\ndoing some credits of 1 and 3")
    (credit accounts :foo 1)
    (credit accounts :bar 3)
    (println "balance for :foo is now ->" (balance accounts :foo))
    (println "balance for :bar is now ->" (balance accounts :bar))))
