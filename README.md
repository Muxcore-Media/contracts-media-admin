# contracts-media-admin

Protobuf/gRPC contract interfaces for media library admin services in MuxCore. Core never imports this proto — it is a domain contract between media modules and the admin UI.

Go module: `github.com/Muxcore-Media/contracts-media-admin`  
Generated package: `gen/muxcore/media/admin/v1` (`mediaadminv1`)

## Proto Service

- **`MediaAdminService`** (`proto/muxcore/media/admin/v1/media_admin.proto`)
  - `GetMediaTypeInfo` — display name, icon, filter fields, and `features` flags (`missing`, `tags`, `collections`, `calendar`) for the admin UI
  - `ListItems` / `GetItem` — paginated browsing (optional `tag_id` filter) and detail retrieval
  - `UpdateMetadata` — edit media metadata fields
  - `ListArtwork` / `ReplaceArtwork` — manage artwork images (posters, backgrounds, etc.); `ReplaceArtwork` is client-streaming
  - `DeleteItem` / `RefreshItem` — remove (`delete_files` optional) or re-fetch metadata from original sources
  - `SearchIndexers` — search configured indexers for download sources
  - `ListHistory` — grab/import/delete activity
  - `ListMissing` — monitored items without files
  - `ListTags` / `CreateTag` / `DeleteTag` / `SetItemTags` — tag management
  - `ListCollections` / `GetCollectionItems` — collections (movies; TV Unimplemented)
  - `GetCalendar` — air-date calendar (TV; movies Unimplemented)

## Implementing Modules

- [media-movies](https://github.com/Muxcore-Media/media-movies) — movie library manager
- [media-tvshows](https://github.com/Muxcore-Media/media-tvshows) — TV show library manager
