
name="$1"
prefix="chezmoi"
postfix="sh"

fn="$HOME/bin/$prefix-$name.$postfix"
config="$HOME/.config/chezmoi-$name/chezmoi.toml"
dir="$HOME/.local/share/chezmoi-$name"

if [ -e "$fn" ]; then
	echo -e "\n'$fn' already exists!\n"
	exit 1
fi

if [ -e "$config" ]; then
	echo -e "\n'$config' already exists!\n"
	exit 1
fi

if [ -e "$dir" ]; then
	echo -e "\n'$dir' already exists!\n"
	exit 1
fi

cat <<EOF >> $fn
#!/bin/sh
exec chezmoi \
  --config "$HOME/.config/chezmoi-private/chezmoi.toml" \
  --source "$HOME/.local/share/chezmoi-private" \
  "$@"
EOF

chmod 755 $fn
