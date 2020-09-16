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
  
  $ hg flow develop 
  flow: Update workspace to <develop> trunk.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)
  flow: <develop> trunk: develop
  flow: Open <develop> branches:
  flow:   develop\*  1:* (glob)

  $ cat > b << EOF
  > Some text in b file
  > EOF

  $ hg add b

  $ hg commit b -m "Added file 'b'."

  $ hg flow develop log -p
  changeset:   2:* (glob)
  branch:      develop
  tag:         tip
  user:        test
  date:        * (glob)
  summary:     Added file 'b'.
  
  diff -r * -r * b (glob)
  --- /dev/null	* (glob)
  +++ b/b	* (glob)
  @@ -0,0 +1,1 @@
  +Some text in b file
  
  changeset:   1:* (glob)
  branch:      develop
  user:        test
  date:        * (glob)
  summary:     flow initialization: Created <develop> trunk: develop.
  
  
