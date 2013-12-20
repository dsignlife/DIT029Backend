-module(insert).

%% ====================================================================
%% API functions   
%% ====================================================================
%% Author Patric Lövgren Berg
-export([initiate/1, into_list/1]).

%% The function to read a file and manipulate the data.
into_list(File) ->
        {ok, IO} = file:open( File, [read] ),
        into_list(io:get_line(IO, ''), IO, []).

into_list( eof, _IO, Acc ) -> lists:reverse( Acc );
into_list( {error, _Error}, _IO, Acc ) -> lists:reverse( Acc );
into_list( Line, IO, Acc ) -> into_list( io:get_line(IO, ''), IO, [Line | Acc] ).


%% initiate the insertion
initiate(Ticket) ->
       io:format(Ticket),
    Lines = into_list("C:/Users/LB/Documents/erlangshiet/parser.txt"),
    insertlines(Lines, Ticket).
%% Head and tail function which takes the information from one row and
%% splitting the data into smaller variables and then calling the dbconnect module which inserts the data to the Database.
insertlines([Head | Tail], Ticket) ->      
   [Date, Close, High, Low, Open, Volume] = string:tokens(Head, ","),
                   
   %% Due to some formating error i had to split the volume variable since it is the last on a row of stock data.
    Volume2 = re:split(Volume, ""),
    io:format([Date, Close, High, Low, Open, Volume2]),
       %% Sends the data from this module into the dbconnection module, the stock data an which ticker it belongs to.
        dbconnect:start([Date, Close, High, Low, Open, Volume2], Ticket),
  insertlines(Tail, Ticket);

insertlines([], Ticket) -> insertion_to_db_finished.


%% ====================================================================
%% Internal functions
%% ====================================================================

