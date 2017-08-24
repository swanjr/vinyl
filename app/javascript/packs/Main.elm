module Main exposing (..)

import Html exposing (Html, div, label, ul, li, h1, h3, text, button, input, select, option, button)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (id, style, name, for, type_, value, placeholder)

-- TYPES

--type Condition = M | NM | VG Plus | VG | G Plus | G | F | P 
--type AlbumType = Album | Single | Compilation

-- MODEL

conditions = ["M", "MN", "VG+", "VG", "G+", "G", "F", "P"]
albumTypes = ["Album", "Single", "Compilation"]  

type alias Record = 
  {
    title: String,
    condition: String,
    album: Album
  }

type alias Album =
  {
    name: String,
    artists: String,
    albumType: String,
    released: String
  }

type alias Model = 
  {
    record: Record
  }

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

-- VIEW

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
      [ li []
        [ label [ for "title" ]
          [text "Title:"]
        , input [ name "title", type_ "text", onInput SetTitle ] []
      ]
      , li[]
          [ label [ for "condition" ]
            [text "Condition:"]
          , select [ name "condition" ]
            (List.map stringOption ("" :: conditions))
        ]
      , li[]
          [ label [ for "album_name" ]
            [text "Album Name:"]
        , input [ name "album_name", type_ "text", onInput SetAlbumName ] []
        ]
      , li[]
          [ label [ for "album_type" ]
            [text "Type of Album:"]
          , select [ name "album_type" ] 
            (List.map stringOption ("" :: albumTypes))
        ]
      , li[]
          [ label [ for "artists" ]
            [text "Artists:"]
        , input [ name "artists", type_ "text", placeholder "artist1, artist2, ...", onInput SetArtists ] []
        ]
      ]
      , button [ onClick AddRecord ] [ text "Add" ]
    ]


-- MESSAGE

type Message
  = SetTitle String
  | SetAlbumName String
  | SetArtists String
  | AddRecord

-- UPDATE

setTitle: String -> Record -> Record
setTitle newTitle record= 
  { record | title = newTitle }

setAlbum: Album -> Record -> Record
setAlbum newAlbum record = 
  { record | album = newAlbum }

setAlbumName: String -> Album -> Album
setAlbumName newName album = 
  { album | name = newName }

setArtists: String -> Album -> Album
setArtists newArtists album = 
  { album | artists = newArtists }

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    SetTitle newTitle ->
      ({ model | record = 
        setTitle newTitle model.record }, Cmd.none )
    SetAlbumName newName ->
      ({ model | record = 
        setAlbum (setAlbumName newName model.record.album) model.record }, Cmd.none )
    SetArtists newArtists ->
      ({ model | record = 
        setAlbum (setArtists newArtists model.record.album) model.record }, Cmd.none )
    AddRecord ->
      (model, Cmd.none)


-- HTTP


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.none

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
