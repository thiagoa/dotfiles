(load (merge-pathnames ".sbclrc" (user-homedir-pathname)))

(ql:quickload "cl-json" :silent t)
(require "inferior-shell")

(defparameter *ssh-user* "ec2-user")
(defparameter *ssh-key-path* "~/.ssh/us-east-1-platform-key.pem")

(defun abort-program (message)
  (princ (format nil "ERROR: ~a~%" message) *error-output*)
  (sb-ext:quit :unix-status 1))

(defun get-raw-aws-json (instance-name)
  (inferior-shell:run/s
   (concatenate 'string
                "aws ec2 describe-instances"
                " --region us-east-1"
                " --filters 'Name=tag:Name,Values=" instance-name "'"
                "           'Name=instance-state-name,Values=running'")))

(defun get-aws-attr (instance-name attr-name)
  (let* ((raw-json (get-raw-aws-json instance-name))
         (parsed-json (json:decode-json-from-string raw-json))
         (aws-attrs (cadar (cdadar parsed-json))))
    (cdr (assoc attr-name aws-attrs))))

(defun run-ssh (instance-name initial-cmd)
  (unless instance-name
    (error "No instance name given"))

  (let ((dns (get-aws-attr instance-name :*private-ip-address)))
    (unless dns
      (error "No DNS name found. Is the instance name correct?"))

    (inferior-shell:run/interactive
     (concatenate 'string
                  "ssh -i "
                  *ssh-key-path* " "
                  *ssh-user* "@" dns
                  (when initial-cmd
                    (concatenate 'string " -t " initial-cmd))))))
