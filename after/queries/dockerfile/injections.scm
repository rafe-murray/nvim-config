; extends

(run_instruction
  (shell_command) @injection.content
  (#set! injection.language "bash")
  (#set! injection.include-children "true"))
