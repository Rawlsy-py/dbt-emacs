;;; dbt-mode.el a dbt support package for eMacs -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Christopher Mitchell
;;
;; Author: Christopher Mitchell <christophermitchell@Christophers-MacBook-Air-2.local>
;; Maintainer: Christopher Mitchell <christophermitchell@Christophers-MacBook-Air-2.local>
;; Created: November 03, 2026
;; Modified: November 03, 2026
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc
;; Homepage: https://github.com/christophermitchell/dbt-mode
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:
;;; dbt-mode.el --- Custom dbt integration for Doom Emacs -*- lexical-binding: t; -*-

(defgroup dbt nil
  "Custom dbt workflow utilities."
  :group 'languages)

(defcustom dbt-executable (or (executable-find "dbt") "~/.local/bin/dbt")
  "Path to the dbt executable installed via uv tool."
  :type 'string
  :group 'dbt)

(defcustom dbt-target-dir "target"
  "Target directory where compiled dbt artifacts sit."
  :type 'string
  :group 'dbt)

(defun dbt-get-model-name ()
  "Extract model name from current buffer."
  (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))

;;;###autoload
(defun dbt-run-model-at-point ()
  "Run 'dbt run --select <current_model>' using uv's global dbt."
  (interactive)
  (compile (format "%s run --select %s" dbt-executable (dbt-get-model-name))))

;;;###autoload
(defun dbt-run-all ()
  "Run 'dbt run' for the entire project."
  (interactive)
  (compile (format "%s run" dbt-executable)))

;;;###autoload
(defun dbt-test ()
  "Run 'dbt test'."
  (interactive)
  (compile (format "%s test" dbt-executable)))

;;;###autoload
(defun dbt-compile ()
  "Run 'dbt compile'."
  (interactive)
  (compile (format "%s compile" dbt-executable)))

;;;###autoload
(defun dbt-view-compiled-sql ()
  "Open compiled SQL file for current buffer in a split window."
  (interactive)
  (let* ((proj-root (cl-struct-slot-value 'project 'root (project-current)))
         (rel-path (file-relative-name (buffer-file-name) proj-root))
         (compiled-path (expand-file-name (concat dbt-target-dir "/compiled/" rel-path) proj-root)))
    (if (file-exists-p compiled-path)
        (find-file-other-window compiled-path)
      (message "Compiled SQL not found. Run 'dbt compile' first."))))

(provide 'dbt-mode)
;;; dbt-mode.el ends here
