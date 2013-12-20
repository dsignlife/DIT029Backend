-module(ini).

%% ====================================================================
%% API functions
%% ====================================================================
%% Author Patric Lövgren Berg
-export([start/0, ini/1]).

start() ->
	%% Starts the inets service
	inets:start(),
	%%Takes the result of insert:into_list and putting it in an variable named list.
	List = insert:into_list("C:/Users/LB/Documents/erlangshiet/tickers.txt"),
           request(List).
    
%% An head/tail recursive function that takes in a list with tickers and sends the current ticket that is going to be mined to the ini/1.
request([Head | Tail]) -> 
	io:format(Head),
	
       ini(Head),

  request(Tail);

request([]) -> done.

%% Initiate the datamining function which takes in the ticker that needs to be mined.
ini(Tickers) ->
	    %% The path of the .txt file which is going to be our fallback when parsing the data.
        Name = "C:/Users/LB/Documents/erlangshiet/parser.txt",
		%% Removes a hidden \n in the ticker data 
		Ticket = string:tokens(Tickers, "\n"),
		io:format(Ticket),
		%% The URL which is going to be datamined
		URL = "http://chartapi.finance.yahoo.com/instrument/1.0/"++Ticket++"/chartdata;type=quote;range=1y/csv",
		io:format(URL),
		      
		%%Requesting the html page via httpc library/functions
     {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(URL),
        Data = Body,
        
        %% Opens the parser.txt file
        {ok, IODevice} = file:open(Name, [write]),
        %% Writes the webpage data to the .txt document
        file:write(IODevice, Data),
		%% CLosing the file.
        file:close(IODevice),

        %% Calling this function removes the 18 firsts lines in the parser.txt document since it is unrelevant data.
        remove_lines:from_file(Name, 1, 18),
		
    %% Calling this function initiates the insertion of data in the .txt file to the database
    insert:initiate(Ticket).


