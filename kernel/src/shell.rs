use core::char;

const BUFFER_SIZE: usize = 256;

pub struct Shell {
    input: [u8; BUFFER_SIZE],
    lenght: usize
}

impl Shell{
    pub fn new() -> Self{
        Self{
            input: [0;BUFFER_SIZE],
            lenght: 0
        }
    }

    pub fn push_char(&mut self, character: u8){
        if self.lenght < BUFFER_SIZE {
            self.input[self.lenght] = character;
            self.lenght+=1;
        }
    }

    pub fn pop_char(&mut self){
        if self.lenght > 0{
            self.lenght -= 1;
            self.input[self.lenght] = 0;
        }
    }

    pub fn get_input(&self) -> &str{
        core::str::from_utf8(&self.input[..self.lenght])
            .unwrap_or("")
    }
}