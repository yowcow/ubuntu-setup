ubuntu-setup
============

Provision all of my Ubuntu nodes.


Nodes (Groups)
--------------

* alpha-x28
* dev-x28
* www-x28


HOW TO INSTALL ANSIBLE
----------------------

See https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu


HOW TO RUN
----------

Set up apt repositories:

    make all

Play all roles for the group:

    make play

Play one role only:

    sudo make play-role GROUP=production ROLE=nginx


HOW TO DEBUG
------------

Do:

    - debug: var=whattodebug


SEE ALSO
--------

* Module Docs: https://docs.ansible.com/ansible/latest/modules/modules_by_category.html
* Good Examples: https://github.com/ansible/ansible-examples
