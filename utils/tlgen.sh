#!/bin/bash

WHITELIST=whitelist.txt
IMG=~/dfrws/samsung/blk0_sda.bin
CAPTURE_START="2018-05-10"
CAPTURE_END="2019-01-01" # chosen to eliminate garbage events
TZ=Europe/Zurich # from userdata/property/persist.sys.timezone, GMT+2 during the summer


function get_blksiz() {
	mmls "${IMG}" | awk '/^Units are in [0-9]+-byte sectors$/ { blksiz=$4; gsub("-byte","", blksiz); print blksiz }'
}

function get_userdata_offset() {
	# The "+0" makes awk convert the field to an integer (if it can)
	mmls "${IMG}" | awk '/USERDATA$/ { print $3+0 }'
}


function make_fls_timeline() {
	echo -n generating fls timeline...
	fls -o "${blkoff}" -b "${blksiz}" -r -m / "${IMG}" | mactime -d -z "${TZ}" "${CAPTURE_START}..${CAPTURE_END}" > "${fls_csv}"
	echo done.

	if [[ -r "${whitelist}" ]] ; then
		echo -n filtering fls timeline...
		grep -v -i -f "${whitelist}" "${fls_csv}" > "${fls_csvf}"
		echo done.
	else
		echo "whitelist not found -- not generating final fls timeline."
	fi
}

function make_plaso_timeline() {
	log2timeline.py -z "${TZ}" --sector-size "${blksiz}" --offset "${blkoff}" "${plaso_db}" "${IMG}"
	psort.py -z "${TZ}" -o l2tcsv "${plaso_db}" "date > '${CAPTURE_START}' and date < '${CAPTURE_END}'" -w "${plaso_csv}"

	if [[ -r "${whitelist}" ]] ; then
		echo -n filtering plaso timeline...
		grep -v -i -f "${whitelist}" "${plaso_csv}" > "${plaso_csvf}"
		echo done.
	else
		echo "whitelist not found -- not generating final plaso timeline."
	fi
}

# "Main"
# bail on any error
set -e

bn="$(basename "${IMG}")"
fls_csv="${bn}-mactime-timeline.csv"
fls_csvf="${bn}-mactime-timeline-final.csv"
plaso_db="${bn}-plaso.db"
plaso_csv="${bn}-plaso.csv"
plaso_csvf="${bn}-plaso-final.csv"

blkoff=$(get_userdata_offset)
blksiz=$(get_blksiz)
echo blockoffset=${blkoff}, blocksize=${blksiz}

make_fls_timeline
make_plaso_timeline

