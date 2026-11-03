# dbt-eMacs

A lightweight minor mode to run, compile, and test dbt models in Emacs using `uv tool`.

## Installation

### 1. Install `dbt` globally

```bash
uv tool install dbt-core --with dbt-databricks
# or other
uv tool install dbt-core --with dbt-snowflake
uv tool install dbt-core --with dbt-postgres
```

### 2. Doom Emacs Setup

Add to `~/.config/doom/packages.el`:

```elisp
(package! dbt-emacs
  :recipe (:host github :repo "Rawlsy-py/dbt-emacs"))
```

Add to `~/.config/doom/config.el`:

```elisp
(use-package! dbt-emacs
  :hook (sql-mode . dbt-emacs))

(after! sql
  (map! :map sql-mode-map
        :leader
        :prefix ("d" . "dbt")
        "m" #'dbt-run-model-at-point
        "r" #'dbt-run-all
        "t" #'dbt-test
        "c" #'dbt-compile
        "v" #'dbt-view-compiled-sql))
```

Run `doom sync` in your terminal.

## Keybindings

| Key | Command | Description |
| --- | --- | --- |
| `SPC d m` | `dbt-run-model-at-point` | Run current model (`dbt run --select <model>`) |
| `SPC d r` | `dbt-run-all` | Run all models (`dbt run`) |
| `SPC d t` | `dbt-test` | Run tests (`dbt test`) |
| `SPC d c` | `dbt-compile` | Compile project (`dbt compile`) |
| `SPC d v` | `dbt-view-compiled-sql` | Open compiled SQL file in split window |

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

GPL-3.0
