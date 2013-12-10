

-module(supervisor).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).

start() ->
    Modules = [dbconnect, impTest],
    Pid = spawn(?MODULE, init, [Modules]),
    try register(supervisor, Pid)
    catch
        error:badarg ->
            Pid ! {stop, self()}
    end.

ini() ->
    case whereis(supervisor) of
        undefined ->
            not_running;
        [] ->
       srv ! {fire, self()},
            receive
          Msg ->
            Msg
      end
    end.

stop() ->
    case whereis(supervisor) of
        undefined ->
            io:format("Module is offline");
        [] ->
            srv ! {stop, self()},
            receive
                Msg ->
                    Msg
            end
    end.



%% ====================================================================
%% Internal functions
%% ====================================================================


