module Main exposing (..)

import Html exposing (Html, div, label, ul, li, h1, h3, text, button, input, select, option, button)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (id, style, name, for, type_, value, placeholder)
import Http exposing (..)

-- INIT

init : (Model, Cmd Message)
init =
  let 
    album = 
      Album "" "" "" ""
    record = 
      Record "" "" album
  in
   (Model record, Cmd.none)

-- MODEL

conditions = ["M", "MN", "VG+", "VG", "G+", "G", "F", "P"]
albumTypes = ["Album", "Single", "Compilation"]  

type alias Record = 
  {
    sides: String,
    condition: String,
    album: Album
  }

type alias Album =
  {
    title: String,
    artist: String,
    albumType: String,
    released: String
  }

type alias Model = 
  {
    record: Record
  }


-- MESSAGE

type Message
  = SetSides String
  | SetTitle String
  | SetArtist String
  | AddRecord

-- UPDATE
update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    SetSides newSides ->
      ({ model | record = 
        setSides newSides model.record }, Cmd.none )
    SetTitle newTitle ->
      ({ model | record = 
        setAlbum (setAlbumTitle newTitle model.record.album) model.record }, Cmd.none )
    SetArtist newArtist ->
      ({ model | record = 
        setAlbum (setArtist newArtist model.record.album) model.record }, Cmd.none )
    AddRecord ->
      (model, Cmd.none)

setSides: String -> Record -> Record
setSides newSides record= 
  { record | sides = newSides }

setAlbum: Album -> Record -> Record
setAlbum newAlbum record = 
  { record | album = newAlbum }

setAlbumTitle: String -> Album -> Album
setAlbumTitle newTitle album = 
  { album | title = newTitle }

setArtist: String -> Album -> Album
setArtist newArtist album = 
  { album | artist = newArtist }


-- HTTP


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.none

-- VIEW

stringOption : String -> Html Message
stringOption strValue =
  option [ value strValue ][ text strValue ]

view : Model -> Html Message
view model =
  div [id "body", style [("justify-content", "center")]]
    [ h1 [style [("display", "flex"), ("justify-content", "center")]]
      [text "Welcome to Vinyl"]

    , h3 []
      [text "Add new record"]

    , ul []
      [ li[]
          [ label [ for "album_title" ]
            [text "Album Title:"]
        , input [ name "album_title", type_ "text", onInput SetTitle ] []
        ]
      , li[]
          [ label [ for "album_type" ]
            [text "Type of Album:"]
          , select [ name "album_type" ] 
            (List.map stringOption ("" :: albumTypes))
        ]
      , li[]
          [ label [ for "artist" ]
            [text "Artist:"]
        , input [ name "artist", type_ "text", onInput SetArtist ] []
        ]
      , li []
          [ label [ for "sides" ]
            [text "Sides:"]
          , input [ name "sides", type_ "text", onInput SetSides ] []
        ]
      , li[]
          [ label [ for "condition" ]
            [text "Condition:"]
          , select [ name "condition" ]
            (List.map stringOption ("" :: conditions))
        ]
      ]
      , button [ onClick AddRecord ] [ text "Add" ]
    ]

-- MAIN

main : Program Never Model Message
main =
  Html.program
    {
      init = init,
      view = view,
      update = update,
      subscriptions = subscriptions
    }
