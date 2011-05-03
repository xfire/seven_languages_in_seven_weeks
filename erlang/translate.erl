-module(translate).
-export([printing_loop/0, responder_loop/0, translate/2]).
-export([start_translator/0, kill_translator/0, translate/1, translator_restarter/0]).

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
        diediedie ->
            exit({"i'm dead now"});
        {Pid, _} ->
            Pid! "what?",
            responder_loop()
end.

translate(To, Word) ->
    To ! {self(), Word},
    receive
        Translation -> Translation
    end.



start_translator() ->
    spawn(?MODULE, translator_restarter, []).

kill_translator() ->
    translator ! diediedie.

translate(Word) ->
    translator !{self(), Word},
    receive
        Translation -> Translation
    end.

translator_restarter() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(?MODULE, responder_loop, []),
    case lists:member(translator, registered()) of
        true -> unregister(translator);
        _ -> ok
    end,
    register(translator, Pid),
    receive
        {'EXIT', Pid, normal} -> ok;
        {'EXIT', Pid, shutdown} -> ok;
        {'EXIT', Pid, _} ->
            io:format("restarting translator service...~n"),
            translator_restarter()
    end.
