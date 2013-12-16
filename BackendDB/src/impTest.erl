
-module(impTest).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).

start() ->
	%% Examples of Values and their names that we got from Yahoo
	%%Date, Close, High, Low, Open, Volume
    %%20121128,582.9400,585.8000,572.2600,577.2700,18602300
 
	%% How the insertion list will look like when we have the desired values from the parser with variables
	%%Insertion = [D, C, H, L, O, V],
    %%Ticker = [T],

	D = "20121128",
	
Insertion = [D, "582.9400", "585.8000", "572.2600", "577.2700", "18602300"],
Ticker = ["aapl"],

dbconnect:start(Insertion, Ticker).

%% ====================================================================
%% Internal functions
%% ====================================================================


