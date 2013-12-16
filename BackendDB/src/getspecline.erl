
-module(getspecline).

%% ====================================================================
%% API functions
%% ====================================================================
-export([task/0, from_file/2, into_list/1]).



into_list(File) ->
        {ok, IO} = file:open( File, [read] ),
        into_list(io:get_line(IO, ''), IO, []).

into_list( eof, _IO, Acc ) -> lists:reverse( Acc );
into_list( {error, _Error}, _IO, Acc ) -> lists:reverse( Acc );
into_list( Line, IO, Acc ) -> into_list( io:get_line(IO, ''), IO, [Line | Acc] ).

from_file( File, N ) -> line_nr( N, into_list(File) ).
 
task() ->
       Lines = into_list("C:/Users/LB/Documents/erlangshiet/parser.txt"),
       Line_7 = line_nr( 8, Lines ),
       Line_7.
 
 
 
line_nr( N, Lines ) ->
         try
         case lists:nth( N, Lines )
         of "\n" -> erlang:exit( empty_line )
         ; Line -> Line
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


