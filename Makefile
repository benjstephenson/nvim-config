fmt:
	echo "===> Formatting"
	stylua . --config-path=.stylua.toml

lint:
	echo "===> Linting"
	luacheck lua/ --globals vim
