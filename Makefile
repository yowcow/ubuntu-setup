HOST := $(shell hostname)

ifeq ($(HOST),www-x28)
GROUP := production
else ifeq ($(HOST),dev-x28)
GROUP := development
else ifeq ($(HOST),alpha-x28)
GROUP := laptop
endif

ANSIBLE := ansible -i hosts/$(GROUP).yml -e 'ansible_python_interpreter=/usr/bin/python3'
ANSIBLE_PLAYBOOK := ansible-playbook -i hosts/$(GROUP).yml -K -e 'ansible_python_interpreter=/usr/bin/python3' -l $(GROUP)

all:
	$(ANSIBLE) $(GROUP) -m ping
	sudo $(MAKE) play-role GROUP=$(GROUP) ROLE=apt

ifneq ($(DRYRUN),)
play: CHECK := --check
endif
play: BOOK := site.yml
play:
	$(ANSIBLE_PLAYBOOK) $(BOOK) $(CHECK)

role/%:
	$(ANSIBLE) $(GROUP) -m include_role -a name=$*

.PHONY: all play role/%
