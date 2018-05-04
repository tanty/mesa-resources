#!/bin/bash

for i in baltix panix pacifix elastix; do ./get-results.sh $i; done

FILE=$(mktemp)

for i in kbl skl bdw hsw; do cat $i/results*.txt; done | sort | uniq | sort > "$FILE"

while IFS='' read -r GTT_LINE || [[ -n "$GTT_LINE" ]]; do
    echo '| ='"$GTT_LINE"'=  |  %CTS_PASS%  |  %CTS_PASS%  |  %CTS_PASS%  |  %CTS_PASS%  |    |    | |' >> uniq-results.twiki
done < "$FILE"

rm "$FILE"

for i in kbl skl bdw hsw; do for j in fail warning not_supported internal_error; do ./fill-twiki-table-column.sh $j $i $i/results-$j-$i.txt uniq-results.twiki; done; done

./clean-twiki-table.sh uniq-results.twiki
