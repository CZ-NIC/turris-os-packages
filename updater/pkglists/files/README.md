Package lists definitions
-------------------------
Definitions are in JSON file format. It's expected to contain name of package list
and for that there should be following fields:

* __title__: This is supposed to be a title for given package list. __Type is
  string__.
* __description__: This is long text describing content of given package list.
  __Type is string__.
* __url__:  This is URL to documentation. __Type is string__.  __This field is
  option__.
* __official__: This differentiates between officially supported and community
  supported lists. If not specified then `false` is used. __Type is boolean__.
* __options__: Additional options for pkglist. __This has to be a dictionary__.
  For content of this dictionary see next section about that. __This field is
  optional__.

All fields have to be defined as appropriate values of specified type unless stated
otherwise.

Name of package list has to be string with only word characters used
(`[a-zA-Z0-9_]`).

#### __options__ dictionary
Every package list can have additional boolean options. Those are intended to be
additional extensions or parts providing feature set of given package list. You
can use it in general by two ways:
* package list is meta list grouping multiple independent features
* package list has some additional optional features to install

Every option has name that is used in updater's pkglist and some additional
fields. Required fields are __title__ and __description__. Their meaning is same
as for root package list. On top of those there is option __default__. That is
of boolean type and servers to set default state of option when not configured by
user. In default __default__ is `false`.

### Translations
To generate translations you can use `manage.py` script with `pot` argument.
