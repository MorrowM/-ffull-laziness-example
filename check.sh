#!/bin/sh

run() {
    echo "Compiling and running with $1..."
    ghc Main.hs -O -ddump-simpl -dsuppress-all -dno-suppress-type-signatures -dno-typeable-binds -fforce-recomp -ddump-to-file "$1" > /dev/null
    exitcode=$?

    if [ $exitcode -ne 0 ]; then
        exit $exitcode
    fi
   
    mv Main.dump-simpl "Main.$1.dump-simpl"
    rm Main.o
    rm Main.hi
    ./Main +RTS -s 2>&1 >/dev/null | grep "maximum residency"
}

run -fno-full-laziness
run -ffull-laziness
