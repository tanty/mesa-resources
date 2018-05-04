#!/bin/bash


case "x$1" in
     "xbaltix")
	 ARCH="kbl"
	  ;;

     "xpanix")
	 ARCH="skl"
	 ;;

     "xpacifix")
	 ARCH="bdw"
	 ;;

     "xelastix")
	 ARCH="hsw"
	 ;;

     *)
	 echo "Syntax error"
	 exit -1
	 ;;
esac

mkdir $ARCH

cd $1

for i in $(rgrep 'StatusCode="F' | sort | uniq | cut -f 1 -d :); do grep -e 'StatusCode="F' -e 'CasePath' $i | sed '/CaseType/{$!{N;s/CaseType.*>\n.*StatusCode/Status/;ty;P;D;:y}}' | grep Status; done | sort | uniq | sed s':.*CasePath="::'g| cut -f1 -d \" | sort | uniq | sort > ../$ARCH/results-fail-$ARCH.txt

for i in $(rgrep 'StatusCode="I' | sort | uniq | cut -f 1 -d :); do grep -e 'StatusCode="I' -e 'CasePath' $i | sed '/CaseType/{$!{N;s/CaseType.*>\n.*StatusCode/Status/;ty;P;D;:y}}' | grep Status; done | sort | uniq | sed s':.*CasePath="::'g| cut -f1 -d \" | sort | uniq | sort > ../$ARCH/results-internal_error-$ARCH.txt

for i in $(rgrep 'StatusCode="C' | sort | uniq | cut -f 1 -d :); do grep -e 'StatusCode="C' -e 'CasePath' $i | sed '/CaseType/{$!{N;s/CaseType.*>\n.*StatusCode/Status/;ty;P;D;:y}}' | grep Status; done | sort | uniq | sed s':.*CasePath="::'g| cut -f1 -d \" | sort | uniq | sort > ../$ARCH/results-warning-$ARCH.txt

for i in $(rgrep 'StatusCode="Q' | sort | uniq | cut -f 1 -d :); do grep -e 'StatusCode="Q' -e 'CasePath' $i | sed '/CaseType/{$!{N;s/CaseType.*>\n.*StatusCode/Status/;ty;P;D;:y}}' | grep Status; done | sort | uniq | sed s':.*CasePath="::'g| cut -f1 -d \" | sort | uniq | sort >> ../$ARCH/results-warning-$ARCH.txt

for i in $(rgrep 'StatusCode="N' | sort | uniq | cut -f 1 -d :); do grep -e 'StatusCode="N' -e 'CasePath' $i | sed '/CaseType/{$!{N;s/CaseType.*>\n.*StatusCode/Status/;ty;P;D;:y}}' | grep Status; done | sort | uniq | sed s':.*CasePath="::'g| cut -f1 -d \" | sort | uniq | sort > ../$ARCH/results-not_supported-$ARCH.txt

cd -
