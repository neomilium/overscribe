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
profiles:
  audio:
    directory: '~/Music'
    youtubedl_args: ['--format', 'bestaudio', '--extract-audio']
  audio:album:
    directory: '~/Music'
    youtubedl_args: ['--format', 'bestaudio', '--extract-audio']
    filename_pattern: '%(playlist_index)s. %(title)s.%(ext)s'
  video hd:
    directory: '~/Videos'
    youtubedl_args: ['--format' 'bestvideo+bestaudio']
  video:interview:
    directory: '~/Videos'
    youtubedl_args: ['--format', 'bestvideo[height<800]+bestaudio']
    filename_pattern: '%(upload_date)s - %(title)s.%(ext)s'

collections:
  "Worakls/Sur le front des animaux menacés":
    url: https://www.youtube.com/playlist?list=OLAK5uy_mrpr_HvIdIey7xvzt82EPKRHsuorKOMM4
    profile: audio:album

  "Thinkerview/Sciences":
    url: https://www.youtube.com/playlist?list=PLnRz6CkWwLlKnn_ggkzcvaBzmZjOoefJP
    profile: video:interview
```

### YoutubeDL

_Overscrive_ relies on [youtube-dl](https://youtube-dl.org/).

In configuration file, `youtubedl_args` and `filename_pattern` options should be set according to [youtube-dl documentation](https://github.com/ytdl-org/youtube-dl/blob/master/README.md)

## Contributing

Pull requests are welcome on GitHub at https://github.com/neomilium/overscribe.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
