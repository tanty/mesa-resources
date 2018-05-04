#!/bin/bash

case "x$1" in
     "xfail")
	  GTT_RESULT="FAIL"
	  ;;

     "xwarning")
	 GTT_RESULT="WARNING"
	 ;;

     "xinternal_error")
	 GTT_RESULT="INTERNAL_ERROR"
	 ;;

     "xnot_supported")
	 GTT_RESULT="NOT_SUPPORTED"
	 ;;

     *)
	 echo "Syntax error"
	 exit -2
	 ;;
esac

case "x$2" in
     "xkbl")
	 GTT_ORIGINAL='%CTS_PASS%  |  %CTS_PASS%  |  %CTS_PASS%  |  %CTS_PASS%  |    |    | |'
	 GTT_MODIFICATION='%CTS_'$GTT_RESULT'%  |  %CTS_PASS%  |  %CTS_PASS%  |  %CTS_PASS%  |    |    | |'
	 ;;

     "xskl")
	 GTT_ORIGINAL='%CTS_PASS%  |  %CTS_PASS%  |  %CTS_PASS%  |    |    | |'
	 GTT_MODIFICATION='%CTS_'$GTT_RESULT'%  |  %CTS_PASS%  |  %CTS_PASS%  |    |    | |'
	 ;;

     "xbdw")
	 GTT_ORIGINAL='%CTS_PASS%  |  %CTS_PASS%  |    |    | |'
	 GTT_MODIFICATION='%CTS_'$GTT_RESULT'%  |  %CTS_PASS%  |    |    | |'
	 ;;

     "xhsw")
	 GTT_ORIGINAL='%CTS_PASS%  |    |    | |'
	 GTT_MODIFICATION='%CTS_'$GTT_RESULT'%  |    |    | |'
	 ;;

     *)
	 echo "Syntax error"
	 exit -1
	 ;;
esac

if [ "x$3" == "x" ]; then
	 echo "Syntax error"
	 exit -3
else
    GTT_FILE="$3"
fi

if [ "x$4" == "x" ]; then
	 echo "Syntax error"
	 exit -3
else
    GTT_TWIKI_FILE="$4"
fi

while IFS='' read -r GTT_LINE || [[ -n "$GTT_LINE" ]]; do
    sed -i "s:\(| =${GTT_LINE}=  |.*\)${GTT_ORIGINAL}:\1${GTT_MODIFICATION}:g" "$GTT_TWIKI_FILE"
#    echo "$GTT_LINE"
#    echo $GTT_ORIGINAL
#    echo $GTT_MODIFICATION
#    sed "s:\(| =${GTT_LINE}=  |.*\)${GTT_ORIGINAL}:\1${GTT_MODIFICATION}:g" "$GTT_TWIKI_FILE"
done < "$GTT_FILE"

exit 0
