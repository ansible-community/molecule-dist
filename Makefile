all:
	docker build .
deps:
	tox -e deps
