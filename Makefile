# Makefile for dotfiles project

# Find all shell scripts (sh, bash, zsh)
SHELL_SCRIPTS := $(shell find . -type f \( -name "*.sh" -o -name "*.bash" -o -name "*.zsh" \) -not -path "./.git/*" -not -path "./zprezto/*" | sort)
# Find all zshrc files (files starting with "zshrc")
ZSHRC_FILES := $(shell find . -type f -name "zshrc*" -not -path "./.git/*" -not -path "./zprezto/*" | sort)
# Combine all shell files
ALL_SHELL_FILES := $(SHELL_SCRIPTS) $(ZSHRC_FILES)

.PHONY: format
format: ## Format all shell scripts with shfmt
	@echo "Formatting shell scripts..."
	@for file in $(ALL_SHELL_FILES); do \
		echo "  Formatting $$file"; \
		shfmt -w "$$file"; \
	done
	@echo "Shell script formatting complete!"

.PHONY: test
test: ## Run all tests
	@echo "Running all tests..."
	@zsh/modules/z_tests/run_all_tests.sh