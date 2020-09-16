  $ cat >> $HGRCPATH <<EOF
  > [extensions]
  > flow = $TESTDIR/../src/hgflow.py
  > mq =
  > rebase =
  > [flow]
  > autoshelve = yes
  > EOF

  $ hg init a

  $ cd a

  $ hg flow init -d
  flow: Global configuration:
  flow:   autoshelve: on
  marked working directory as branch develop
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branches are permanent and global, did you want a bookmark?) (?)
  
  $ hg flow init -d
  flow: Flow was already initialized for workspace:
  flow: Repository-specific configuration:
  flow:   <master>  trunk: 'default'
  flow:   <develop> trunk: 'develop'
  flow:   <feature> branch prefix: 'feature/'
  flow:   <release> branch prefix: 'release/'
  flow:   <hotfix>  branch prefix: 'hotfix/'
  flow:   <support> branch prefix: 'support/'
  flow: Global configuration:
  flow:   autoshelve: on

  $ hg flow feature start A
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/A

  $ touch A

  $ hg add A

  $ hg commit A -m "Added file 'A'."

  $ hg flow feature start B
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/B

  $ touch B

  $ hg add B

  $ hg commit B -m "Added file 'B'."

  $ hg flow feature start C
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/C

  $ touch C

  $ hg add C

  $ hg commit C -m "Added file 'C'."

  $ hg flow feature/A start a1
  1 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/A/a1

  $ touch a1

  $ hg add a1

  $ hg commit a1 -m "Added file 'a1'."

  $ hg flow feature/A start a2
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/A/a2

  $ touch a2

  $ hg add a2

  $ hg commit a2 -m "Added file 'a2'."

  $ hg flow feature/A start a3
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/A/a3

  $ touch a3

  $ hg add a3

  $ hg commit a3 -m "Added file 'a3'."

  $ hg flow feature/A/a3 > /dev/null

  $ hg flow feature/A rebase --quiet

  $ hg flow feature/A finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/A/a2 > /dev/null

  $ hg flow feature/A rebase --quiet

  $ hg flow feature/A finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/A/a1 > /dev/null

  $ hg flow feature/A rebase --quiet

  $ hg flow feature/A finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/B start b1
  1 files updated, 0 files merged, 4 files removed, 0 files unresolved
  marked working directory as branch feature/B/b1

  $ touch b1

  $ hg add b1

  $ hg commit b1 -m "Added file 'b1'."

  $ hg flow feature/B start b2
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/B/b2

  $ touch b2

  $ hg add b2

  $ hg commit b2 -m "Added file 'b2'."

  $ hg flow feature/B start b3
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/B/b3

  $ touch b3

  $ hg add b3

  $ hg commit b3 -m "Added file 'b3'."

  $ hg flow feature/B/b3 > /dev/null

  $ hg flow feature/B rebase --quiet

  $ hg flow feature/B finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/B/b2 > /dev/null

  $ hg flow feature/B rebase --quiet

  $ hg flow feature/B finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/B/b1 > /dev/null

  $ hg flow feature/B rebase --quiet

  $ hg flow feature/B finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/C start c1
  1 files updated, 0 files merged, 4 files removed, 0 files unresolved
  marked working directory as branch feature/C/c1

  $ touch c1

  $ hg add c1

  $ hg commit c1 -m "Added file 'c1'."

  $ hg flow feature/C start c2
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/C/c2

  $ touch c2

  $ hg add c2

  $ hg commit c2 -m "Added file 'c2'."

  $ hg flow feature/C start c3
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  marked working directory as branch feature/C/c3

  $ touch c3

  $ hg add c3

  $ hg commit c3 -m "Added file 'c3'."

  $ hg flow feature/C/c3 > /dev/null

  $ hg flow feature/C rebase --quiet

  $ hg flow feature/C finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/C/c2 > /dev/null

  $ hg flow feature/C rebase --quiet

  $ hg flow feature/C finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/C/c1 > /dev/null

  $ hg flow feature/C rebase --quiet

  $ hg flow feature/C finish
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature/C > /dev/null

  $ hg flow feature rebase --quiet
  note: * (glob) (?)
  note: * (glob) (?)
  note: * (glob) (?)

  $ hg flow feature/B > /dev/null

  $ hg flow feature rebase --quiet
  note: * (glob) (?)
  note: * (glob) (?)
  note: * (glob) (?)

  $ hg flow feature/A > /dev/null

  $ hg flow feature rebase --quiet
  note: * (glob) (?)
  note: * (glob) (?)
  note: * (glob) (?)

  $ hg flow develop start ABC
  0 files updated, 0 files merged, 4 files removed, 0 files unresolved
  marked working directory as branch develop/ABC

  $ hg flow develop finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch release/ABC
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow release finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
