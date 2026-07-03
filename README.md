# contracts-media-admin

Protobuf/gRPC contract interfaces for media library admin services in MuxCore. Core never imports this proto — it is a domain contract between media modules and the admin UI.

## Proto Service

- **`MediaAdminService`** (`proto/muxcore/media/admin/v1/media_admin.proto`)
  - `GetMediaTypeInfo` — return display name, icon, and filter fields for the admin UI nav tab
  - `ListItems` / `GetItem` — paginated browsing and detail retrieval
  - `UpdateMetadata` — edit media metadata fields
  - `ListArtwork` / `ReplaceArtwork` — manage artwork images (posters, backgrounds, etc.)
  - `DeleteItem` / `RefreshItem` — remove or re-fetch metadata from original sources
  - `SearchIndexers` — search configured indexers for download sources

## Implementing Modules

- [media-movies](https://github.com/Muxcore-Media/media-movies) — movie library manager
- [media-tvshows](https://github.com/Muxcore-Media/media-tvshows) — TV show library manager
