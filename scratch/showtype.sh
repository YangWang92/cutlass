#!/usr/bin/env bash
# Syntax-only compile of scratch/showtype.cu to print an expanded template type.
# The cute::print_type<T>() call triggers a static_assert; the compiler prints
# the full type of T. We stop before codegen (-fsyntax-only via host), so it is fast.
set -u

NVCC=/usr/local/cuda/bin/nvcc
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${1:-$ROOT/scratch/showtype.cu}"

# -arch: match your GPU. --expt-* mirror how CUTLASS is normally built.
# We pass -fsyntax-only to the host compiler so no object file is produced.
"$NVCC" -std=c++17 -arch=sm_90a \
  --expt-relaxed-constexpr --expt-extended-lambda \
  -I "$ROOT/include" \
  -I "$ROOT/tools/util/include" \
  -Xcompiler -fsyntax-only \
  -Xcompiler -fno-elide-type \
  -Xcompiler -ftemplate-backtrace-limit=0 \
  "$SRC" 2>&1 | sed -n '/Printing type T/,+40p'

# Tip: remove the `| sed ...` filter above to see the whole diagnostic.
