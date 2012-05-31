Rubidium WHOIS
==============

This is a web application for a whois lookup.


Frameworks/Libs
---------------
  1. [Twitter Bootstrap](http://twitter.github.com/bootstrap/)
  2. [Ruby Whois](http://www.ruby-whois.org/)
  
Changelog
---------

###v.1.1.0

Changed contact's representation to accordion instead of tabular. Moved _status_ info before _contacts_. Set non-fluid grid view.

whois gem updated to version with pretty good ua domains parser.

###v1.0.2

Added [exception_notification](https://github.com/smartinez87/exception_notification), that should send mail when an exception occurs.

###v1.0.1

Improves stability, checks for `nil` values of whois record properties. The whois gem source now moved to a git repo.

###v1.0.0

**Initial version.**
App has a view with a search form and a view for result output. Also a list of previous searched domains are available