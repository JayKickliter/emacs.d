# My emacs config

This is a fork of @purcell's [emacs.d](https://github.com/purcell/emacs.d).
Thanks purcell for the great foundation.




## Installation

Note, these instructions are really meant for me, so they only apply to OS X.

First backup your current `.emacs.d` and clone this one:

```sh
$ cd ~
$ mv .emacs.d .emacs.d.bak
$ git clone https://github.com/jaykickliter/emacs.d .emacs.d
$ emacs
```

For `Flyspell` spelling correction install:
```sh
$ brew install ispell
```

For c development I recommend installing these additional tools:
```sh
$ brew install global --with-ctags
$ brew install llvm --with-clang --with-clang-extra-tools
$ brew install bear
```



## c development

### Install [`irony-mode`](https://github.com/Sarcasm/irony-mode)'s server

```M-x irony-install-server [RET]```

`irony-mode` provides AST-level c-completions. If you open a c file before
installing `irony-mode`'s server, emacs will likely lock up for some reason I
haven't figured out.


### Generate compilation database for your c project

For `irony-mode` to work, it needs to find `compile_commands.json` file in your
project tree. To generate `compile_commands.json`, run one of the following
commands at the root of your project.

For Makefile a project:
```sh
$ make clean
$ bear make
```
For a ninja project:
```sh
$ ninja -t compdb cc > compile_commands.json
```

### gtags

For [`helm-gtags`](https://github.com/syohex/emacs-helm-gtags) support, run
`M-x helm-gtags-create-tags [RET]` and select the root of your project as the
locaiton to save the tags file. For any other options, just select default.

