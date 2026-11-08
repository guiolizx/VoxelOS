#![no_std]                                  // nao inclui a lib padrao do rust
#![no_main]                                 // nao usar o main() tradicional

mod vga_buffer;
mod keyboard;
mod shell;
use core::panic::PanicInfo;

use crate::vga_buffer::color;                 // informacoes sobre erros fatais

#[panic_handler]                            // define oq ocorrera caso panic
fn panic(_info: &PanicInfo) -> ! {          // -> ! informa q a funcao nunk retorna
    loop{
        unsafe {
            core::arch::asm!("hlt");        // pausar execucao 
        }
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn kernel_main() -> !{

    let color = color(vga_buffer::Color::White, vga_buffer::Color::Red);

    vga_buffer::println("VoxelOS A0.01\n", 0x0F);
    vga_buffer::println("Kernel Initialized\n", 0x0A);    
    vga_buffer::println("Keyboard Test!",color);



    loop{
        if keyboard::has_input(){
            let scancode = keyboard::read_scancode();
            

            if let Some(character) = keyboard::scancode_to_char(scancode){
                vga_buffer::write_byte(character as u8, 0x0F);
            }
        }
        // unsafe {
        //     core::arch::asm!("hlt");
        // }
    }
}