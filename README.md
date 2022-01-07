# podqueue
Automate the archiving of podcast feeds, including show notes and images.

This Python project aims for a simple user interface - you just need to modify `src/config.ini` with your inputs and outputs, and then schedule the program to run periodically.

# What does my config file look like?

The default `config.ini` looks like the below. You have two choices to run this app:

1) Edit this config file with your inputs and outputs, or
2) Overwrite these values with the CLI flags below.

```
[podqueue]
opml = example.opml
dest = podqueue-output/
# Please note, '%' in time_format must be escaped with '%%'
time_format = %%Y-%%m-%%dT%%H-%%M-%%S
verbose = False
```

# CLI arguments

As mentioned, if any of these CLI arguments are specified, they will **overwrite** any values in the config file.

* `-o`, `--opml` - Pass an OPML file that contains a podcast subscription list.
* `-d`, `--dest` - The destination folder for downloads. Will be created if required, including sub-directories for each separate podcast.
* `-t`, `--time_format` - Specify a time format string for JSON files. Defaults to '%Y-%m-%d' (2022-06-31) if not specified.
* `-v`, `--verbose` - Prints additional debug information. If excluded, only errors are printed (for automation).

# Where do I get my OPML?

This will depend on your podcast app, but most will be able to export your list of subscriptions into a common XML format.

If you use a different app that has a similar functionality, please let me know and I'll add it to this list.

| |Podcast App|OPML Export Options|
|---|---|---|
|<img src="https://www.pocketcasts.com/assets/images/roundel.svg" width=50 height=50>|Pocket Casts|[OPML export](https://support.pocketcasts.com/article/exporting-an-opml/)|
|<img src="https://upload.wikimedia.org/wikipedia/en/thumb/d/d9/Overcast_%28podcast_app%29_logo.svg/1280px-Overcast_%28podcast_app%29_logo.svg.png" width=50 height=50>|Overcast|Option available in the app's Settings page, or [here on the web.](https://overcast.fm/account/export_opml)|
|<img src="https://castro.fm/assets/images/Bitmap.svg" width=50 height=50>|Castro|[Export Subscriptions](https://castro.fm/support/export-subscriptions)|
|<img src="https://downcast.fm/images/downcast-site-logo.svg" width=50 height=50>|Downcast|[Exporting Podcast Subscriptions](https://support.downcast.fm/article/vYyHP2SOOc-exporting-podcast-subscriptions)|
|<img src="https://www.apple.com/v/apple-podcasts/b/images/overview/hero_icon__c135x5gz14mu_large.png" width=50 height=50>|Apple Podcasts|Not available in iOS app or macOS since Catalina. However, if you sync your podcasts to your Mac, there is an [open-source workaround.](https://liujiacai.net/podcasts-opml-exporter/)|
|<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Google_Podcasts_icon.svg/400px-Google_Podcasts_icon.svg.png" width=50 height=50>|Google Podcasts|Officially unavailable. There is a [Gist by @telmen](https://gist.github.com/telmen/4d67cba98ba7181424a681c1cbfc5f34) (I tested, seems to work) that can be run in your browser's Devtools if you're feeling lucky.|
|<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/1280px-Spotify_logo_without_text.svg.png" width=50 height=50>|Spotify|Not available, since Spotify doesn't use open Podcast standards. Community suggestion is ['now reaching the internal teams at Spotify'](https://community.spotify.com/t5/Live-Ideas/Podcasts-Import-for-Podcasts-OPML/idi-p/4423445), as of six months ago.|
|<img src="https://play-lh.googleusercontent.com/2wd59_1csnF1lIt6wG5DdBiDUFEeov1jIW9ax0scfwvDk_OUsK7-6LZ86I8MAsVCuhM=s180" width=50 height=50>|Stitcher|Unsupported.|
|<img src="https://www.podcastaddict.com/res/images/logo.svg" width=50 height=50>|Podcast Addict|[How can I backup and restore my subscription & data?](https://podcastaddict.com/faq/20)|
|<img src="https://play-lh.googleusercontent.com/kG4QJCsky97lbfX83zV2qQKUVuFQj07Ot9EJJvHt1meM5WjUXl3T96KRIPlSf-tHAfI=s180" width=50 height=50>|Castbox|[OPML Export](https://helpcenter.castbox.fm/portal/en/kb/articles/settings-on-the-personal-tab-android#OPML_Export)|

Your file should look something like this, with one line per podcast:

```
<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<opml version="1.0">
  <head>
    <title>Pocket Casts Feeds</title>
  </head>
  <body>
    <outline text="feeds">
      <outline type="rss" text="Accidental Tech Podcast" xmlUrl="https://atp.fm/episodes?format=rss" />
      <outline type="rss" text="The Unmade Podcast" xmlUrl="https://www.unmade.fm/episodes?format=rss" />
      <outline type="rss" text="You Look Nice Today" xmlUrl="https://feeds.fireside.fm/youlooknicetoday/rss" />
      <outline type="rss" text="The Pen Addict" xmlUrl="https://www.relay.fm/penaddict/feed" />

      ... etc ...

    </outline>
  </body>
</opml>
```

# How to run

Execute the below to download each podcast into their own subdirectory, with episode metadata (shownotes, date, title, link) and show metadata (episode count, description, image) in each subdirectory. Episodes will be downloaded in default feed order - usually newest first, but it could depend on the podcast.

```
$ py src/main.py -v --opml <<FILE.xml>> --dest output/
```

Example output:
```
output/
├─ Accidental_Tech_Podcast/
├─ episodes/
│  ├─ 2021-12-30_463__No_Indication_of_Progress.json
│  ├─ 2021-12-30_463__No_Indication_of_Progress.mp3
│  ├─ 2022-01-06_464__Monks_at_Drafting_Tables.json
│  ├─ 2022-01-06_464__Monks_at_Drafting_Tables.mp3
├─ Accidental_Tech_Podcast.png
├─ Accidental_Tech_Podcast.json

```