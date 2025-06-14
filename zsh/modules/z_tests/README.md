# Test Framework for Zsh Modules

This module provides testing infrastructure for all zsh modules using bats-core.

## Installation

```bash
./install.sh
```

This will install:
- bats-core (test framework)
- bats-support (helper library)
- bats-assert (assertion library)
- bats-file (file testing library)

## Writing Tests

Place test files next to the scripts you want to test with a `.test` extension:

```
zsh/modules/editor/
├── zshrc_workspace
└── zshrc_workspace.test    # Test file
```

### Test File Example

```bash
#!/usr/bin/env bats

# Load test helpers
load "../../z_tests/helpers.zsh"

setup() {
  load_bats_libs
  setup_test_dir
  source "${BATS_TEST_DIRNAME}/zshrc_workspace"
}

teardown() {
  teardown_test_dir
  unmock_all
}

@test "worktree_create creates new worktree" {
  setup_test_repo "my-repo"

  run worktree_create "new-feature"
  assert_success
  assert_output --partial "new-feature"
}

@test "translate_feature_name translates Japanese" {
  mock_claude

  run translate_feature_name "新機能"
  assert_success
  assert_output "test-feature"
}
```

## Running Tests

### Run a single test file
```bash
bats zsh/modules/editor/zshrc_workspace.test
```

### Run all tests
```bash
zsh/modules/z_tests/run_all_tests.sh
```

## Available Helpers

- `load_bats_libs()` - Load bats helper libraries
- `setup_test_dir()` - Create temporary test directory
- `teardown_test_dir()` - Clean up test directory
- `setup_test_repo(name)` - Create mock git repository
- `setup_test_worktree(feature)` - Create mock git worktree
- `mock_git()` - Mock git commands
- `mock_claude()` - Mock claude commands
- `unmock_all()` - Remove all mocks
