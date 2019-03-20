#!/bin/bash

#!/bin/bash

WHITELIST=whitelist.txt
IMG=~/dfrws/samsung/blk0_sda.bin
CAPTURE_START="2018-04-01"
CAPTURE_END="2019-01-01" # chosen to eliminate garbage events
TZ=Europe/Zurich # from userdata/property/persist.sys.timezone, GMT+2 during the summer
MNT="/mnt/userdata/data"
L2T=`which log2timeline.py`
PSORT=`which psort.py`

function make_plaso_timeline() {
	"${L2T}" -z "${TZ}" --parsers sqlite "${plaso_db}" "${MNT}"
	"${PSORT}" -z "${TZ}" -o elastic --raw_fields --elastic_user elastic --index_name dfrws2019 "${plaso_db}" "date > '${CAPTURE_START}' and date < '${CAPTURE_END}'"

}

# "Main"
# bail on any error
set -e

plaso_db="dfrws-plaso.db"
plaso_csv="dfrws-plaso.csv"

make_plaso_timeline
