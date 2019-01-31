User lists definitions
----------------------
Definitions are in JSON file format. It's expected to contain name of user list
and for that there should be following fields:

* __title__: This is suppose to be a title for given user list.
* __description__: This is long text describing content of given user list.
* __visible__: This should be set to `yes` or `no` to say if given user list
  should be visible or not. If set to `no` then __title__ and __description__ are
  not required.

### Verification
Part of this is also verification script. It just reads `definitions.json` and
checks if it has correct format. Just run `verify.py` in same directory as
`definitions.json` is.

### Translations
To generate translations you can use `gen_pot.py` script. It expect you to run it
in directory with `definitions.json` and first arguments has to be path to output
file (if exists then it's merged).
