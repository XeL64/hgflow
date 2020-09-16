  $ cat >> $HGRCPATH <<EOF
  > [extensions]
  > flow = $TESTDIR/../src/hgflow.py
  > mq =
  > [flow]
  > autoshelve = yes
  > EOF

  $ hg init a

  $ cd a

  $ hg flow init -d -p "STAMP"
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

  $ hg flow feature start a -p 'ISSUE#1234'
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/a
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature log
  changeset:   2:* (glob)
  branch:      feature/a
  tag:         tip
  user:        test
  date:        * (glob)
  summary:     flow: Created branch 'feature/a'. ISSUE#1234
  
 
  $ hg flow feature finish -p 'ISSUE#1234'
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow develop log
  changeset:   4:* (glob)
  branch:      develop
  tag:         tip
  parent:      1:* (glob)
  parent:      3:* (glob)
  user:        test
  date:        * (glob)
  summary:     flow: Merged <feature> 'a' to <develop> ('develop'). ISSUE#1234
  
  changeset:   1:* (glob)
  branch:      develop
  user:        test
  date:        * (glob)
  summary:     flow initialization: Created <develop> trunk: develop. STAMP
  
 
  $ hg flow feature start b --stamp "ISSUE#2345"
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/b
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature promote -p "ISSUE#2345"
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow feature log
  changeset:   5:* (glob)
  branch:      feature/b
  user:        test
  date:        * (glob)
  summary:     flow: Created branch 'feature/b'. ISSUE#2345
  
  $ hg flow develop log
  changeset:   6:* (glob)
  branch:      develop
  tag:         tip
  parent:      4:* (glob)
  parent:      5:* (glob)
  user:        test
  date:        * (glob)
  summary:     flow: Promoted <feature> 'b' (*) to 'develop'. ISSUE#2345 (glob)
  
  changeset:   4:* (glob)
  branch:      develop
  parent:      1:* (glob)
  parent:      3:* (glob)
  user:        test
  date:        * (glob)
  summary:     flow: Merged <feature> 'a' to <develop> ('develop'). ISSUE#1234
  
  changeset:   1:* (glob)
  branch:      develop
  user:        test
  date:        * (glob)
  summary:     flow initialization: Created <develop> trunk: develop. STAMP
  
  $ hg flow feature start c -p "ISSUE#3456"
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/c
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature abort -p "ISSUE#3456"
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow feature log c
  changeset:   8:* (glob)
  branch:      feature/c
  tag:         tip
  user:        test
  date:        * (glob)
  summary:     flow: Aborted <feature> 'c'. ISSUE#3456
  
  changeset:   7:* (glob)
  branch:      feature/c
  user:        test
  date:        * (glob)
  summary:     flow: Created branch 'feature/c'. ISSUE#3456
  
