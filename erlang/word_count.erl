-module(word_count).
-export([count_words/1]).
-export([count_words_2/1]).

count_words([]) -> 0;
count_words([X]) when X /= 32 -> 1;
count_words([32, 32 | T]) -> count_words(" " ++ T);
count_words([32 | T]) -> count_words(T) + 1;
count_words([_ | T]) -> count_words(T).

count_words_2(S) -> length(string:tokens(S, " ")).
