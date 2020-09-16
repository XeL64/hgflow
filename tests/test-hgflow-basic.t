  $ cat >> $HGRCPATH <<EOF
  > [extensions]
  > flow = $TESTDIR/../src/hgflow.py
  > mq =
  > EOF

  $ hg help flow
  hg flow {<stream> [<action> [<arg>]] | <command>} [<option>...]
  
  Flow is a Mercurial extension to support the generalized Driessen's branching
  model.
  
  actions:
  
  - start    Open a new branch in the stream.
  - finish   Close workspace branch and merge it to destination stream(s).
  - push     Push workspace branch to the remote repository.
  - publish  Same as [\"\']push[\"\'] (re)
  - pull     Pull from the remote repository and update workspace branch.
  - list     List all open branches in the stream.
  - log      Show revision history of branch.
  - promote  Merge workspace to other branches. (not closing any branches.)
  - rebase   Rebase workspace branch to its parent branch.
  - rename   Rename workspace branch to a new basename.
  - abort    Abort branch. Close branch without merging.
  
  If no action is specified by user, the action will default to [\"\']list[\"\']. If a (re)
  branch name (instead of action) is given after the stream name, Flow will
  switch the current workspace to the branch.
  
  commands:
  
  - init     Initialize flow.
  - unshelve Unshelve the previously shelved changes for workspace branch.
  - upgrade  Upgrade the configuration file to v0.9.5 or later.
  - help     Show help for a specific topic. Example:: 'hg flow help @help'
  - version  Show flow's version number.
  
  more:
  
  - 'hg flow help @terms' to be familiar with hgflow's terminologies.
  - 'hg flow help @all' to read complete document.
  - 'hg flow help @examples' to taste some example commands.
  - 'hg flow help @deprecated' to be aware of what has been deprecated.
  - 'hg flow help @help' to get some help on help. :-)
  - Feel free to report bugs, suggest features, and ask questions on
    "https://bitbucket.org/yujiewu/hgflow".
  
  options ([+] can be repeated):
  
      --history       Print history of hg commands used in this workflow.
      --dry-run       Do not perform actions, just print history.
      --dirty         Start a new branch from a dirty workspace, and move all
                      uncommitted changes to the new branch. [start]
   -c --closed        Show normal and closed branches in stream. [list, log]
   -c --commit        Commit changes before closing the branch. [finish]
   -d --default       Initialize flow with default configuration. [init]
   -d --date DATE     Record the specified date as commit date. [start, finish,
                      promote]
   -d --date DATE     Show revisions matching date spec. [log]
   -d --dest REV      Destination changeset of rebasing. [rebase]
   -e --erase         Erase branch after it is merged or aborted successfully.
                      [finish, abort]
   -F --file FILE [+] File to show history of. [log]
   -f --force         Force reinitializing flow. [init]
   -g --git           Use git extended diff format to show patch. [log]
   -k --keyword TEXT  Do case-insensitive search for a given text. [log]
   -l --limit VALUE   Limit number of changesets displayed. [log]
   -m --message TEXT  Record TEXT as commit message. [start, finish, promote,
                      abort]
   -p --patch         Show patch. [log]
   -p --stamp TEXT    Append TEXT to all commit messages. [init, upgrade, start,
                      finish, promote, abort]
   -r --rev REV       Revision to start a new branch from. [start]
   -r --rev REV       Revision to promote to other branches. [promote]
   -s --onstream      Act on stream. [finish, rebase, log, abort]
   -t --tag NAME      Tag the merging changeset with NAME. [promote]
   -t --tag NAME      Tag the <master> trunk with NAME after merging. [finish]
   -t --to NAME       Rename the branch to NAME. [rename]
   -u --user USER     Use specified user as committer. [init, upgrade, start,
                      finish, promote]
   -u --user USER     Show revisions committed by specified user. [log]
      --mq            operate on patch repository
  
  (some details hidden, use --verbose to show complete help)

  $ cd

  $ hg init a

  $ cd a

  $ hg flow init -d --dry-run
  flow: This is a dry run.
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
  flow: note: Hg command history:
  flow: note:   hg branch default 
  flow: note:   hg commit --message "flow initialization: Created <master> trunk: default."
  flow: note:   hg branch develop 
  flow: note:   hg commit --message "flow initialization: Created <develop> trunk: develop."
  flow: note:   hg update default 
  
  $ ls -a
  .
  ..
  .hg

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
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branches are permanent and global, did you want a bookmark?) (?)
  
  $ hg flow feature start .f.1
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.1
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature start .f.2
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.2
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow develop start .d.1
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch develop/.d.1
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow develop finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch release/.d.1
  (branches are permanent and global, did you want a bookmark?) (?)
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

  $ hg flow hotfix start .h.1
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch hotfix/.h.1
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow hotfix promote
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 1 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow hotfix start .h.2
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch hotfix/.h.2
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow hotfix promote
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow hotfix finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature start .f.10
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.10
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.11
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.11
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.12
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.12
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.13
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.13
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.14
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.14
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.15
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.15
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.16
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.16
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.17
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.17
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.18
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.18
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.19
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.19
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature start .f.20
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch feature/.f.20
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow feature .f.10
  flow: Update workspace to <feature> '.f.10'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.12
  flow: Update workspace to <feature> '.f.12'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.14
  flow: Update workspace to <feature> '.f.14'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.16
  flow: Update workspace to <feature> '.f.16'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.18
  flow: Update workspace to <feature> '.f.18'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.20
  flow: Update workspace to <feature> '.f.20'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow develop start .d.11
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch develop/.d.11
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow develop finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch release/.d.11
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow release finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.11
  flow: Update workspace to <feature> '.f.11'.
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.13
  flow: Update workspace to <feature> '.f.13'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.15
  flow: Update workspace to <feature> '.f.15'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.17
  flow: Update workspace to <feature> '.f.17'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow feature .f.19
  flow: Update workspace to <feature> '.f.19'.
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  flow: Parent of working directory: * (glob)

  $ hg flow feature finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow develop start .d.21
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch develop/.d.21
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow develop finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch release/.d.21
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow release finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow hotfix start .h.10
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch hotfix/.h.10
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow hotfix promote
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow hotfix start .h.11
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch hotfix/.h.11
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow hotfix promote
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow hotfix start .h.12
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch hotfix/.h.12
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow hotfix promote
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow hotfix finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)

  $ hg flow support start .s.1
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch support/.s.1
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow support finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow support start .s.2
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch support/.s.2
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow support finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow develop start .d.31
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch develop/.d.31
  (branches are permanent and global, did you want a bookmark?) (?)

  $ hg flow develop finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  marked working directory as branch release/.d.31
  (branches are permanent and global, did you want a bookmark?) (?)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ hg flow release finish
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  (branch merge, don't forget to commit)
