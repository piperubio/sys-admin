# Update registry

sudo apt update
sudo apt upgrade -y

# Install packagess from apt

sudo apt install zsh cargo bat -y

# Check if exists .bashrc, if not exists then create
BASHRC=~/.bashrc
if [ ! -f "$BASHRC" ]; then
  touch $BASHRC
fi

# add alias cat for batcat
BATCAT_ALIAS="alias cat=batcat"

if ! grep -Fxq "$BATCAT_ALIAS" "$BASHRC"; then
  echo "# BATCAT Alias" >> $BASHRC
  echo $BATCAT_ALIAS >> $BASHRC
fi

# add alias del
DEL_ALIAS="alias del=rm"

if ! grep -Fxq "$DEL_ALIAS" "$BASHRC"; then
  echo "# DEL Alias" >> $BASHRC
  echo $DEL_ALIAS >> $BASHRC
fi

# Install mdcat

cargo install mdcat
