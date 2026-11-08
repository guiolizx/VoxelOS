
#!/bin/bash

set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"

cd "$ROOT"

mkdir -p build

build() {
    echo "==> Compiling Assembly..."
    nasm -f elf64 boot/boot.asm -o build/boot.o

    echo "==> Compiling Rust kernel..."
    cd kernel
    cargo build
    cd "$ROOT"

    echo "==> Copying kernel..."
    cp kernel/target/x86_64-unknown-none/debug/kernel iso/boot/kernel

    echo "==> Generating ISO..."
    grub-mkrescue -o build/VoxelOS.iso iso

    echo "==> Build completed!"
}

case "$1" in
    build)
        build
        ;;
    run)
        build
        echo "==> Starting VoxelOS in QEMU..."
        qemu-system-x86_64 -cdrom build/VoxelOS.iso -m 1024
        ;;
    *)
        echo "VoxelOS Build System"
        echo ""
        echo "Usage: ./build.sh [command]"
        echo ""
        echo "  build   Compile the OS"
        echo "  run     Compile and run in QEMU"
        exit 1
        ;;
esac
