  $ cat >> $HGRCPATH <<EOF
  > [extensions]
  > flow = $TESTDIR/../src/hgflow.py
  > mq =
  > EOF

  $ cd

  $ hg init a

  $ cd a

  $ hg flow init -d
  flow: 
  When you switch to another branch, flow can automatically shelve uncommitted
  changes in workpace right before switching. Later when you switch back, flow can
  automatically unshelve the changes to the workspace. This functionality is
  called autoshelve. You need the 'mq' extension to use it.
  Do you want to turn it on? [Yes]  y
  flow: 
  Here is what you need to do:
    To turn it on for only this repository, edit your <repository-root>/.hg/hgrc
    file by adding the following lines:
        [flow]
        autoshelve = true
    You can turn it on for all of your repositories by doing the same edition to
    your $HOME/.hgrc file. To turn it off, just edit the corresponding file and
    replace 'true' with 'false'.
  
  Press Enter to continue initialization... y
  marked working directory as branch develop
  (branches are permanent and global, did you want a bookmark?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  
  $ hg flow hotfis
  flow: error: Stream not found: <hotfis>
  flow: note: Did you mean: hotfix?

  $ hg flow hotfix stat 0.9.7.1
  flow: error: Invalid action or unknown branch in <hotfix>: 'stat'
  flow: note: Did you mean: start?

  $ hg flow hotfix close
  flow: error: Invalid action or unknown branch in <hotfix>: 'close'
  flow: note: Did you mean: finish or abort?

