  $ cat >> $HGRCPATH <<EOF
  > [extensions]
  > flow = $TESTDIR/../src/hgflow.py
  > mq =
  > [flow]
  > autoshelve = yes
  > EOF

  $ cd

  $ hg init a

  $ cd a

  $ hg flow init -d
  flow: Global configuration:
  flow:   autoshelve: on
  marked working directory as branch develop
  (branches are permanent and global, did you want a bookmark?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  
  $ hg flow develop
  flow: Update workspace to <develop> trunk.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)
  flow: <develop> trunk: develop
  flow: Open <develop> branches:
  flow:   develop\*  1:* (glob)

  $ hg flow develop promote -t "v0.9.5" --dry-run
  flow: This is a dry run.
  flow: note: Hg command history:
  flow: note:   hg update default 
  flow: note:   hg merge develop 
  flow: note:   hg commit --message "flow: Promoted <develop> 'trunk' (*) to 'default'." (glob)
  flow: note:   hg tag v0.9.5 
  flow: note:   hg update develop 
