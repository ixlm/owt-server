#!/usr/bin/env bash
#
#/**
# * License placeholder.
# */
#

this=`dirname "$0"`
this=`cd "$this"; pwd`
ROOT=`cd "${this}/../.."; pwd`
SOURCE="${ROOT}/source"

export WOOGEEN_DIST="${ROOT}/dist"
PACK_ARCH=false
PACK_MODULE=true
ENCRYPT=false
ENCRYPT_CAND_PATH=
PACKAGE_VERSION=
SRC_SAMPLE_PATH=
PREVIOUS_DIR=$(pwd)
OS=$(${ROOT}/scripts/detectOS.sh | awk '{print tolower($0)}')

cd ${this}
. common.sh
shopt -s extglob
while [[ $# -gt 0 ]]; do
  case $1 in
    *(-)mcu )
      . mcu_funcs.sh #set target to mcu
      ;;
    *(-)gateway )
      . gw_funcs.sh #set target to gateway
      ;;
    *(-)no-module )
      PACK_MODULE=false
      ;;
    *(-)archive )
      PACK_ARCH=true
      ;;
    *(-)encrypt )
      ENCRYPT=true
      ;;
    *(-)src-sample-path=* )
      SRC_SAMPLE_PATH=${1##*(-)}
      SRC_SAMPLE_PATH=${SRC_SAMPLE_PATH:16}
      [[ ${SRC_SAMPLE_PATH:0:1} == "/" ]] || SRC_SAMPLE_PATH="${PREVIOUS_DIR}/${SRC_SAMPLE_PATH}"
      ;;
    *(-)help )
      usage
      exit 0
      ;;
    v[0-9]*)
      PACKAGE_VERSION="$1"
      ;;
    * )
      echo -e "\x1b[33mUnknown argument\x1b[0m: $1"
      ;;
  esac
  shift
done

if ! hash pack_runtime 2>/dev/null; then
  usage
  exit 0
fi
echo "Cleaning ${WOOGEEN_DIST}/ ..."; rm -fr ${WOOGEEN_DIST}/
SRC_SAMPLE_PATH="${SRC_SAMPLE_PATH}" pack_runtime
pack_scripts
${PACK_MODULE} && install_module
pack_node
type pack_libs >/dev/null 2>&1 && pack_libs
type pack_license >/dev/null 2>&1 && pack_license
${PACK_ARCH} && archive
