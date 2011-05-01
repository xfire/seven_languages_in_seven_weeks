-module(translate).
-export([printing_loop/0, responder_loop/0, translate/2]).

printing_loop() ->
    receive
        "casa" ->
            io:format("house~n"),
            printing_loop();
        "blanca" ->
            io:format("white~n"),
            printing_loop();
        _ ->
            io:format("what?~n"),
            printing_loop()
end.

responder_loop() ->
    receive
        {Pid, "casa"} ->
            Pid ! "house",
            responder_loop();
        {Pid, "blanca"} ->
            Pid ! "white",
            responder_loop();
        {Pid, _} ->
            Pid! "what?",
            responder_loop()
end.

translate(To, Word) ->
    To ! {self(), Word},
    receive
        Translation -> Translation
    end.
