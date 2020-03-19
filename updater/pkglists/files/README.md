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
* __options__: Additional options for pkglist. __This has to be a dictionary__.
  For content of this dictionary see next section about that. __This field is
  optional__.
* __labels__: Labes to associate with given package list. __This has to be a
  list__. For content of this list see next section about that. __This field is
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
fields. Required fields are __title__ and __description__ and optional are __url__
and __labels__. Their meaning is same as for root package list. On top of those
there is option __default__. That is of boolean type and serves to set default
state of option when not configured by user. In default __default__ is `false`.

#### __labels__ list and definition
Labels are defined in separate file `labels.json`. It is in JSON format the same
way as top level `definitions.json`. It is expected to contain name of label and
for that there should be following fields:

* __title__: Displayable name of label. Compared to name of label the difference
  is that this is translated and should be displayed to user while label name is
  technical name of label. __Type is string__.
* __description__: This is text describing what given label means in context of
  package lists. __Type is string__.
* __severity__: How important this label is. In general it specified color to be
  used. In default __primary__ is assumed. Following are defined:
  * __danger__
  * __warning__
  * __info__
  * __success__
  * __primary__
  * __secondary__
  * __light__
  * __dark__

### Translations
To generate translations you can use `manage.py` script with `pot` argument.
