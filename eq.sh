START=$1
END=$2
FILENAME=$3

if [[ -e $FILENAME ]]
then 
    echo $FILENAME exists
    awk "/$START/,/$END/"'{print $0}' $FILENAME
else
    echo "$FILENAME is not defined"
fi
