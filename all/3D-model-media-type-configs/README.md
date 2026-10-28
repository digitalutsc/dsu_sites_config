# 3D Object media type: exported config

Exported 2026-10-27 from the memory replica (`memory.islandora.io`, active config, `drush config:export`).
This is the media type used by the **DGI 3D viewer** (`discoverygarden/dgi_3d_viewer`).

## Contents

`config/` holds the 42 files to import. `shared-dependencies/` is a separate folder so an import of `config/`
does not pick it up: Drupal reads subfolders of an import source as config collections.

| Group | Files |
|---|---|
| Media type | `media.type.3d_object` |
| Media fields | `field.field.media.3d_object.*`. New: `field_customcamera`, `field_camera`, `field_materials_zip`, `field_room_environment`, `field_add_default_lights`, `field_background_color`. Shared with other media types: `field_media_file` (`glb gltf obj`, private), `field_media_use`, `field_access_terms`, `field_media_file_fits` |
| New media storages | `field.storage.media.field_{customcamera,camera,materials_zip,room_environment,add_default_lights,background_color}` |
| Media displays | `core.entity_form_display.media.3d_object.default` (3D Model File widget with preview), `core.entity_view_display.media.3d_object.default` (3D Model File formatter) |
| Camera paragraph | `paragraphs.paragraphs_type.perspective_camera_settings`, its 10 decimal fields and storages (`field_fov`, `field_aspect`, `field_near`, `field_far`, `field_position_{x,y,z}`, `field_rotation_{x,y,z}`), form and view displays |

`shared-dependencies/` holds config that the files above depend on and that Islandora sites already have: the
storages `field_media_file`, `field_media_use`, `field_access_terms`, `field_media_file_fits` and the vocabularies
`islandora_media_use`, `islandora_access`. They are included for reference only. **Do not import them into a
site that already has them**: their UUIDs differ per site.

## Requirements on the target site

Enabled modules: `dgi_3d_viewer`, `paragraphs`, `entity_reference_revisions`, `media`, `file`, `path`, `taxonomy`,
`json_field` (for `field_media_file_fits`), plus the shared storages and vocabularies above.

## Importing

Into the same site's `config/sync` (memory): copy `config/*.yml` into `config/sync/` and run `drush cim`.

Into another site, without touching the rest of its config:

```bash
drush config:import --partial --source=/path/to/3D-model-media-type-configs/config
```

On a different site, remove the `uuid:` line from each file first (`sed -i '/^uuid: /d' config/*.yml`). A UUID belongs to the site the file came from.

## Known issue

dgi_3d_viewer v1.6.0 (and upstream `main`) saves the camera values as nested arrays, and its JavaScript then reads
them as `NaN`. A media item with a **Camera** set does not render; leave the camera empty (the viewer uses the
GLB's own camera or frames the model). Locally, the `threejs` 1.0.9 module also needs the namespace patch
`assets/patches/threejs_hook_namespace_d11.patch` in `islandora-lite-site`, but `threejs` is not required by
this media type.
