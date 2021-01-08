debian-setup
============

Provision all of my Debian nodes.


Nodes (Groups)
--------------

* alpha-x28
* dev-x28
* www-x28


How To Run
----------

Set up apt repositories:

    make all

Play all roles for the group:

    make play

Play one role only:

    sudo make play-role GROUP=production ROLE=nginx


See Also
--------

* Module Docs: https://docs.ansible.com/ansible/latest/modules/modules_by_category.html
* Good Examples: https://github.com/ansible/ansible-examples
