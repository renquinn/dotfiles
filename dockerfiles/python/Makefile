all: run

image = python-image
image-instance = python-image-instance
script = example.py

build:
	docker build -t $(image) .
run:
	docker run -it --rm \
		--name $(image-instance) \
		-v $(PWD):/usr/src/app \
		$(image) \
		python $(script)
