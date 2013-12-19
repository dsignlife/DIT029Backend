-module(insert).

%% ====================================================================
%% API functions
%% ====================================================================
-export([initiate/0]).

into_list(File) ->
        {ok, IO} = file:open( File, [read] ),
        into_list(io:get_line(IO, ''), IO, []).

into_list( eof, _IO, Acc ) -> lists:reverse( Acc );
into_list( {error, _Error}, _IO, Acc ) -> lists:reverse( Acc );
into_list( Line, IO, Acc ) -> into_list( io:get_line(IO, ''), IO, [Line | Acc] ).

initiate() ->
       
    Lines = into_list("C:/Users/LB/Documents/erlangshiet/parser.txt"),
    task(Lines).

task([Head | Tail]) ->      
   [Date, Close, High, Low, Open, Volume] = string:tokens(Head, ","),
                   
    Volume2 = re:split(Volume, ""),
    Ticker = ["goog"],
    io:format([Date, Close, High, Low, Open, Volume2]),
   
        dbconnect:start([Date, Close, High, Low, Open, Volume2], Ticker),
  task(Tail);

task([]) -> done.

%% ====================================================================
%% Internal functions
%% ====================================================================

