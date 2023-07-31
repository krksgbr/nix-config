usage="usage: android (-m | -u) "

dir=/home/gabor/android
mkdir -p "$dir"

case $1 in
    -m)
        sudo jmtpfs -o allow_other $dir
        echo "$dir"
        ;;
    -u)
        sudo fusermount -u $dir
        echo "$dir"
        ;;
    *)
        echo $usage
        exit 1
esac
