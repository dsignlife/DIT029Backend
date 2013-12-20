-module(ini).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, ini/1]).

start() ->
	inets:start(),
	
	List = insert:into_list("C:/Users/LB/Documents/erlangshiet/tickers.txt"),
    %%ini().
           request(List).
    

request([Head | Tail]) -> 
	io:format(Head),
	
       ini(Head),

  request(Tail);

request([]) -> done.

ini(Tickers) ->
        Name = "C:/Users/LB/Documents/erlangshiet/parser.txt",
		%%Tickers = "bac",
		Ticket = string:tokens(Tickers, "\n"),
		io:format(Ticket),
		URL = "http://chartapi.finance.yahoo.com/instrument/1.0/"++Ticket++"/chartdata;type=quote;range=1y/csv",
		io:format(URL),
		      
     {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(URL),
        Data = Body,
        
        %%io:format(Data),
        {ok, IODevice} = file:open(Name, [write]),
        
        file:write(IODevice, Data),
        file:close(IODevice),

        %%compile:file("C:/Users/LB/workspace/DBtest/src/remove_lines.erl"),
        
        remove_lines:from_file(Name, 1, 18),
		

    insert:initiate(Ticket).



    



%%io:get_chars(Body, Count).

%%hnz
%%msft
%%ko
%%wmt
%%eric

    %% io:format(Event).




%% ====================================================================
%% Internal functions
%% ====================================================================


%%C:/Users/LB/workspace/DBtest/src/parser1.erl