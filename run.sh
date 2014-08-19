#!/bin/sh

#
# Return true if local npm package is installed
# at ./node_modules, else return false.
#
# usage:
#   echo "gruntacular : $(npm_package_is_installed gruntacular)"
#

function npm_package_is_installed {
  # set to true initially
  local return_=true
  # set to false if not found
  ls node_modules | grep $1 >/dev/null 2>&1 || { local return_=false; }
  # return value
  echo "$return_"
}

#
# Make sure gulp is installed.
#

if ! type gulp &> /dev/null ; then
  # Check if installed in repo.
  if ! $(npm_package_is_installed gulp) ; then
    info "gulp not installed, trying to install it through npm"

    if ! type npm &> /dev/null ; then
      fail "npm not found, make sure you have npm or gulp installed"
    else
      info "npm is available"
      debug "npm version: $(npm --version)"

      info "installing gulp"
      npm config set ca "" --silent
      sudo npm install npm -g --silent
      sudo npm install -g --silent gulp
      gulp_command="gulp"
    fi
  else
    info "gulp is available locally"
    debug "gulp version: $(./node_modules/gulp/bin/gulp.js --version)"
    gulp_command="./node_modules/gulp/bin/gulp.js"
  fi
else
  info "gulp is available"
  debug "gulp version: $(gulp --version)"
  gulp_command="gulp"
fi

gulp_working_path=""

#
# Parse variable arguments.
#

if [ "$WERCKER_GULP_SILENT" = "true" ] ; then
  gulp_command="$gulp_command --silent"
fi

if [ -n "$WERCKER_GULP_TASKS" ] ; then
  gulp_command="$gulp_command $WERCKER_GULP_TASKS"
fi

debug "$gulp_command"

set +e
$gulp_command
result="$?"
set -e

#
# Set exit status.
#

# Fail if it is not a success or warning
if [[ result -ne 0 && result -ne 6 ]]
then
  warn "$result"
  fail "gulp command failed"
else
  success "finished $gulp_command"
fi
