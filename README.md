# dice

A hand-curated fortune file — Le Guin to Lacan, Bernkastel to Bayes,
KJV to Pokédex — rolled by the upstream `fortune(6)`. This repo is the
single source of truth for the data; the program is deliberately not
reimplemented here.

## Use

```sh
nix run .                      # roll once
nix profile install .          # install `dice`
./bin/dice                     # from a checkout (needs fortune-mod)
```

### Without Nix

```sh
./build.sh                     # -> dist/dice, data embedded
```

Copy `dist/dice` anywhere and run it. Needs `fortune` and `strfile`
(package `fortune-mod` on most distros, `fortune` via brew) — the data
is materialized to `$XDG_DATA_HOME/dice/` on first run.

## Curation

Entries are `%`-separated plain text (`share/fortune`). House rules:
verified attribution only; `attributed to X` when provenance is
unproven; `after X` for deliberate emendations; translators named;
placement is by thematic adjacency, never appended. Earlier curation
history lives in the dotfiles repo this project was extracted from.
