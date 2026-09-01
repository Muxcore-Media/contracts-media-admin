# Compatibility

| Component | Requirement |
|-----------|-------------|
| Contract interface | `MediaAdminService` **v1** |
| Go module path | `github.com/Muxcore-Media/contracts-media-admin` |
| Generated package | `github.com/Muxcore-Media/contracts-media-admin/gen/muxcore/media/admin/v1` |
| MuxCore core | ≥ 0.4.0 (consumers) |
| Capability ID (contract repo) | `contracts.media-admin` |
| Capability ID (implementers / callers) | per media module (`movies`, `tvshows`, `music`, …) |

Implementers register their library capability in `muxcore.json` and implement gRPC service **`MediaAdminService`**. The contract repository capability id identifies this proto module in the umbrella catalog.

## Per-type Unimplemented RPCs

Callers must tolerate `Unimplemented` from libraries that do not support a feature:

| RPC | Movies | TV | Music |
|-----|--------|----|-------|
| `GetCalendar` | Unimplemented | Implemented | Unimplemented |
| `ListCollections` / `GetCollectionItems` / `SyncCollection` / `SetCollectionMonitored` | Implemented | Unimplemented | Unimplemented |
| `ListChildren` / `GetChild` | Unimplemented (flat list) | Implemented | Partial (albums/tracks when wired) |
| `ListRemoteArtwork` / `DeleteArtwork` / `ReplaceArtwork` | Implemented (fixture/metadata) | Implemented | Unimplemented |
| `SearchIndexers` / `GrabRelease` | Implemented (automation stub) | Implemented | Unimplemented |

## First-class vs metadata fields

`MediaItem` and `UpdateMetadataRequest` expose shared operator fields:

| Field | Purpose |
|-------|---------|
| `monitored` | Include in acquisition/missing scans |
| `has_file` | On-disk file linked |
| `quality_profile_id` | Custom format / quality profile |
| `root_folder_path` | Library root for new imports |
| `tmdb_id` | TMDB identifier (movies/TV) |

Type-specific keys remain in `metadata` until promoted:

| Key | Types |
|-----|-------|
| `runtime` | Movies (minutes) |
| `musicbrainz_id` | Music |
| `season_number`, `episode_number`, `air_date` | TV |

Implementers may mirror first-class values into `metadata` during migration; callers should prefer the typed fields.

## Indexer grab path

- `SearchIndexers` returns opaque `guid` values plus quality signals (`approved`, `reject_reasons`, `score`, `protocol`).
- Admin grab uses **`GrabRelease(item_id, guid)`** — not raw `download_url`.
- `IndexerResult.download_url` is deprecated and may be empty.

## Enums vs legacy strings

`Feature`, `HistoryEventType`, `SortField`, `ArtworkType`, and `FilterFieldType` replace prior free-form strings. Regenerate consumer stubs after bumping this contract.

Breaking proto changes require a new major contract version and coordinated consumer updates.
