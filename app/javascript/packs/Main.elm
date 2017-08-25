module Main exposing (..)

import Html exposing (Html, div, label, p, a, ul, li, h1, h3, text, button, input, select, option, button)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (id, style, href, name, for, type_, value, placeholder)
import Http
import Json.Decode as Decode
import Json.Encode as Encode

-- INIT

init : (Model, Cmd Message)
init =
  (Model nullRecord "", Cmd.none)

-- MODEL
conditions : List String
conditions = ["M", "NM", "VG+", "VG", "G+", "G", "F", "P"]

albumTypes : List String
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
    record: Record,
    message: String
}

nullRecord: Record
nullRecord = 
  let 
    album = 
      Album "" "" "" ""
  in
    Record "" "" album

-- MESSAGE

type Message
  = SetSides String
  | SetTitle String
  | SetAlbumType String
  | SetArtist String
  | SetReleased String
  | SetCondition String
  | AddRecord
  | AddRecordComplete (Result Http.Error String)

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
    SetAlbumType newAlbumType ->
      ({ model | record = 
        setAlbum (setAlbumType newAlbumType model.record.album) model.record }, Cmd.none )
    SetReleased newReleaseDate ->
      ({ model | record = 
        setAlbum (setReleased newReleaseDate model.record.album) model.record }, Cmd.none )
    SetArtist newArtist ->
      ({ model | record = 
        setAlbum (setArtist newArtist model.record.album) model.record }, Cmd.none )
    SetCondition newCondition ->
      ({ model | record = 
        setCondition newCondition model.record }, Cmd.none )
    AddRecord ->
      ( model, saveRecord model.record )
    AddRecordComplete result ->
      addRecordComplete model result

setSides: String -> Record -> Record
setSides newSides record= 
  { record | sides = newSides }

setCondition: String -> Record -> Record
setCondition newCondition record= 
  { record | condition = newCondition }

setAlbum: Album -> Record -> Record
setAlbum newAlbum record = 
  { record | album = newAlbum }

setAlbumTitle: String -> Album -> Album
setAlbumTitle newTitle album =
  { album | title = newTitle }

setAlbumType: String -> Album -> Album
setAlbumType newAlbumType album = 
  { album | albumType = newAlbumType }

setReleased: String -> Album -> Album
setReleased newReleaseDate album = 
  { album | released = newReleaseDate }

setArtist: String -> Album -> Album
setArtist newArtist album = 
  { album | artist = newArtist }

-- HTTP

saveRecord: Record -> Cmd Message
saveRecord record = 
  Http.send AddRecordComplete (saveRecordRequest record)

saveRecordRequest: Record -> Http.Request (String)
saveRecordRequest record = 
  Http.post "http://localhost:3000/api/v1/records" (Http.jsonBody (recordEncoder record)) recordDecoder 

recordEncoder: Record -> Encode.Value
recordEncoder record = 
  Encode.object
    [ ("sides", Encode.string record.sides )
    , ("condition", Encode.string record.condition )
    , ("album", Encode.object
      [ ("title", Encode.string record.album.title )
      , ("album_type", Encode.string record.album.albumType )
      , ("released", Encode.string record.album.released )
      , ("artist", Encode.string record.album.artist )
      ] )
    ]

addRecordComplete: Model -> Result Http.Error String -> ( Model, Cmd Message )
addRecordComplete model result =
  case result of
    Ok _ ->
      ( { model | record = nullRecord, message = "Added successfully" }, Cmd.none )

    Err error ->
      Debug.log (toString error)
      ( { model | message = "Invalid record data" }, Cmd.none ) 

recordDecoder: Decode.Decoder String
recordDecoder =
  Decode.field "errors" Decode.string

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
    , div [id "notifications", style [("display", "flex")]]
      [text model.message]

    , h3 []
      [text "Add new record"]

    , ul [ style [("list-style", "none")]]
      [ li[]
          [ label [ for "album_title" ]
            [text "Album Title:"]
        , input [ name "album_title", type_ "text", onInput SetTitle ] []
        ]
      , li[]
          [ label [ for "album_type" ]
            [text "Type of Album:"]
          , select [ name "album_type", onInput SetAlbumType ] 
            (List.map stringOption ("" :: albumTypes))
        ]
      , li[]
          [ label [ for "artist" ]
            [text "Artist:"]
        , input [ name "artist", type_ "text", onInput SetArtist ] []
        ]
      , li[]
          [ label [ for "released" ]
            [text "Released:"]
        , input [ name "released", type_ "text", onInput SetReleased ] []
        ]
      , li []
          [ label [ for "sides" ]
            [text "Sides:"]
          , input [ name "sides", type_ "text", onInput SetSides ] []
        ]
      , li[]
          [ label [ for "condition" ]
            [text "Condition:"]
          , select [ name "condition", onInput SetCondition]
            (List.map stringOption ("" :: conditions))
        ]
      ]
      , button [ onClick AddRecord ] [ text "Add" ]
      , p []
        [
          a [ href "/records"]
            [text "Back"]
        ]
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
