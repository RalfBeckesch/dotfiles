
#!/bin/sh

name="$1"
prefix="chezmoi"
postfix="sh"

if [ -z "$name" ]; then
	echo -e "\n$(basename $0) realm\n"
	exit 0
fi


fn="$HOME/bin/$prefix-$name.$postfix"
config="$HOME/.config/chezmoi-$name/chezmoi.toml"
dir="$HOME/.local/share/chezmoi-$name"

if [ -e "$fn" ]; then
	printf '\n'"'$fn' already exists!\n"'\n'
	exit 1
fi

if [ -e "$config" ]; then
	printf '\n'"'$config' already exists!\n"'\n'
	exit 1
fi

if [ -e "$dir" ]; then
	printf '\n'"'$dir' already exists!\n"'\n'
	exit 1
fi

cat <<EOF > $fn
#!/bin/sh
exec chezmoi \
  --config "$HOME/.config/chezmoi-$name/chezmoi.toml" \
  --source "$HOME/.local/share/chezmoi-$name" \
  "\$@"
EOF

chmod 755 $fn
