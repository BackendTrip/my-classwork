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
  --ignore-convert-sound