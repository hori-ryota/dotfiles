#!/usr/bin/env zsh
# Common test helpers for zsh modules

# Load bats helper libraries
load_bats_libs() {
  local bats_libs_dir="${XDG_DATA_HOME:-$HOME/.local/share}/bats/libs"

  if [[ -d "$bats_libs_dir/bats-support" ]]; then
    load "$bats_libs_dir/bats-support/load"
  fi

  if [[ -d "$bats_libs_dir/bats-assert" ]]; then
    load "$bats_libs_dir/bats-assert/load"
  fi

  if [[ -d "$bats_libs_dir/bats-file" ]]; then
    load "$bats_libs_dir/bats-file/load"
  fi
}

# Create a temporary test directory
setup_test_dir() {
  export TEST_TEMP_DIR=$(mktemp -d)
  cd "$TEST_TEMP_DIR"
}

# Clean up test directory
teardown_test_dir() {
  if [[ -n "$TEST_TEMP_DIR" ]] && [[ -d "$TEST_TEMP_DIR" ]]; then
    cd /
    rm -rf "$TEST_TEMP_DIR"
  fi
}

# Create a mock git repository
setup_test_repo() {
  local repo_name="${1:-test-repo}"

  mkdir -p "$TEST_TEMP_DIR/$repo_name"
  cd "$TEST_TEMP_DIR/$repo_name"

  git init
  git config user.email "test@example.com"
  git config user.name "Test User"

  echo "# Test Repo" >README.md
  git add README.md
  git commit -m "Initial commit"

  export TEST_REPO_PATH="$TEST_TEMP_DIR/$repo_name"
}

# Create a mock git worktree
setup_test_worktree() {
  local feature_name="${1:-test-feature}"
  local repo_name=$(basename "$TEST_REPO_PATH")
  local worktree_path="$TEST_REPO_PATH/../$repo_name-$feature_name"

  cd "$TEST_REPO_PATH"
  git worktree add -b "feature/$feature_name" "$worktree_path"

  export TEST_WORKTREE_PATH="$worktree_path"
}

# Mock git command for testing
mock_git() {
  function git() {
    case "$1" in
    "rev-parse")
      case "$2" in
      "--show-toplevel")
        echo "$TEST_REPO_PATH"
        ;;
      "--git-dir")
        echo "$TEST_REPO_PATH/.git"
        ;;
      "--git-common-dir")
        echo "$TEST_REPO_PATH/.git"
        ;;
      *)
        command git "$@"
        ;;
      esac
      ;;
    *)
      command git "$@"
      ;;
    esac
  }
}

# Mock claude command for testing
mock_claude() {
  function claude() {
    case "$@" in
    *"日本語"*)
      echo "test-feature"
      ;;
    *)
      echo "mock-output"
      ;;
    esac
  }
}

# Unmock commands
unmock_all() {
  unfunction git 2>/dev/null || true
  unfunction claude 2>/dev/null || true
}
