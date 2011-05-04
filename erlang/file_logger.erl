-module(file_logger).
-export([start_link/0, log_message/2, close_logger/1]).
-export([init/1, handle_info/2, handle_call/3, handle_cast/2, terminate/2, code_change/3]).
-behaviour(gen_server).

%% public api
start_link() -> gen_server:start_link(?MODULE, "logfile.txt", []).
log_message(Pid, Message) -> gen_server:call(Pid, Message).
close_logger(Pid) -> gen_server:call(Pid, terminate).


%% gen server callbacks
init(Filename) -> file:open(Filename, [write]).

handle_info(Msg, FileId) ->
    io:format("Unexpected message: ~p~n",[Msg]),
    {noreply, FileId}.

handle_call(terminate, _From, FileId) ->
    {stop, normal, ok, FileId};
handle_call(Message, _From, FileId) ->
    write_to_file(FileId, Message),
    {reply, ok, FileId}.
 
handle_cast(Message, FileId) ->
    write_to_file(FileId, Message),
    {noreply, FileId}.

terminate(normal, FileId) ->
    io:format("Closing file: ~p~n", [FileId]),
    file:close(FileId),
    ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.


%% private api
write_to_file(FileId, Message) ->
    io:fwrite(FileId, "~s~n", [Message]).
