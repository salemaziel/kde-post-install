# npm-module-path

> Get the path of the given package(s) if it is installed globally or locally.

[![Travis Status](https://travis-ci.org/mrmlnc/npm-module-path.svg?branch=master)](https://travis-ci.org/mrmlnc/npm-module-path)
[![AppVeyor status](https://ci.appveyor.com/api/projects/status/81n2iq2h2cyef8mf?svg=true)](https://ci.appveyor.com/project/mrmlnc/npm-module-path)

## Install

```shell
$ npm i -S npm-module-path
```

## Why?

Primarily, this module is designed to search modules for VS Code (Language Server Extensions, etc).

  * Dependencies free.
  * Returns the path to the module directory (without `require`).
  * Can work with an array of dependencies.

## Usage

```js
const nmp = require('npm-module-path');

nmp.resolveOne('mocha').then((filepath) => {
	console.log(filepath); // ['/home/travis/.nvm/versions/node/v6.6.0/lib/node_modules/mocha']
});

nmp.resolveMany(['mocha', 'tslint']).then((filepaths) => {
	console.log(filepaths); // ['node_modules/mocha', '/usr/lib/node_modules/tslint']
});
```

## resolveOne(toResolve: string, root?: string, options?: IResolveOptions)
## resolveMany(toResolve: string[], root?: string, options?: IResolveOptions)

## IResolveOptions

**cache**

  * Type: `String`
  * Default: `.`

The root directory of the project to search the module.

**resolveDir**

  * Type: `Boolean`
  * Default: `false`

Return the path to the directory where the module was found.

**resolveOnlyByPrefix**

  * Type: `Boolean`
  * Default: `false`

Skip search modules in the default directories and search them only by `npm config get prefix`.

## Changelog

See the [Releases section of our GitHub project](https://github.com/mrmlnc/npm-module-path/releases) for changelogs for each release version.

## License

This software is released under the terms of the MIT license.
