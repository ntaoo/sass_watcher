# Sass Watcher

Quick, fragile, transient hack to compile sass without pub transformer.

** This is intended only for my private Dart project. The spec may change without any information.**

### Usage

#### Install

    pub global activate --source git https://github.com/ntaoo/sass_watcher.git
    
#### Run

    sass_watcher --path=path-to-watch    

##### Options

--path : specify path to watch. The default value is './'.

##### Flags

--verbose : enable verbose mode (currently almost useless).    


### Ignore paths

'.pub', 'build', 'packages' is ignored.