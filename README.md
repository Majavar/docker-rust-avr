This image contains a [fork of rust with AVR support](https://github.com/avr-rust/rust) and [avrdude](http://www.nongnu.org/avrdude/) to put the binary to the microcontroller.

You can use it to compile your program, generate the binary and push it onto the microcontroller.
# How to use this image
There are three commands:
* compile (default): compile your program
* binary: generate the binary in hex format
* program: program the microcontroller

```bash
docker run --rm -v "$(pwd)":/src --user "$(id -u)":"$(getent group arduino | cut -d: -f3)" --device=/dev/ttyACM0:/dev/avr:rwm majavar/avr-rust program
```
