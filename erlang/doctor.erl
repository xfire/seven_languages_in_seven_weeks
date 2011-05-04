-module(doctor).
-export([doctor/0]).
-export([start_monitor/0, monitor/2, monitor_monitor/1]).
-export([kill_doctor/0, kill_monitor/0, kill_monitor_monitor/0]).

start_monitor() ->
    spawn(?MODULE, monitor_monitor, [undefined]).

monitor(Doctor, MonitorMonitor) ->
    process_flag(trap_exit, true),
    link(MonitorMonitor),
    D = case Doctor of
        undefined -> P = spawn_link(?MODULE, doctor, []),
                     P ! new,
                     P;
        _         -> Doctor
    end,
    safe_register(monitor, self()),
    receive
        {'EXIT', _Pid, normal} -> ok;
        {'EXIT', _Pid, shutdown} -> ok;
        {'EXIT', Pid, _} when Pid =:= D ->
            io:format("restarting doctor...~n"),
            monitor(undefined, MonitorMonitor);
        {'EXIT', Pid, _} when Pid =:= MonitorMonitor ->
            io:format("restarting monitors's monitor...~n"),
            monitor(D, spawn(?MODULE, monitor_monitor, [self()]))
    end.

monitor_monitor(Monitor) ->
    process_flag(trap_exit, true),
    case Monitor of
        undefined -> spawn_link(?MODULE, monitor, [undefined, self()]);
        _         -> link(Monitor)
    end,
    safe_register(monitor_monitor, self()),
    receive
        {'EXIT', _Pid, normal} -> ok;
        {'EXIT', _Pid, shutdown} -> ok;
        {'EXIT', _Pid, _} ->
            io:format("restarting doctor's monitor...~n"),
            monitor_monitor(undefined)
    end.

kill_doctor() -> exit(whereis(doctor), kill).
kill_monitor() -> exit(whereis(monitor), kill).
kill_monitor_monitor() -> exit(whereis(monitor_monitor), kill).

safe_register(Name, Pid) ->
    case lists:member(Name, registered()) of
        true -> unregister(Name);
        _    -> ok
    end,
    register(Name, Pid).

doctor() ->
    process_flag(trap_exit, true),
    safe_register(doctor, self()),
    receive
        new ->
            io:format("Creating and Monitoring Process.~n"),
            safe_register(revolver, spawn_link(fun roulette:loop/0)),
            doctor();

        {'EXIT', From, Reason} ->
            io:format("The shooter ~p died with Reason ~p.~n", [From, Reason]),
            io:format(" Restarting.~n"),
            self() ! new,
            doctor()
    end.
