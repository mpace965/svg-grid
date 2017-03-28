module Toggle exposing (..)


type Toggle a
    = On a
    | Off a


toggle : Toggle a -> Toggle a
toggle switch =
    case switch of
        On a ->
            Off a

        Off a ->
            On a


value : Toggle a -> a
value switch =
    case switch of
        On a ->
            a

        Off a ->
            a
