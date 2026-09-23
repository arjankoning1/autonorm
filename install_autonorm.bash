#!/usr/bin/env bash

set -euo pipefail

# Determine the AUTONORM installation directory independently of where
# the script is called from.

autonorm_dir=$(cd "$(dirname "$0")" && pwd)
source_dir="$autonorm_dir/source"

# Verify that the expected source directory and build files exist.

if [[ ! -d "$source_dir" ]]; then
  echo "AUTONORM installation error: source directory not found:" >&2
  echo "  $source_dir" >&2
  exit 1
fi

if [[ ! -f "$source_dir/Makefile" ]]; then
  echo "AUTONORM installation error: Makefile not found:" >&2
  echo "  $source_dir/Makefile" >&2
  exit 1
fi

source_file="$source_dir/autonorm.f90"

if [[ ! -f "$source_file" ]]; then
  echo "AUTONORM installation error: source files missing or incomplete:" >&2
  echo "  $source_file" >&2
  exit 1
fi

echo
echo "Installing AUTONORM"
echo "Installation directory: $autonorm_dir"
echo

# Pass all command-line arguments directly to make. This permits, e.g.:
#
# ./install_autonorm.bash FC=ifx FFLAGS="-O3"
# ./install_autonorm.bash FC=gfortran FFLAGS="-w -O3 -ffp-contract=off"

make -C "$source_dir" clean
make -C "$source_dir" all "$@"

autonorm_exe="$autonorm_dir/bin/autonorm"

if [[ ! -x "$autonorm_exe" ]]; then
  echo "AUTONORM installation error: executable not created:" >&2
  echo "  $autonorm_exe" >&2
  exit 1
fi

echo
echo "AUTONORM executable:"
echo "  $autonorm_exe"
echo
echo "If not already done, add the following lines to your shell configuration:"
echo
echo "  export AUTONORM_DIR=\"$autonorm_dir\""
echo "  export PATH=\"\$AUTONORM_DIR/bin:\$PATH\""
echo
echo "By default, AUTONORM expects the nuclear-data libraries at:"
echo "  $(dirname "$autonorm_dir")/libraries"
echo
echo "Alternatively, edit code_dir in source/machine.f90 and rebuild AUTONORM."
echo
