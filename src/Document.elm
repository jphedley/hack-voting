module Document exposing (..)

import Native.Document


locationHref : () -> String
locationHref =
    Native.Document.locationHref


locationOrigin : () -> String
locationOrigin =
    Native.Document.locationOrigin
