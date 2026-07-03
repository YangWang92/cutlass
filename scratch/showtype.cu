// Scratch file for expanding CUTLASS/CuTe template types.
//
// How it works: cute::print_type<T>() fires a static_assert on purpose, so the
// compiler prints the fully-expanded type of T in its error message. Nothing is
// codegen'd, so a syntax-only check is fast.
//
// Usage:
//   1) Include the headers that define the type you care about.
//   2) Form the type (via `using T = ...;`) or grab a variable.
//   3) Call cute::print_type<T>();  (or cute::print_type(var);)
//   4) Run:  bash scratch/showtype.sh
//
// Example below expands a CuTe layout type. Replace with your own.

#include <cute/tensor.hpp>
#include <cute/util/debug.hpp>

using namespace cute;

int main() {
  // ---- Put the type you want to expand here ----
  using MyShape  = Shape<_128, _256, _64>;
  using MyStride = Stride<_1, _128, _32768>;
  using MyLayout = Layout<MyShape, MyStride>;

  cute::print_type<MyLayout>();
  // cute::print_type(some_variable);   // alternatively, expand a variable's type

  return 0;
}
