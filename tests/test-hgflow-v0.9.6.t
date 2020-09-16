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
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  
  $ hg flow feature start b
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/b
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature finish --stamp "Issue-20" --dry-run --verbose
  flow: This is a dry run.
  flow: note: Hg command history:
  flow: note:   hg commit --message "flow: Closed <feature> 'b'. Issue-20" --close-branch
  flow: note:   hg update develop 
  flow: note:   hg merge feature/b 
  flow: note:   hg commit --message "flow: Merged <feature> 'b' to <develop> ('develop'). Issue-20"
