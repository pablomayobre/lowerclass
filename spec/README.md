# Spec

This spec was taken from [Kikito's Middleclass](https://github.com/kikito/middleclass/tree/master/spec)

The idea is to use the same spec to guarantee that the behaviour of Lowerclass matches that of Middleclass

## Run

This specs use [busted](http://olivinelabs.com/busted/). If you want to run the specs, you will have to install it first. Then just execute the following command:

```bash
cd /folder/where/the/spec/folder/is
busted
```

## Changes

The following changes have been made to the spec:

`mixin_spec.lua`:
* Disabled the file entirely since Mixins are not implemented.

`class_spec.lua`
* Disabled `include` tests since Mixins are not implemented.
* Disabled `Class.static:subclassed` test since Static is not implemented.
* Disabled `Class.subclasses` test since it's not implemented.
* Disabled Static (Attributes and Methods) tests since Static is not implemented

`default_methods_spec.lua`
* Disabled `Class:allocate` tests since it's not implemented

`metamethods_spec.lua`
* Metamethods can't be inherited (applies to `metamethods_lua_5_2.lua` and `metamethods_lua_5_3.lua` too)
* Disabled `Class:__index` tests since it's not implemented
* Disabled Functions tests (for `__index` and `__newindex`) since `Class:__index` is not implemented

## License

This spec is licensed under the terms of the MIT License

Copyright (c) 2011 Enrique García Cota @Kikito
