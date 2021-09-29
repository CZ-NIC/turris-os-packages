# Turris Backup scripts

The `turris-backup` in an configuration backup tool. It integrates OpenWrt's
backup as well as Turris specific files.

The important feature and protection is that it checks major version of
distribution in backup and compares it with current system. The default
behavior, unless forced, is to not allow restore of backup if major version is
not the same. The reason for this is because with major version of Turris OS the
OpenWrt version is updated and there are commonly incompatible changes in the
configuration. These changes regularly result in invalid the configuration for
various software. In worst case scenario they can make the router inaccessible
due to invalid network configuration.

The backup script backups only files and links. It never dereferences the links
and instead just includes links as they are. The backup is tar archive
compressed with bzip2.

## UCI configuration

The backup script reads `/etc/config/backups` file and expects the following
options in the `generate` section:

* `include_sysupgrade`: boolean option if sysupgrade files should be included in
  backup. This is OpenWrt's native list of files that should be backed up.
  Various packages ship with additions to this list. The directories and files
  to be backed up are collected from file `/etc/sysupgrade.conf` and files in
  directory `/lib/upgrade/keep.d/`. Sysupgrade files are automatically included
  in default unless explicitly disabled.
* `include_modified_configs`: boolean option signaling that any modified
  configuration file should be included. The packages can set some of their
  files as configuration files and that way they are protected from updates if
  they were modified. This includes any such modified configuration file in
  backup. The modified files are NOT included automatically unless enabled
  explicitly.
* `include_default`: boolean option if default Turris files should be included.
  This includes UCI files in `/etc/config/` and non-standard updater
  configuration files from directory `/etc/updater/conf.d/`. The default is to
  include these files unless explicitly disabled.
* `dirs`: list with additional paths to files or directories that should be
  included in backup. Feel free to add any additional directories you want to
  include in the backup this way.
