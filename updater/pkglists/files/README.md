Package lists definitions
-------------------------
Definitions are in JSON file format. It's expected to contain name of package list
and for that there should be following fields:

* __title__: This is suppose to be a title for given user list. Type is string.
* __description__: This is long text describing content of given user list. Type
  is string.
* __url__:  This is URL to documentation. It is not required. Type is string.
* __visible__: This should be set to `yes` or `no` to say if given user list
  should be visible or not. If not specified then `true` is used. Type is boolean.
* __official__: This differentiates between officially supported and community
  supported lists. If not specified then `false` is used. Type is boolean.

All fields has to be defined as appropriate values of specified type unless stated
otherwise.

### Translations
To generate translations you can use `gen_pot.py` script. It expect you to run it
in directory with `definitions.json` and first arguments has to be path to output
file (if exists then it's merged).
