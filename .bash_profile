# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/erdoganf/.dotnet/tools"
export JAVA_HOME="/usr/bin/java"
export DOTNET_ROOT="/usr/lib/dotnet"
export MSBuildSDKsPath=$DOTNET_ROOT/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks
export PATH="${PATH}:${DOTNET_ROOT}"
export PATH="$PATH:$HOME/.dotnet/tools"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
