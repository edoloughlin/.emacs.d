 (autoload 'copy-from-above-command "misc"
    "Copy characters from previous nonblank line, starting just above point.
  
  \(fn &optional arg)"
    'interactive)

(defun copy-char-down-if-space ()
  (interactive)
  (while (char-equal (char-after) ?\ )
	(progn
	  (copy-from-above-command 1)
	  (left-char)
	  (next-line))))

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

