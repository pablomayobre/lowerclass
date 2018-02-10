# Lowerclass

[![Build Status](https://travis-ci.org/Positive07/lowerclass.png?branch=master)](https://travis-ci.org/Positive07/lowerclass)
[![Coverage Status](https://coveralls.io/repos/Positive07/lowerclass/badge.svg?branch=master&service=github)](https://coveralls.io/github/Positive07/lowerclass?branch=master)

A simple OOP library for Lua. It has inheritance and metamethods (operators). It uses the same API as Middleclass (with some small differences) but tries to be small and fast.

> Note: For an even smaller class library take a look at [this Gist](https://gist.github.com/Positive07/98cde5497110bbeea8b729a48780a241)

## Documentation

As said before, this library shares the same API as Middleclass, with some differences.

This means that you can take a look at the [Middleclass wiki](https://github.com/kikito/middleclass/wiki) for examples & documentation.

While taking into account the next few differences:
- `static` methods are not supported.
- `__index` metamethod is not supported, changing it may create errors.
- `allocate` is not part of the class, instead a [private function](https://github.com/Positive07/lowerclass/blob/master/lowerclass.lua#L39L48) is used.
- Mixins are not supported so `include` is not supported.
- `Child.subclasses` are currently [commented out](https://github.com/Positive07/lowerclass/blob/master/lowerclass.lua#L78L81) to keep the simplicity, they could easily be added.
- Metamethods are not inherited (Issue #1)

## Installation

Just copy the `lowerclass.lua` file wherever you want it (for example on a lib/ folder). Then write this in any Lua file where you want to use it:

```lua
local class = require 'lowerclass'
```

## More

Check the `spec` folder for info on the spec.

Check the `performance` folder for info on the performance tests.

## License

Lowerclass is distributed under the MIT license.
