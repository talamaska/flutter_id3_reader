# flutter_id3_reader_platform_interface

A common platform interface for the [`flutter_id3_reader`](../flutter_id3_reader) plugin.

This interface allows platform-specific implementations of the `flutter_id3_reader` plugin, as well as the plugin itself, to ensure they are supporting the same interface.

# Usage

To implement a new platform-specific implementation of `flutter_id3_reader`, extend [`FlutterId3ReaderPlatform`](lib/flutter_id3_reader_platform_interface.dart) with an implementation that performs the platform-specific behavior, and when you register your plugin, set the default `FlutterId3ReaderPlatform` by calling `FlutterId3ReaderPlatform.instance = MyPlatformFlutterId3Reader()`.

# Note on breaking changes

Strongly prefer non-breaking changes (such as adding a method to the interface) over breaking changes for this package.

See https://flutter.dev/go/platform-interface-breaking-changes for a discussion on why a less-clean interface is preferable to a breaking change.
