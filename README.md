# AUTONORM

AUTONORM is a software package for determining normalization factors between TALYS results and corresponding values from an ENDF-6 formatted nuclear data library. These factors can then be used in a second TALYS calculation so that selected TALYS results reproduce the desired evaluated-library values.

## Documentation and reference

Documentation for the TALYS tools, including automatic normalization, is available in the [TALYS tools tutorial (pdf)](https://nds.iaea.org/talys/tutorials/tools.pdf).

The reference to be used for AUTONORM is:

A.J. Koning, D. Rochman, J.-Ch. Sublet, N. Dzysiuk, M. Fleming, and S. van der Marck, *TENDL: Complete Nuclear Data Library for innovative Nuclear Science and Technology*, Nuclear Data Sheets 155, 1 (2019).

## Installation

### Prerequisites

The following are the prerequisites for compiling and using AUTONORM:

- GNU make
- a recent Fortran compiler, such as GNU Fortran (gfortran)
- the nuclear-data `libraries/` directory used for the normalization
- TALYS output files for the calculation to be normalized
- git, only when AUTONORM is downloaded using `git clone`

AUTONORM expects the nuclear-data libraries to be installed as a sibling directory of the AUTONORM installation. A typical layout is therefore:

```text
parent_directory/
├── autonorm/
└── libraries/
```

The TALYS result files that AUTONORM normalizes are read from the current working directory.

### Downloads

AUTONORM can be downloaded in one of the following ways.

#### 1. Latest version without git

Users who do not have git can download a snapshot of the current `main` branch directly from GitHub:

```bash
curl -L \
  -o autonorm-main.tar.gz \
  https://github.com/arjankoning1/autonorm/archive/refs/heads/main.tar.gz

tar zxf autonorm-main.tar.gz
mv autonorm-main autonorm
```

This produces the same `autonorm/` directory structure as the git version, but without the git history.

The downloaded snapshot contains the latest version of the `main` branch at the time of download. To obtain a newer version later, download the snapshot again.

#### 2. Latest version using git

Users with git can clone the repository with

```bash
git clone https://github.com/arjankoning1/autonorm.git
```

The advantage of this method is that the local AUTONORM installation can subsequently be updated with

```bash
cd autonorm
git pull --ff-only
```

### Installation instructions

From the `autonorm/` directory, run

```bash
./install_autonorm.bash
```

which automatically cleans the previous build and executes the `Makefile` in `autonorm/source`.

An alternative is:

```bash
cd autonorm/source
make
```

The executable is installed as

```text
autonorm/bin/autonorm
```

The default compiler is `gfortran`. When `gfortran` is used and no `FFLAGS` are supplied, the Makefile uses:

```text
-w -O3 -ffp-contract=off
```

For other compilers, no default compiler flags are imposed.

The compiler and compilation options can be passed to the Makefile through `install_autonorm.bash`. For example:

```bash
# GNU Fortran
./install_autonorm.bash FC=gfortran FFLAGS="-O3 -ffp-contract=off"

# Intel Fortran
./install_autonorm.bash FC=ifx FFLAGS="-O3"
```

### Runtime environment

Set `AUTONORM_DIR` to the AUTONORM installation directory. This variable is required unless the fallback path in `source/machine.f90` has been set manually. For example:

```bash
export AUTONORM_DIR="/Users/koning/autonorm"
```

If you want to run `autonorm` from anywhere, add the AUTONORM `bin` directory to `PATH`:

```bash
export PATH="$AUTONORM_DIR/bin:$PATH"
```

These lines can be added to your shell configuration file, for example `~/.zshrc` or `~/.profile`.

AUTONORM derives the location of the nuclear-data `libraries/` directory from the parent directory of `AUTONORM_DIR`.

If setting `AUTONORM_DIR` is not possible on a particular system, edit `code_dir` in `source/machine.f90` and rebuild AUTONORM.

No user-name environment variable is required by AUTONORM.

## Running AUTONORM

AUTONORM reads its input from standard input and the corresponding TALYS output files from the current working directory. For example:

```bash
autonorm < autonorm.inp > autonorm.out
```

The evaluated-library data are read from the sibling `libraries/` directory.

AUTONORM writes normalization information such as `rescue.add` in the current working directory. When the `hfnorm` option is enabled, it also writes `hfnorm.add`.

## Build check

The current AUTONORM repository does not contain sample cases, so `make check` performs a build/executable check only:

```bash
make -C source check
```

It verifies that `bin/autonorm` has been created successfully but does not run a normalization calculation.

## The AUTONORM package

The `autonorm/` directory contains:

- `README.md` this README file
- `LICENSE` the license file
- `install_autonorm.bash` installation script
- `source/` the Fortran source code and Makefile
- `bin/` the executable after successful installation

## License and Copyright

This software is distributed and copyrighted according to the [LICENSE](LICENSE) file.
