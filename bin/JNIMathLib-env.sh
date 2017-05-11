BINDIR=$(dirname $BASH_ARGV[0])
ROOTDIR=$(cd $BINDIR/..;pwd)

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTDIR/lib
export JNI_MATH_LIB=$ROOTDIR/$(cd $ROOTDIR && ls *.jar)
