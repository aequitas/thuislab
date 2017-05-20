.PHONY: plan

terraform_plan ?= cd terraform/;terraform plan -var-file=../../secrets.tfvars
terraform_apply ?= cd terraform/;terraform apply

url_ubuntu_xenial = https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk
url_ubuntu_xenial_ova = https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64.ova

plan: terraform/.plan
terraform/.plan: $(wildcard terraform/*.tf)| ../tmp/ubuntu_xenial.vmdk ../tmp/ubuntu_xenial.ova
	${terraform_plan} -out .plan

apply: terraform/.plan
	-${terraform_apply} .plan
	rm -f $<

../tmp/ubuntu_xenial.vmdk: | ../tmp
	wget --continue --output-document $@ ${url_ubuntu_xenial}

../tmp/ubuntu_xenial.ova: | ../tmp
	wget --continue --output-document $@ ${url_ubuntu_xenial_ova}

../tmp:
	mkdir -p $@
