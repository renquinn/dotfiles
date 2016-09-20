all: run
build:
	docker build -t cs6530-lab .
run:
	docker run -it --rm \
		--name cs6530-lab-instance \
		-v $(PWD):/opt/app \
		-w /opt/app \
		cs6530-lab \
		bash
clean:
	docker rmi cs6530-lab
