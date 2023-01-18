const rvm_wat = `

;; RVM implementation in WebAssembly Text format:

(module
    ;; Imports from JavaScript
    (import "env" "getchar" (func $getchar (param) (result i32)))
    (import "env" "putchar" (func $putchar (param i32)))
    
    ;; Data section of our module
;;    (data (i32.const 0)
;;          ");'u?>vD?>vRD?>vRA?>vRA?>vR:?>vR=!(:lkm!':lkv6y") ;; RVM code that prints HELLO!
    
    ;; Declaration of "main" function that is exported:
    (func (export  "main")
          i32.const 65 ;; pass 65 to $putchar
          call $putchar
          i32.const 66 ;; pass 66 to $putchar
          call $putchar
          i32.const 10 ;; pass 10 to $putchar
          call $putchar
    )
)

`;

// Execute the RVM implementation by converting it to wasm (using the wabt
// module) then compiling it to a module, and then loading the module.

require('wabt')().then(async wabt => {

    const fs = require('fs');
    const process = require('process');

    const wasmModule = wabt.parseWat('rvm.wat', rvm_wat);
    const { buffer } = wasmModule.toBinary({});

    const importObj = {
        env:
        {
            putchar: function (x) {
                process.stdout.write(String.fromCharCode(x));
            },
            getchar: function () {
                const buffer = Buffer.alloc(1);
                try {
                    fs.readSync(process.stdin.fd, buffer, 0, 1);
                    return buffer[0];
                } catch (e) {
                    return -1; // end-of-file
                }
            },
        },
    };
            
    const { instance } = await WebAssembly.instantiate(buffer, importObj);

    instance.exports.main(); // run main function of wasm code
});
