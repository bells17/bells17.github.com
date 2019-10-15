all: build

build:
	hugo --minify

serve:
	hugo server --buildFuture
