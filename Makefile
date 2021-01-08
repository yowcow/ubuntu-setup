HOST := $(shell hostname)

ifeq ($(HOST),www-x28)
  GROUP := production
else ifeq ($(HOST),dev-x28)
  GROUP := development
else ifeq ($(HOST),alpha-x28)
  GROUP := laptop
endif

ANSIBLE := ansible -i hosts.$(GROUP) -e 'ansible_python_interpreter=/usr/bin/python3'
ANSIBLE_PLAYBOOK := ansible-playbook -i hosts.$(GROUP) -K -e 'ansible_python_interpreter=/usr/bin/python3' -l $(GROUP)

all:
	sudo dpkg --add-architecture i386
	$(ANSIBLE) $(GROUP) -m ping
	sudo $(MAKE) play-role GROUP=$(GROUP) ROLE=apt

ifneq ($(DRYRUN),)
play: CHECK := --check
endif
play: BOOK := site.yml
play:
	$(ANSIBLE_PLAYBOOK) $(BOOK) $(CHECK)

play-role:
	$(ANSIBLE) $(GROUP) -m include_role -a name=$(ROLE)

.PHONY: all play
