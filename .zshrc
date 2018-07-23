# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/shadow/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  autojump
  common-aliases
  sublime
)

source $ZSH/oh-my-zsh.sh

# User configuration

#trying to set up aws sever here:
export PATH=~/.local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
mg() {
  [ -n "$1" ] && mkdir -p "$@" && cd $_;
}

alias vi="nvim"
alias vim="nvim"
alias omz="vim ~/.zshrc"
alias omzre="source ~/.zshrc"
alias nuke="rm -rf "
alias gpom="git pull origin master"
alias gpum="git push upstream master"
alias gs="git status"
alias gc="git checkout "
alias gpo="git push origin "
alias gpu="git push upstream"
alias gfa="git fetch --all"
alias pyman="python manage.py "
simplehtml () {
echo '<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Nashville Software School</title>
  <link rel="stylesheet" href="./'$1'">

</head>

<body>
  <nav></nav>

  <header></header>

  <article>
    <header></header>
    <section></section>
    <footer></footer>
  </article>

  <footer></footer>

  <script src="'$2'"></script>
</body>
</html>' >> index.html

  touch $1
  touch $2
  touch README.md
}

startProject () {
  mkdir src
  mkdir dist
  echo 'node_modules
.DS_Store
dist' >> .gitignore
  cd src
  echo '<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Nashville Software School</title>
  <link rel="stylesheet" href="./styles/'$1'">

</head>

<body>
  <nav></nav>

  <header></header>

  <article>
    <header></header>
    <section></section>
    <footer></footer>
  </article>

  <footer></footer>

  <script src="./bundle.js"></script>
</body>
</html>' >> index.html
  mkdir styles
  mkdir scripts
  touch styles/$1
  touch scripts/$2
  echo '{
    "parserOptions": {
        "ecmaVersion": 6,
        "sourceType": "module",
        "ecmaFeatures": {
            "jsx": true
        }
    },
    "rules": {
        "semi": 0,
        "quotes": [
            "error",
            "double"
        ],
        "eqeqeq": 2,
        "no-trailing-spaces": 2
    }
}' >> .eslintrc
  npm init
echo 'module.exports = function (grunt) {
    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),
        watch: {
            scripts: {
                files: [
                    "./scripts/**/*.js",
                    "./styles/**/*.css",
                    "./index.html",
                    "!node_modules/**/*.js"
                ],
                tasks: ["eslint", "browserify", "uglify", "copy"],
                options: {
                    spawn: false,
                },
            }
        },
        eslint: {
            src: [
                "./scripts/**/*.js",
                "!node_modules/**/*.js"
            ]
        },
        browserify: {
            options: {
                browserifyOptions: {
                    debug: true,
                    paths: ["./scripts"],
                }
            },
            dist: {
                files: {
                    "../dist/bundle.js": ["scripts/**/*.js"]
                }
            }
        },
        copy: {
            main: {
                files: [
                    // includes files within path
                    { expand: true, src: ["index.html"], dest: "../dist/", filter: "isFile" },
                    {expand: true, src: ["styles/*.css"], dest: "../dist/", filter: "isFile"}
                ]
            }
        },
        uglify: {
            options: {
                banner: "/*! <%= pkg.name %> <%= grunt.template.today(/yyyy-mm-dd/) %> */"
            },
            build: {
                files: [{
                    expand: true,
                    cwd: "../dist",
                    src: "bundle.js",
                    dest: "../dist",
                    ext: ".min.js"
                }]
            }
        }
    });
    // Load the plugin that provides the "uglify" task.
    grunt.loadNpmTasks("grunt-contrib-uglify-es");
    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.loadNpmTasks("grunt-eslint");
    grunt.loadNpmTasks("grunt-browserify");
    grunt.loadNpmTasks("grunt-contrib-copy");


    // Default task(s).
    grunt.registerTask("default", ["eslint", "browserify", "copy", "uglify", "watch"]);
};' >> Gruntfile.js
npm i grunt --save-dev
npm i grunt-browserify --save-dev
npm i grunt-contrib-copy --save-dev
npm i grunt-contrib-uglify-es --save-dev
npm i grunt-contrib-watch --save-dev
npm i grunt-eslint --save-dev
}

browserify () {
  mkdir -p src/scripts
  mkdir src/styles
  mkdir dist
  echo '    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta name="description" content="Nashville Software School Exercise" />
      <title>Nashville Software School Exercise</title>
      <link rel="stylesheet" href="./styles/filename.css">
    </head>
    <body>
      <script src="./bundle.js"></script>
    </body>
    </html>
  ' >> src/index.html
  touch src/scripts/main.js
  echo '    {
      "name": "'$1'",
      "version": "1.0.0",
      "description": "NSS Exercise",
      "main": "index.js",
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "repository": {
        "type": "git",
        "url": ""
      },
      "author": "Steve Brownlee <steve@stevebrownlee.com>",
      "license": "MIT",
      "bugs": {
        "url": ""
      },
      "homepage": "",
      "devDependencies": {
        "grunt": "^1.0.2",
        "grunt-browserify": "^5.3.0",
        "grunt-contrib-copy": "^1.0.0",
        "grunt-contrib-uglify-es": "git://github.com/gruntjs/grunt-contrib-uglify.git#harmony",
        "grunt-contrib-watch": "^1.0.0",
        "grunt-eslint": "^20.1.0",
        "uglify-es": "^3.3.9"
      }
    }
  ' >> src/package.json
  echo '    {
        "parserOptions": {
            "ecmaVersion": 6,
            "sourceType": "module",
            "ecmaFeatures": {
                "jsx": true
            }
        },
        "rules": {
            "semi": 0,
            "quotes": [
                "error",
                "double"
            ],
            "eqeqeq": 2,
            "no-trailing-spaces": 2
        }
    }
  ' >> src/.eslintrc
  echo 'module.exports = function(grunt) { grunt.initConfig({ pkg: grunt.file.readJSON("package.json"), watch: { scripts: { files: [ "./index.html", "./scripts/**/*.js", "./styles/**/*.css", "!node_modules/**/*.js" ], tasks: ["eslint", "browserify", "uglify", "copy"], options: { spawn: false, }, } }, browserify: { options: { browserifyOptions: { debug: true, paths: ["./scripts"], } }, dist: { files: { "../dist/bundle.js": ["./scripts/main.js"] } } }, uglify: { options: { banner: "/*! <%= pkg.name %> <%= grunt.template.today('\''yyyy-mm-dd'\'') %> */" }, build: { files: [{ expand: true, cwd: "../dist", src: "bundle.js", dest: "../dist", ext: ".min.js" }] } }, eslint: { src: [ "./scripts/**/*.js", "!node_modules/**/*.js" ] }, copy: { main: { files: [ { expand: true, cwd: ".", src: "styles/*", dest: "../dist/" }, { expand: true, cwd: ".", src: "index.html", dest: "../dist/" } ] } } }); grunt.loadNpmTasks("grunt-contrib-uglify-es"); grunt.loadNpmTasks("grunt-contrib-copy"); grunt.loadNpmTasks("grunt-contrib-watch"); grunt.loadNpmTasks("grunt-eslint"); grunt.loadNpmTasks("grunt-browserify"); grunt.registerTask("default", ["eslint", "browserify", "uglify", "copy", "watch"]); };' >> src/Gruntfile.js
  cd src
  npm install
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
