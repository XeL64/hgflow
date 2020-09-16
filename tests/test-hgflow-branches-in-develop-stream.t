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
  
  $ hg flow develop
  flow: Update workspace to <develop> trunk.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)
  flow: <develop> trunk: develop
  flow: Open <develop> branches:
  flow:   develop\* * (glob)

  $ hg flow develop start spring
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch develop/spring
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow develop/spring:feature start feature_for_spring_release
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/feature_for_spring_release
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow develop/spring:feature finish --dry-run
  flow: This is a dry run.
  flow: note: Hg command history:
  flow: note:   hg commit --message "flow: Closed <feature> 'feature_for_spring_release'." --close-branch
  flow: note:   hg update develop/spring 
  flow: note:   hg merge feature/feature_for_spring_release 
  flow: note:   hg commit --message "flow: Merged <feature> 'feature_for_spring_release' to <develop/spring> ('develop/spring')."
  flow: note:   hg update develop 
  flow: note:   hg merge develop/spring 
  flow: note:   hg commit --message "flow: Merged <develop/spring:feature> 'feature_for_spring_release' to <develop> ('develop')."

  $ hg flow develop/spring:feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow develop spring
  flow: Update workspace to <develop> 'spring'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow develop finish --dry-run
  flow: This is a dry run.
  flow: note: Hg command history:
  flow: note:   hg update develop/spring 
  flow: note:   hg branch release/spring 
  flow: note:   hg commit --message "flow: Created branch 'release/spring'."
  flow: note:   hg update develop/spring 
  flow: note:   hg commit --message "flow: Closed <develop> 'spring'." --close-branch
  flow: note:   hg update develop 
  flow: note:   hg merge develop/spring 
  flow: note:   hg commit --message "flow: Merged <develop> 'spring' to <develop> ('develop')."
  flow: note:   hg update release/spring 
