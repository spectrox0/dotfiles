
brew install rustup-init

# Update all cargo packages and rust
echo "Updating all cargo packages and rust"
cargo install-update -a

# Install Eza
echo "Installing Eza"
cargo install eza

# Install zoxide
echo "Installing zoxide"
cargo install zoxide


# Install bottom to monitor system resources
cargo install bottom
