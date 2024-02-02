HOST := $(shell hostname)

ifeq ($(HOST),www-x28)
GROUP := production
else ifeq ($(HOST),alpha-x28)
GROUP := laptop
else ifeq ($(HOST),bravo-x28)
GROUP := laptop
else
GROUP := development
endif

ANSIBLE := ansible -i hosts/$(GROUP).yml
ANSIBLE_PLAYBOOK := ansible-playbook -i hosts/$(GROUP).yml -K -l $(GROUP)

all: install
	$(ANSIBLE) $(GROUP) -m ping

install:
	sudo apt-get install -y software-properties-common pipx
	([ ! -f "$$HOME/.local/bin/ansible" ] && pipx install --include-deps ansible) \
		|| pipx upgrade --include-injected ansible

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
