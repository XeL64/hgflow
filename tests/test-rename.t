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

  $ hg bookmark dev

  $ hg flow feature start a
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (leaving bookmark dev)
  marked working directory as branch feature/a

  $ hg flow feature rename -t b
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/b
  grafting 2:* "flow: Created branch 'feature/a'." (glob)
  note: graft of 2:* created no changes to commit (glob)
  saved backup bundle to * (glob)

  $ touch b

  $ hg add b

  $ hg commit b -m "Added file 'b'."

  $ hg flow feature rename -t c
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/c
  grafting 3:* "Added file 'b'." (glob)
  saved backup bundle to * (glob)

  $ touch c

  $ hg add c

  $ hg flow feature rename -t d
  flow: warning: Your workspace has uncommitted changes.
  popping flow/feature/c.pch
  patch queue now empty
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/d
  grafting 3:* "Added file 'b'." (glob)
  applying $TESTTMP/a/.hg/patches/flow/feature/c.pch (glob)
  saved backup bundle to * (glob)

  $ hg flow feature rename -t d
  flow: warning: Your workspace has uncommitted changes.
  flow: warning: No effects because the supposed new basename turns out to be the same as the current one.

  $ hg flow release rename -t e
  flow: warning: Your workspace has uncommitted changes.
  flow: error: Your workspace is 'feature/d' branch, which is not in <release>.
  flow: error: To rename a <release> branch, you must first update to it.

  $ hg flow feature start EQ-123
  flow: warning: Your workspace has uncommitted changes.
  popping flow/feature/d.pch
  patch queue now empty
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/EQ-123

  $ hg flow feature rename -t EQ-321
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/EQ-321
  grafting 4:* "flow: Created branch 'feature/EQ-123'." (glob)
  note: graft of 4:* created no changes to commit (glob)
  saved backup bundle to * (glob)
