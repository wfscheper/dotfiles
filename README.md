# dotfiles

Uses [stow](https://www.gnu.org/software/stow/) to manage sets of dotfiles.


## Install

While you can just clone the repository directly to `~/.dotfiles`,
this makes it tricky to manage any local edits.
The following instructions enable tracking of local changes.

1. Clone the repository
   ```bash
   git clone git@github.com:wfscheper/dotfiles.git ~/git/dotfiles
   cd ~/git/dotfiles/
   ```
2. Create a local branch for local modifications
    ```bash
    git checkout -b local
    ```
3. Sync files to `~/.dotfiles`.
   ```bash
   ./bin/sync push ~/.dotfiles
   ```

If you make changes to the dotfiles directly,
you can sync those chnages back to the git repository:
```bash
cd ~/git/dotfiles
./bin/sync pull ~/.dotfiles
```
