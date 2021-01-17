# Overscribe

## Usage

### Fetch all collections

```shell
overscribe collections
```

### Fetch specific collection(s)

```shell
overscribe collections "The collections name starts with this"
```

### More

```shell
overscribe help
```

## Setup

Create a configuration file in `~/.overscribe.yaml` like:

```
directories:
  audio: '~/Music'
  video: '~/Videos'

collections:
  "Worakls/Sur le front des animaux menacés":
    url: https://www.youtube.com/playlist?list=OLAK5uy_mrpr_HvIdIey7xvzt82EPKRHsuorKOMM4
    mediatype: audio
    filename_pattern: '%(playlist_index)s. %(title)s.%(ext)s'

  "Thinkerview/Sciences":
    url: https://www.youtube.com/playlist?list=PLnRz6CkWwLlKnn_ggkzcvaBzmZjOoefJP
    mediatype: video
    filename_pattern: '%(upload_date)s - %(title)s.%(ext)s'
```

## Contributing

Pull requests are welcome on GitHub at https://github.com/neomilium/overscribe.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
