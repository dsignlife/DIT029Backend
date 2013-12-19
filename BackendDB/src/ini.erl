-module(ini).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, ini/0]).

start() ->

    inets:start(),
           
    ini().

ini() ->
        Name = "C:/Users/LB/Documents/erlangshiet/parser.txt",
        
     {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} =
        httpc:request("http://chartapi.finance.yahoo.com/instrument/1.0/AAPL/chartdata;type=quote;range=1y/csv"),
        Data = Body,
        
        %%io:format(Data),
        {ok, IODevice} = file:open(Name, [write]),
        
        file:write(IODevice, Data),
        file:close(IODevice),

        %%compile:file("C:/Users/LB/workspace/DBtest/src/remove_lines.erl"),
        remove_lines:from_file(Name, 1, 18),

    insert:initiate().

    



%%io:get_chars(Body, Count).



    %% io:format(Event).




%% ====================================================================
%% Internal functions
%% ====================================================================


%%C:/Users/LB/workspace/DBtest/src/parser1.erl