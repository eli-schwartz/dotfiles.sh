# Dotfiles made easy
So you've decided to version-control your dotfiles, and you're looking for a way to do it for you, and all of a sudden you hit this snag. It's a pretty simple snag, but no one really seems to have a nice solution for it: symlink farms linking all your files into `$HOME` is ugly, but so is turning `$HOME` itself into a git repository annd having all your git metadata there (for example, ensuring that `git` commands will always fall back to acting on your dotfiles). :( If only there was some way to have the best of both worlds...

Enter dotfiles, a simple wrapper around git that runs all git commands with a custom `$GIT_DIR`, allowing metadata to be stored separate from the files. gitignore and gitattributes files can be easily hidden through the use of sparse checkout. A handful of administrative commands are also provided to bootstrap the repository.

## Usage
* `dotfiles init /path/to/metadata`
> Initialize a new bare git repository, configured to treat `$HOME` as the worktree. `$GIT_DIR/info/sparse-checkout` is seeded with .gitignore, .gitattributes, and README.md. `$GIT_DIR/info/exclude` is seeded with a gitignore file ignoring common types of uninteresting files. Configure git status to not list untracked files.

* `dotfiles clone protocol://domain.name/repo.git /path/to/metadata`
> Instead of init'ing a new repo, clone it from somewhere, and try to extract a usable gitignore/gitattributes and copy it to `$GIT_DIR/info/`. If it is possible to do so without overwriting, checkout all files too.

* `dotfiles ignore [PATTERN] ...`
> Append new patterns to `$GIT_DIR/info/exclude`, or directly edit it if no patterns are given. Then utilize the git plumbing to add the file contents to the index as .gitignore itself.

* `dotfiles attributes [ATTRIBUTES] ...`
> Append new gitattribute lines to `$GIT_DIR/info/attributes` and... well, you get the drill. :)

* `dotfiles readme`
> Edit your README.md in a temporary file so you can talk about what it does etc. Once again this is directly read into the index without actually manifesting in `$HOME` (because having some readme file in your home directory is cluttersome, but you still want it to show up on Github or wherever).

## Encrypting secret files.
No especial effort has been taken to magically take care of files that should be synced, but not everyone should be able to read. I've found that I don't need to reinvent the wheel, as [git-crypt](https://www.agwa.name/projects/git-crypt/) works very well in that regard without extra effort. Simply add the following `dotfiles attributes` lines, then commit the secret files like any other:

```
[attr]crypt      filter=git-crypt diff=git-crypt

fileglob1        crypt
.bash_secrets    crypt
[...]
```

The git-crypt key will be stored in `$GIT_DIR/git-crypt/` and can be exported and transferred separately.

## Using on Mac OS X
Install coreutils from homebrew to get the `greadlink` utility before trying to `init` or `clone`.

    brew install coreutils
