readonly NORMAL=$(printf '\033[0m')
readonly BOLD=$(printf '\033[1m')
readonly faint=$(printf '\033[2m')
readonly UNDERLINE=$(printf '\033[4m')
readonly NEGATIVE=$(printf '\033[7m')
readonly RED=$(printf '\033[31m')
readonly GREEN=$(printf '\033[32m')
readonly ORANGE=$(printf '\033[33m')
readonly BLUE=$(printf '\033[34m')
readonly YELLOW=$(printf '\033[93m')
readonly WHITE=$(printf '\033[39m')

function success()
{
  local msg=${1}
  echo " "
  echo "[${BOLD}${GREEN} OK ${NORMAL}] ${msg}"
  echo " "
}

function info()
{
  local msg=${1}
  echo " "
  echo "[${BOLD}${BLUE}INFO${NORMAL}] ${msg}"
  echo " "
}

function warn()
{
  local msg=${1}
  echo " "
  echo "[${BOLD}${ORANGE}WARN${NORMAL}] ${msg}"
  echo " "
}

function error()
{
  local msg=${1}
  echo " "
  echo "[${BOLD}${RED}FAIL${NORMAL}] ${msg}" 
  echo " "
}
