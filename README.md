# dice

hand-curated fortune file

## Use

```sh
nix run .                      # roll once
nix profile install .          # install `dice`
./bin/dice                     # from a checkout (needs fortune-mod)
```

### Without Nix

```sh
./build.sh                     # builds dist/dice, data embedded
```

Copy `dist/dice` anywhere and run it. Stateless and self-contained:
needs only bash and a POSIX awk (gawk, mawk, BSD awk, busybox).

## Curation

Entries are `%`-separated plain text (`share/fortune`). House rules:
verified attribution only; `attributed to X` when provenance is
unproven; `after X` for deliberate emendations; translators named;
placement is by thematic adjacency, never appended. Earlier curation
history lives in the dotfiles repo this project was extracted from.
