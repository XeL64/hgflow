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
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  
  $ hg flow develop 
  flow: Update workspace to <develop> trunk.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)
  flow: <develop> trunk: develop
  flow: Open <develop> branches:
  flow:   develop\* * (glob)

  $ hg flow feature start a
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/a

  $ hg bookmark feature/b

  $ touch b

  $ hg add b

  $ hg commit b -m "Added file 'b'."

  $ hg flow feature b
  flow: error: Invalid action or unknown branch in <feature>: 'b'
  flow: note: If you meant to create a new branch called 'b' in <feature>
  flow: note: try command:
  flow: note:   hg flow feature start b

  $ hg flow feature start b
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  (leaving bookmark feature/b)
  marked working directory as branch feature/b

  $ hg flow feature b
  flow: You are already in <feature> 'b'.
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  * files updated, 0 files merged, 0 files removed, 0 files unresolved (glob)
  (branch merge, don't forget to commit)
