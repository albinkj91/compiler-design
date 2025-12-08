some_function(Argument1, Argument2) ->
    case Argument1 =< Argument2 of
        true ->
            <<"le", Argument2>>; % return a binary here
        false ->
            _LocalVariable = another_function(Argument1),
            42 + _LocalVariable % return a number here
    end.
