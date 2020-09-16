  $ cat >> $HGRCPATH <<EOF
  > [extensions]
  > flow = $TESTDIR/../src/hgflow.py
  > mq =
  > [flow]
  > autoshelve = yes
  > EOF

  $ hg init a

  $ cd a

  $ hg flow init -d
  flow: Global configuration:
  flow:   autoshelve: on
  marked working directory as branch develop
  (branches are permanent and global, did you want a bookmark?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  
  $ hg flow feature start a 
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/a
  (branches are permanent and global, did you want a bookmark?) (?)

  $ touch b

  $ hg add b

  $ hg flow develop --traceback
  flow: warning: Your workspace has uncommitted changes.
  flow: Update workspace to <develop> trunk.
  popping flow/feature/a.pch
  patch queue now empty
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)
  flow: <develop> trunk: develop
  flow: Open <develop> branches:
  flow:   develop\* * (glob)

