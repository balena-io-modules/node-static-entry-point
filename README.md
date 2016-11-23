Node Static Entry Point
=======================


| GNU/Linux & macOS | Windows |
|-------------------|---------|
| [![Build Status](https://travis-ci.org/resin-io-modules/node-static-entry-point.svg?branch=master)](https://travis-ci.org/resin-io-modules/node-static-entry-point) | [![Build status](https://ci.appveyor.com/api/projects/status/m7aa764i7jo1kq9x/branch/master?svg=true)](https://ci.appveyor.com/project/resin-io/node-static-entry-point/branch/master) |

This script builds a patched version of NodeJS that locks its entry point to a
file called `index.js` present in the same directory as the NodeJS binary.
Every option passed to the binary is forwarded to the `index.js` file.

For example, this command:

```sh
/path/to/node foo bar baz
```

gets translated to the following under the hood:

```
/path/to/node /path/to/index.js foo bar baz
```

This is very handy for releasing standalone command-line NodeJS applications,
since we can concatenate all files as a single `index.js`, and ship the patched
NodeJS binary called according to our application.

Downloading
-----------

See the [GitHub Releases][github-releases] page for pre-made binaries.

Dependencies
------------

- [NodeJS building pre-requisites][node-building]

### Windows

- [GNU Make][gnumakewin32]

Building
--------

```
make build-x64
make build-x86
```

Support
-------

If you're having any problem, please [raise an issue][newissue] on GitHub and
the resin.io team will be happy to help.

License
-------

`node-static-entry-point` is free software, and may be redistributed under the
terms specified in the [license].

[gnumakewin32]: http://gnuwin32.sourceforge.net/packages/make.htm
[node-building]: https://github.com/nodejs/node/blob/master/BUILDING.md
[github-releases]: https://github.com/resin-io-modules/node-static-entry-point/releases
[newissue]: https://github.com/resin-io-modules/node-static-entry-point/issues/new
[license]: https://github.com/resin-io-modules/node-static-entry-point/blob/master/LICENSE
