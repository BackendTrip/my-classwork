# musical [![Build Status](https://travis-ci.org/katsuma/musical.png?branch=master)](https://travis-ci.org/katsuma/musical) [![Coverage Status](https://coveralls.io/repos/katsuma/musical/badge.png)](https://coveralls.io/r/katsuma/musical)

`musical` is a simple tool for your favorite music DVD.

You can rip vob files by each DVD chapter, convert them to wav file and add them to your iTunes library.


## Install

`musical` depends on `dvdbackup` and `ffmpeg`.
To install them try this for example.

```sh
brew install dvdbackup
brew install ffmpeg
```

And install gem.

```sh
gem install musical
```


## Usage
Set your DVD and type

```sh
musical <options>
```

Options:
```sh
                  --info, -i:   Show your DVD data
  --ignore-convert-sound, -g:   Rip data only, NOT convert them to wav file
     --ignore-use-itunes, -n:   NOT add ripped files to iTunes and encode them
              --path, -p <s>:   Set device path of DVD
             --title, -t <s>:   Set DVD title (default: LIVE)
            --artist, -a <s>:   Set DVD artist (default: Artist)
              --year, -y <i>:   Set year DVD was recorded (