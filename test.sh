#!/bin/sh
ftp -n 127.0.0.1 1021 << EOF
quote USER circle-user
quote PASS circle-pass
mkdir circle-test
quit
EOF
