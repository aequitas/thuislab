.PHONY: all

all: colonize terraform

colonize: vendor/bin/colonize

vendor/bin/colonize:
	go get github.com/craigmonson/colonize

terraform: $(shell brew --prefix)/terraform

$(shell brew --prefix)/terraform:
	brew install terraform
