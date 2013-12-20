-module(insert).

%% ====================================================================
%% API functions
%% ====================================================================
-export([initiate/1, into_list/1]).

into_list(File) ->
        {ok, IO} = file:open( File, [read] ),
        into_list(io:get_line(IO, ''), IO, []).

into_list( eof, _IO, Acc ) -> lists:reverse( Acc );
into_list( {error, _Error}, _IO, Acc ) -> lists:reverse( Acc );
into_list( Line, IO, Acc ) -> into_list( io:get_line(IO, ''), IO, [Line | Acc] ).

initiate(Ticket) ->
       io:format(Ticket),
    Lines = into_list("C:/Users/LB/Documents/erlangshiet/parser.txt"),
    insertlines(Lines, Ticket).

insertlines([Head | Tail], Ticket) ->      
   [Date, Close, High, Low, Open, Volume] = string:tokens(Head, ","),
                   
    Volume2 = re:split(Volume, ""),
    io:format([Date, Close, High, Low, Open, Volume2]),
   
        dbconnect:start([Date, Close, High, Low, Open, Volume2], Ticket),
  insertlines(Tail, Ticket);

insertlines([], Ticket) -> insertion_to_db_finished.


%% ====================================================================
%% Internal functions
%% ====================================================================

