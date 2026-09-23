# AUTONORM

AUTONORM is a software package for determining the ratio between TALYS results and the corresponding values from an ENDF-6 format nuclear data library, so that TALYS can be exactly normalized to the desired result in a second run.

## Documentation and reference

The user manual for AUTONORM is included as `doc/tools.pdf`.

After the GitHub repository has been published, it can also be linked directly from the repository.

The reference to be used for AUTONORM is:

A.J. Koning, D. Rochman, J.-Ch. Sublet, N. Dzysiuk, M. Fleming, and S. van der Marck, *TENDL: Complete Nuclear Data Library for innovative Nuclear Science and Technology*, Nuclear Data Sheets 155, 1 (2019).

## Installation

### Prerequisites

The following are the prerequisites for compiling and using AUTONORM:

- GNU make
- a recent Fortran compiler, such as GNU Fortran (`gfortran`)
- the nuclear-data `libraries/` directory used for the normalization
- TALYS output files for the calculation to be normalized

`git` is additionally required when AUTONORM is obtained from GitHub.

### Directory layout

By default, AUTONORM expects the nuclear-data libraries to be a sibling directory of the AUTONORM installation:

```text
parent_directory/
├── autonorm/
└── libraries/
```

The TALYS result files that AUTONORM normalizes are read from the current working directory.

### Downloads

#### 1. Download the tar file

```bash
curl -LO https://nds.iaea.org/talys/autonorm.tar
tar zxf autonorm.tar
```

#### 2. Using git

Once the GitHub repository has been published:

```bash
git clone https://github.com/arjankoning1/autonorm.git
```

### Installation instructions

#### Using the installation script

```bash
cd autonorm
./install_autonorm.bash
```

The script automatically runs the Makefile in `autonorm/source`.

#### Using make directly

```bash
cd autonorm/source
make
```

The executable is installed as:

```text
autonorm/bin/autonorm
```

For the modern version, the default compiler is `gfortran`. When `gfortran` is used and no `FFLAGS` are supplied, the Makefile uses:

```text
-w -O3 -ffp-contract=off
```

For other compilers, no default compiler flags are imposed.

Compiler and compilation options can be passed through `install_autonorm.bash`, for example:

```bash
./install_autonorm.bash FC=gfortran FFLAGS="-O3 -ffp-contract=off"
./install_autonorm.bash FC=ifx FFLAGS="-O3"
```

### Runtime environment

Set `AUTONORM_DIR` to the AUTONORM installation directory. For example:

```bash
export AUTONORM_DIR="/Users/koning/autonorm"
```

If you want to run `autonorm` from anywhere, add its `bin` directory to `PATH`:

```bash
export PATH="$AUTONORM_DIR/bin:$PATH"
```

These lines can be added to `~/.zshrc` or `~/.profile`.

AUTONORM uses `AUTONORM_DIR` only to determine the default sibling `libraries/` directory. If setting `AUTONORM_DIR` is not possible, edit `code_dir` in `source/machine.f90` and rebuild AUTONORM.

No user-name environment variable is needed by AUTONORM.

For the modern version, `code_build.bash` and `path_change.bash` are no longer required and can be removed after adopting the new installer, Makefile and `machine.f90`.

## Running AUTONORM

AUTONORM reads its input from standard input and reads the corresponding TALYS output files from the current working directory. For example:

```bash
autonorm < autonorm.inp > autonorm.out
```

The evaluated-library data are read from the sibling `libraries/` directory.

AUTONORM writes normalization information such as `rescue.add` in the current working directory. When the `hfnorm` option is enabled, it also writes `hfnorm.add`.

## Build check

The supplied tarball does not contain sample cases, so `make check` performs a build/executable check only:

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
- `doc/` the user documentation

## License and Copyright

This software is distributed and copyrighted according to the [LICENSE](LICENSE) file.
