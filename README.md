<p align="center">
  <a href="http://github.com/bucaran/fish-getopts">
    <img alt="Shark" width=560px  src="https://cloud.githubusercontent.com/assets/8317250/12110311/571f4cba-b3ce-11e5-816f-e759b6029595.png">
  </a>
</p>

[![][travis-badge]][travis-link]

## Synopsis

```fish
getopts [options ...]`
getopts [options ...] | while read -l key value
    ...
end
```

## Description

`fish-getopts` is a [command line parser](https://en.wikipedia.org/wiki/Command-line_interface#Arguments) for [fish](https://github.com/fish-shell/fish-shell).

`getopts` is designed to process command line arguments that follow the POSIX [Utility Syntax Guidelines](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html).

If no arguments are given, `1` is returned.

## Usage

In the following example:

```fish
getopts -ab1 --foo=bar baz
```

And its output:

```fish
a
b    1
foo  bar
_    baz
```

The items on the _left_ represent the option flags or *keys* associated with the CLI. The items on the _right_ are the option *values*. The underscore `_` character is the default *key* for arguments without a key.

Use [`read(1)`](http://fishshell.com/docs/current/commands.html#read) to process the generated stream and [`switch(1)`](http://fishshell.com/docs/current/commands.html#switch) to match patterns:

```fish
getopts -ab1 --foo=bar baz | while read -l key option
    switch $key
        case _
        case a
        case b
        case foo
    end
end
```

## Alternatives

Traditionally, fish users do this:

```fish
for item in $argv
    switch "$item"
        case -f --foo
        case -b --bar
    end
end
```

The above does not support writing short options in a single argument `-fbz`, option values `--foo=baz`, `--foo baz` or `f baz`, negative assignment `--name!=value`, end of options `--` and dashes `-` and `--` are always part of the argument.

## Examples

The following is a mock of [`fish(1)`](http://fishshell.com/docs/current/commands.html#fish) CLI missing the implementation:

```fish
function fish
    set -l mode
    set -l flags
    set -l commands
    set -l debug_level

    getopts $argv | while read -l key value
        switch $key
            case c command
                set commands $commands $value

            case d debug-level
                set debug_level $value

            case i interactive
                set mode $value

            case l login
                set mode $value

            case n no-execute
                set mode $value

            case p profile
                set flags $flags $value

            case h help
                printf "usage: $_ [OPTIONS] [-c command] [FILE [ARGUMENTS...]]\n"
                return

            case \*
                printf "$_: '%s' is not a valid option.\n" $key
                return 1
        end
    end

    # Implementation
end
```

## Bugs

* `getopts` does **not** read the standard input. Use `getopts` to collect options and the standard input to process a stream of data relevant to your program.

* A double dash, `--`, marks the end of options. Arguments after this sequence are placed in the default underscore key, `_`.

* The `getopts` described in this document is **not** equivalent to the `getopts` *builtin* found in other shells. This tool is only available for [`fish(1)`](http://fishshell.com/docs/current/commands.html#fish).


## See Also

* POSIX [Utility Syntax Guidelines](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html)<br>


[travis-link]:  https://travis-ci.org/bucaran/fish-getopts
[travis-badge]: https://img.shields.io/travis/bucaran/fish-getopts.svg?style=flat-square
