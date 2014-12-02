
((digest . "3c434657b5a002b826c01606af83ba61") (undo-list (86402 . 86410) (80419 . 80527) (86286 . 86294) (86266 . 86267) (85463 . 86285) (85373 . 85374) (84072 . 85462) (83980 . 83981) (82699 . 84071) (82666 . 82667) (82184 . 82698) (82170 . 82171) (81921 . 82183) (81870 . 81871) (81352 . 81920) (81286 . 81287) (80419 . 81351) (83443 . 83451) (80419 . 80545) (83307 . 83317) (83278 . 83279) (83011 . 83306) (82982 . 82983) (82711 . 83010) (82682 . 82683) (82416 . 82710) (82352 . 82353) (81472 . 82415) (81408 . 81409) (80419 . 81471) ("
;;;### (autoloads (org-ascii-publish-to-utf8 org-ascii-publish-to-latin1
;;;;;;  org-ascii-publish-to-ascii org-ascii-export-to-ascii org-ascii-export-as-ascii)
;;;;;;  \"ox-ascii\" \"ox-ascii.el\" \"8bba507846964285c7ecb40e66b6afe3\")
;;; Generated autoloads from ox-ascii.el

(autoload 'org-ascii-export-as-ascii \"ox-ascii\" \"\\
Export current buffer to a text buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, strip title and
table of contents from output.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \\\"*Org ASCII Export*\\\", which
will be displayed when `org-export-show-temporary-export-buffer'
is non-nil.

\\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)\" t nil)

(autoload 'org-ascii-export-to-ascii \"ox-ascii\" \"\\
Export current buffer to a text file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, strip title and
table of contents from output.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return output file's name.

\\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)\" t nil)

(autoload 'org-ascii-publish-to-ascii \"ox-ascii\" \"\\
Publish an Org file to ASCII.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name.

\\(fn PLIST FILENAME PUB-DIR)\" nil nil)

(autoload 'org-ascii-publish-to-latin1 \"ox-ascii\" \"\\
Publish an Org file to Latin-1.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name.

\\(fn PLIST FILENAME PUB-DIR)\" nil nil)

(autoload 'org-ascii-publish-to-utf8 \"ox-ascii\" \"\\
Publish an org file to UTF-8.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name.

\\(fn PLIST FILENAME PUB-DIR)\" nil nil)

;;;***
" . -80419) nil (31228 . 31236) (26393 . 26522) (31091 . 31099) (31085 . 31086) (30947 . 31090) (30934 . 30935) (30837 . 30946) (30825 . 30826) (30347 . 30836) (30327 . 30328) (29892 . 30346) (29874 . 29875) (29656 . 29891) (29623 . 29624) (29391 . 29655) (29364 . 29365) (29116 . 29390) (29063 . 29064) (28555 . 29115) (28532 . 28533) (28338 . 28554) (28332 . 28333) (28221 . 28337) (28168 . 28169) (27870 . 28220) (27850 . 27851) (27367 . 27869) (27333 . 27334) (26645 . 27366) (26545 . 26546) (26591 . 26592) (26393 . 26643) ("
;;;### (autoloads (org-clock-update-time-maybe org-dblock-write:clocktable
;;;;;;  org-clocktable-shift org-clock-report org-clock-get-clocktable
;;;;;;  org-clock-remove-overlays org-clock-display org-clock-sum
;;;;;;  org-clock-goto org-clock-cancel org-clock-out org-clock-in-last
;;;;;;  org-clock-in org-resolve-clocks) \"org-clock\" \"org-clock.el\"
;;;;;;  \"32564b628bbb84d0342715e3d7097a29\")
;;; Generated autoloads from org-clock.el

(autoload 'org-resolve-clocks \"org-clock\" \"\\
Resolve all currently open org-mode clocks.
If `only-dangling-p' is non-nil, only ask to resolve dangling
\\(i.e., not currently open and valid) clocks.

\\(fn &optional ONLY-DANGLING-P PROMPT-FN LAST-VALID)\" t nil)

(autoload 'org-clock-in \"org-clock\" \"\\
Start the clock on the current item.
If necessary, clock-out of the currently active clock.
With a prefix argument SELECT (\\\\[universal-argument]), offer a list of recently clocked
tasks to clock into.  When SELECT is \\\\[universal-argument] \\\\[universal-argument], clock into the current task
and mark it as the default task, a special task that will always be offered
in the clocking selection, associated with the letter `d'.
When SELECT is \\\\[universal-argument] \\\\[universal-argument] \\\\[universal-argument], clock in by using the last clock-out
time as the start time (see `org-clock-continuously' to
make this the default behavior.)

\\(fn &optional SELECT START-TIME)\" t nil)

(autoload 'org-clock-in-last \"org-clock\" \"\\
Clock in the last closed clocked item.
When already clocking in, send an warning.
With a universal prefix argument, select the task you want to
clock in from the last clocked in tasks.
With two universal prefix arguments, start clocking using the
last clock-out time, if any.
With three universal prefix arguments, interactively prompt
for a todo state to switch to, overriding the existing value
`org-clock-in-switch-to-state'.

\\(fn &optional ARG)\" t nil)

(autoload 'org-clock-out \"org-clock\" \"\\
Stop the currently running clock.
Throw an error if there is no running clock and FAIL-QUIETLY is nil.
With a universal prefix, prompt for a state to switch the clocked out task
to, overriding the existing value of `org-clock-out-switch-to-state'.

\\(fn &optional SWITCH-TO-STATE FAIL-QUIETLY AT-TIME)\" t nil)

(autoload 'org-clock-cancel \"org-clock\" \"\\
Cancel the running clock by removing the start timestamp.

\\(fn)\" t nil)

(autoload 'org-clock-goto \"org-clock\" \"\\
Go to the currently clocked-in entry, or to the most recently clocked one.
With prefix arg SELECT, offer recently clocked tasks for selection.

\\(fn &optional SELECT)\" t nil)

(autoload 'org-clock-sum \"org-clock\" \"\\
Sum the times for each subtree.
Puts the resulting times in minutes as a text property on each headline.
TSTART and TEND can mark a time range to be considered.
HEADLINE-FILTER is a zero-arg function that, if specified, is called for
each headline in the time range with point at the headline.  Headlines for
which HEADLINE-FILTER returns nil are excluded from the clock summation.
PROPNAME lets you set a custom text property instead of :org-clock-minutes.

\\(fn &optional TSTART TEND HEADLINE-FILTER PROPNAME)\" t nil)

(autoload 'org-clock-display \"org-clock\" \"\\
Show subtree times in the entire buffer.
If TOTAL-ONLY is non-nil, only show the total time for the entire file
in the echo area.

Use \\\\[org-clock-remove-overlays] to remove the subtree times.

\\(fn &optional TOTAL-ONLY)\" t nil)

(autoload 'org-clock-remove-overlays \"org-clock\" \"\\
Remove the occur highlights from the buffer.
BEG and END are ignored.  If NOREMOVE is nil, remove this function
from the `before-change-functions' in the current buffer.

\\(fn &optional BEG END NOREMOVE)\" t nil)

(autoload 'org-clock-get-clocktable \"org-clock\" \"\\
Get a formatted clocktable with parameters according to PROPS.
The table is created in a temporary buffer, fully formatted and
fontified, and then returned.

\\(fn &rest PROPS)\" nil nil)

(autoload 'org-clock-report \"org-clock\" \"\\
Create a table containing a report about clocked time.
If the cursor is inside an existing clocktable block, then the table
will be updated.  If not, a new clocktable will be inserted.  The scope
of the new clock will be subtree when called from within a subtree, and
file elsewhere.

When called with a prefix argument, move to the first clock table in the
buffer and update it.

\\(fn &optional ARG)\" t nil)

(autoload 'org-clocktable-shift \"org-clock\" \"\\
Try to shift the :block date of the clocktable at point.
Point must be in the #+BEGIN: line of a clocktable, or this function
will throw an error.
DIR is a direction, a symbol `left', `right', `up', or `down'.
Both `left' and `down' shift the block toward the past, `up' and `right'
push it toward the future.
N is the number of shift steps to take.  The size of the step depends on
the currently selected interval size.

\\(fn DIR N)\" nil nil)

(autoload 'org-dblock-write:clocktable \"org-clock\" \"\\
Write the standard clocktable.

\\(fn PARAMS)\" nil nil)

(autoload 'org-clock-update-time-maybe \"org-clock\" \"\\
If this is a CLOCK line, update it and return t.
Otherwise, return nil.

\\(fn)\" t nil)

;;;***
" . -26393) (t 21604 14603 350559 945000)))
