(defmacro unless
  ([test body] (list 'if (list 'not test) body))
  ([test body else] (list 'if (list 'not test) body else)))
