
-module(getspecline).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, task/0, from_file/2, into_list/1]).


-define(List, into_list("C:/Users/LB/Documents/erlangshiet/parser.txt")).
-define(MaxRows, erlang:length(?List)).



into_list(File) ->
        {ok, IO} = file:open( File, [read] ),
        into_list(io:get_line(IO, ''), IO, []).

into_list( eof, _IO, Acc ) -> lists:reverse( Acc );
into_list( {error, _Error}, _IO, Acc ) -> lists:reverse( Acc );
into_list( Line, IO, Acc ) -> into_list( io:get_line(IO, ''), IO, [Line | Acc] ).

from_file( File, N ) -> line_nr( N, into_list(File) ).
							

start() ->
	?List,
	?MaxRows.


task() ->
	   Nummer = 1,
	   Rows = 1,
       Line = lists:nth(1, ?List),
	   [Date, Close, High, Low, Open, Volume] = string:tokens(Line, ","),
				  
	   Volume2 = string:tokens(Volume, "\n"),
       Insertion = [Date, Close, High, Low, Open, Volume2],
       Ticker = ["aapl"],
	dbconnect:start(Insertion, Ticker).


	

 
 
 
line_nr( N, Lines ) ->
         try
         case lists:nth( N, Lines )
         of "" -> erlang:exit( empty_line ); 
			 Line -> Line
         end
 
         catch
         _Type:Error0 ->
                Error = line_nr_error( Error0 ),
                io:fwrite( "Error: ~p~n", [Error] ),
                erlang:exit( Error )
 
         end.


 
line_nr_error( function_clause ) -> too_few_lines_in_file;
line_nr_error( Error ) -> Error.


%% ====================================================================
%% Internal functions
%% ====================================================================


