(defprotocol Stack
  (pushItem [a b])
  (pushItems [a b])
  (popItem [a])
  (elements [a]))

(defrecord SimpleStack [stack]
  Stack
    (pushItem [_ item] (SimpleStack. (cons item stack)))
    (pushItems [_ items] (SimpleStack. (concat (reverse items) stack)))
    (popItem [_] (list (first stack) (SimpleStack. (rest stack))))
    (elements [_] (count stack)))

(defn emptyStack [] (SimpleStack. []))
