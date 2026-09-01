# contracts-media-admin

Protobuf/gRPC contract interfaces for media library admin services in MuxCore. Core never imports this proto — it is a domain contract between media modules and the admin UI.

Go module: `github.com/Muxcore-Media/contracts-media-admin`  
Generated package: `gen/muxcore/media/admin/v1` (`mediaadminv1`)

Regenerate after editing the proto:

```bash
make proto
```

## Proto Service

- **`MediaAdminService`** (`proto/muxcore/media/admin/v1/media_admin.proto`)
  - `GetMediaTypeInfo` — display name, icon, filter fields, and `Feature` flags for the admin UI
  - `ListItems` / `GetItem` — paginated browsing (optional `tag_id` filter) and detail retrieval
  - `ListChildren` / `GetChild` — hierarchy under a parent (seasons/episodes, albums/tracks)
  - `UpdateMetadata` / `SetMonitored` — edit metadata and monitor state
  - `ListArtwork` / `ListRemoteArtwork` / `ReplaceArtwork` / `DeleteArtwork` — artwork management
  - `DeleteItem` / `RefreshItem` — remove (`delete_files` optional) or re-fetch metadata from original sources
  - `SearchIndexers` / `GrabRelease` — search indexers and queue downloads by opaque `guid`
  - `ListFiles` / `RemoveFile` — on-disk file management
  - `ListHistory` — grab/import/delete activity
  - `ListMissing` — monitored items without files
  - `ListTags` / `CreateTag` / `DeleteTag` / `SetItemTags` — tag management
  - `ListCollections` / `GetCollectionItems` / `SyncCollection` / `SetCollectionMonitored` — collections (movies; TV Unimplemented)
  - `GetCalendar` — air-date calendar (TV; movies Unimplemented)

See [`COMPATIBILITY.md`](COMPATIBILITY.md) for per-library `Unimplemented` matrix and migration notes.

## Implementing Modules

- [media-movies](https://github.com/Muxcore-Media/media-movies) — movie library manager
- [media-tvshows](https://github.com/Muxcore-Media/media-tvshows) — TV show library manager
- [media-music](https://github.com/Muxcore-Media/media-music) — music library manager (flat artist list; partial admin surface)
