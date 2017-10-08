#!/bin/sh

compile() {
    cargo build --release --target ${TARGET}
}

get_name() {
    name=$(basename -s .elf $(ls ./target/${TARGET}/release/*.elf))
}

convert() {
    avr-objcopy -O ihex -R .eeprom ./target/${TARGET}/release/${name}.elf ./target/${TARGET}/release/${name}.hex
}

program() {
    avrdude -D -p ${PARTNO} -c ${PROGRAMMER} -P /dev/avr -U flash:w:./target/${TARGET}/release/${name}.hex:i
}

case "$1" in
    compile)
        compile
        ;;
    binary)
        compile
        get_name
        convert
        ;;
    program)
        compile
        get_name
        convert
        program
        ;;
    *)
        echo "Usage: $0 {compile|binary|program}"
        exit 1
        ;;
esac
