This repository provides binaries of Geant4 for use in GitHub actions, on `ubuntu-latest`.
To see the list of available versions, please consult the [releases](https://github.com/hahnjo/geant4-actions-binaries/releases).

### Using the binaries in your workflow

Each release is named after the version of Geant4, for example `geant4.10.07.p03`.
The binaries are made available as an asset with the name suffixed by `-binaries.tar.gz`.
They are built with `GEANT4_USE_GDML=ON`, so you need to install `libxerces-c-dev`.
To use the installation in a workflow, download and extract the archive to `$HOME` and source `geant4.sh`:

```yaml
- name: Install dependencies
  run: sudo apt-get install libxerces-c-dev
- name: Install Geant4
  run: |
    wget https://github.com/hahnjo/geant4-actions-binaries/releases/download/$GEANT4_VERSION/$GEANT4_VERSION-binaries.tar.gz
    tar xf $GEANT4_VERSION-binaries.tar.gz -C $HOME
  env:
    GEANT4_VERSION: "geant4.10.07.p03"
- name: Build application
  run: |
    source ~/Geant4/bin/geant4.sh
```

Alternatively, you can use a [build matrix](https://docs.github.com/en/actions/learn-github-actions/managing-complex-workflows#using-a-build-matrix) to test against multiple versions of Geant4:

```yaml
strategy:
  matrix:
    version: [
      geant4.10.07.p03,
      geant4.10.06.p03,
    ]
```

and then install with:

```yaml
- name: Install Geant4
  run: |
    wget https://github.com/hahnjo/geant4-actions-binaries/releases/download/${{ matrix.version }}/${{ matrix.version }}-binaries.tar.gz
    tar xf ${{ matrix.version }}-binaries.tar.gz -C $HOME
```
