HOST := $(shell hostname)

ifeq ($(HOST),www-x28)
GROUP := production
else ifeq ($(HOST),dev-x28)
GROUP := development
else ifeq ($(HOST),alpha-x28)
GROUP := laptop
else ifeq ($(HOST),bravo-x28)
GROUP := laptop
endif

ANSIBLE := ansible -i hosts/$(GROUP).yml
ANSIBLE_PLAYBOOK := ansible-playbook -i hosts/$(GROUP).yml -K -l $(GROUP)

all: install
	$(ANSIBLE) $(GROUP) -m ping

install:
	sudo apt-get install -y software-properties-common python3 python3-pip
	python3 -m pip install --upgrade --user pip ansible

ifneq ($(DRYRUN),)
play: CHECK := --check
endif
play: BOOK := site.yml
play:
	$(ANSIBLE_PLAYBOOK) $(BOOK) $(CHECK)

roles/%: FORCE
	$(ANSIBLE) $(GROUP) -m include_role -a name=$*

FORCE:

.PHONY: all install play role/%
