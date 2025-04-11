(use-modules (ice-9 popen)
             (ice-9 rdelim)
             (ice-9 format))

(define (run-command cmd)
  (display (string-append "Running: " cmd "\n"))
  (let* ((proc (open-pipe* OPEN_READ "sh" "-c" cmd))
         (output (read-line proc)))
    (close-pipe proc)
    output))

(define (compile files)
  (for-each (lambda (file) (run-command (string-append "ocamlopt -c " file))) files))

(define (clean)
  (run-command "rm -f *.cm* *.o"))

(define (build)
  (clean)
  (compile '("utils.ml" "ascii.ml" "args.ml" "main.ml"))
  (run-command "ocamlopt -o mletch unix.cmxa utils.cmx ascii.cmx args.cmx main.cmx"))

(build)
(clean)
(display "Build finished!\n")
