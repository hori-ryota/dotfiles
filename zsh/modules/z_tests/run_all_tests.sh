#!/usr/bin/env bash

# Run all tests in zsh/modules

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$(dirname "$SCRIPT_DIR")"

echo "Running all tests in $MODULES_DIR..."
echo ""

# Find all .test files
test_files=()
while IFS= read -r -d '' file; do
  test_files+=("$file")
done < <(find "$MODULES_DIR" -name "*.test" -type f -print0)

if [[ ${#test_files[@]} -eq 0 ]]; then
  echo "No test files found."
  exit 0
fi

# Run each test file
total_tests=${#test_files[@]}
passed_tests=0
failed_tests=0

for test_file in "${test_files[@]}"; do
  echo "Running: $test_file"
  if bats "$test_file"; then
    ((passed_tests++))
  else
    ((failed_tests++))
  fi
  echo ""
done

# Summary
echo "================================"
echo "Test Summary:"
echo "  Total:  $total_tests"
echo "  Passed: $passed_tests"
echo "  Failed: $failed_tests"
echo "================================"

# Exit with appropriate code
if [[ $failed_tests -gt 0 ]]; then
  exit 1
else
  exit 0
fi
