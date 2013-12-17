-module(getCsv).
-export([readlines/0, get_all_lines/1, parse/1]).
parse(List) ->
    Lines = re:split(List, ","),
 io:get_line(Lines).
         

readlines() ->
 {ok, Device} = file:open("C:/Users/LB/Documents/erlangshiet/parser.txt", [read]),
  try get_all_lines(Device)
 after file:close(Device),
    parse(Device)
  end.

get_all_lines(Device) ->
  case io:get_line(Device, "" ) of
   eof -> [];
   Line -> parse(Line),     
     get_all_lines(Device)
               end.

%% C:\Users\LB\workspace\BackendDB1\src


%% C:/Users/LB/workspace/BackendDB1/src