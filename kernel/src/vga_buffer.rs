const VGA_BUFFER: *mut u8 = 0xB8000 as *mut u8;

const WIDTH: usize = 80;
const HEIGHT: usize = 25;

static mut CURSOR_ROW: usize = 0;
static mut CURSOR_COL: usize = 0;

#[repr(u8)]
pub enum Color{
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    Pink = 13,
    Yellow = 14,
    White = 15
}

pub fn color(foreground: Color, background: Color) -> u8 {
    (background as u8) << 4 | foreground as u8
}

pub fn write_char(row: usize, col: usize, character: u8, color: u8) {
    if row >= HEIGHT || col >= WIDTH {
        return;
    }

    let offset = (row * WIDTH + col) * 2;

    unsafe {
        core::ptr::write_volatile(VGA_BUFFER.add(offset), character);
        core::ptr::write_volatile(VGA_BUFFER.add(offset + 1), color);
    }
}

pub fn print(row: usize, col: usize, text: &str, color: u8) {
    for (i, byte) in text.bytes().enumerate() {
        write_char(row, col + i, byte, color);
    }
}

pub fn write_byte(byte: u8, color: u8) {
    unsafe {
        if byte == b'\n' {
            CURSOR_COL = 0;
            CURSOR_ROW += 1;
        } else {
            write_char(CURSOR_ROW, CURSOR_COL, byte, color);
            CURSOR_COL += 1;

            if CURSOR_COL >= WIDTH {
                CURSOR_COL = 0;
                CURSOR_ROW += 1;
            }
        }
    }
}

pub fn println(text: &str, color: u8){
    for byte in text.bytes() {
        write_byte(byte, color);
    }
}


pub fn clear_screen(color: u8) {
    for row in 0..HEIGHT{
        for col in 0..WIDTH {
            write_char(row,col,b' ', color);
        }
    }

    unsafe {
        CURSOR_COL = 0;
        CURSOR_ROW = 0;
    }
}