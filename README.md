# 🧊 VoxelOS

**VoxelOS** is a hobby operating system developed from scratch using **Rust and x86_64 Assembly**.

The project aims to explore operating system development, low-level programming, computer architecture, memory management and hardware interaction.

> 🚧 VoxelOS is currently under development.

## ⚙️ Technologies

- **Rust** — Kernel development.
- **NASM** — Assembly boot code.
- **GRUB 2** — Bootloader.
- **Multiboot2** — Kernel loading protocol.
- **QEMU** — Virtual machine for testing.
- **x86_64** — Target architecture.

## 📁 Project Structure

```text
VoxelOS/
├── boot/
│   └── boot.asm
├── kernel/
│   ├── src/
│   │   ├── main.rs
│   │   ├── vga_buffer.rs
│   │   ├── keyboard.rs
│   │   └── shell.rs
│   ├── Cargo.toml
│   └── linker.ld
├── iso/
│   └── boot/
│       └── grub/
│           └── grub.cfg
├── build/
├── .cargo/
│   └── config.toml
└── build.sh
```

## ✨ Implemented Features

### Bootloader & Kernel
- [x] Multiboot2 header.
- [x] GRUB boot integration.
- [x] x86_64 Long Mode initialization.
- [x] GDT configuration.
- [x] Basic paging with identity mapping.
- [x] Rust `no_std` kernel.

### VGA Driver
- [x] Direct VGA text buffer access.
- [x] Character output.
- [x] String output.
- [x] Newline handling.
- [x] Screen clearing.
- [x] VGA foreground and background colors.
- [x] Color enumeration.

### Keyboard Driver
- [x] PS/2 keyboard input.
- [x] Scancode reading.
- [x] Scancode-to-character conversion.
- [x] US QWERTY key mapping.
- [x] Input availability checking.

### Shell
- [x] Shell data structure.
- [x] Input buffer.
- [x] Character insertion.
- [x] Character removal.
- [x] Input retrieval.

## 🛠️ Building

Requirements:

- Rust toolchain
- NASM
- GRUB utilities
- xorriso
- mtools
- QEMU

Compile the project:

```bash
./build.sh build
```

Compile and run using QEMU:

```bash
./build.sh run
```

## 🖥️ Development

VoxelOS is currently a work in progress.

The next development goals include:

- [ ] Complete terminal input handling.
- [ ] Backspace and Enter integration.
- [ ] Command parser.
- [ ] Initial shell commands (`help`, `clear`, `echo`, `about`).
- [ ] Keyboard Shift and Caps Lock support.
- [ ] Screen scrolling.
- [ ] Interrupt handling.
- [ ] Memory management.
- [ ] Filesystem implementation.

## 🎯 Project Goal

The ultimate goal is to build a functional operating system from the ground up, understanding and implementing its fundamental components rather than relying on an existing kernel.

---

**VoxelOS — Built from scratch, one instruction at a time.** 🧊
