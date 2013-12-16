
-module(parser1).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, ini/0]).

start() ->

    inets:start(),
	

    ini().

ini() ->
	Path = "C:/Users/LB/Documents/erlangshiet/parser.txt",
     {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} =
        httpc:request("http://chartapi.finance.yahoo.com/instrument/1.0/AAPL/chartdata;type=quote;range=1y/csv"),
	Data = Body,
	
	io:format(Data).




%%io:get_chars(Body, Count).



    %% io:format(Event).




%% ====================================================================
%% Internal functions
%% ====================================================================


%%C:/Users/LB/workspace/DBtest/src/parser1.erl