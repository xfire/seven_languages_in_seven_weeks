-module(doctor).
-export([loop/0]).
-export([start_monitor/0, monitor/0]).

start_monitor() ->
    spawn(?MODULE, monitor, []).

monitor() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(?MODULE, loop, []),
    case lists:member(doctor, registered()) of
        true -> unregister(doctor);
        _ -> ok
    end,
    register(doctor, Pid),
    doctor ! new,
    receive
        {'EXIT', Pid, normal} -> ok;
        {'EXIT', Pid, shutdown} -> ok;
        {'EXIT', Pid, _} ->
            io:format("restarting doctor...~n"),
            monitor()
    end.


loop() ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating and Monitoring Process.~n"),
            register(revolver, spawn_link(fun roulette:loop/0)),
            loop();

        {'EXIT', From, Reason} ->
            io:format("The shooter ~p died with Reason ~p.~n", [From, Reason]),
            io:format(" Restarting.~n"),
            self() ! new,
            loop()
    end.
