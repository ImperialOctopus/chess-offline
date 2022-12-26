# Chess Offline

Cross-platform chess app for two people to play chess locally.

I used to love this two-player chess app I had back when I used an android tablet, but since switching to the Surface Pro I haven't been able to find one - this is that.

## Feature Summary

- Play chess with two players on the same device.
- No chess rules are enforced (e.g. piece movement, check, etc.).
- Long-press on an empty space to create new pieces
- Drag pieces off the board to remove them.
- More themes coming soon! (Maybe...)

## Installation (Windows)

1. Unzip downloaded file.
2. Put it wherever you like.

## Other Platforms

I haven't built this for any other platforms, but in theory it should work on all the Flutter platforms. Install Flutter etc. and run flutter create to add build support for all platforms:

    flutter create .

or specify which platforms to add:

    flutter create . --platforms ios,android,windows,linux,macos,web

and then run the build:

    flutter build linux

I haven't tried it but be aware that the AudioPlayers getting started guide specifies some prerequisites for linux only: https://github.com/bluefireteam/audioplayers/blob/main/packages/audioplayers_linux/requirements.md#requirements-for-linux
