use common;

fn main() {

    println!("Type a number: ");
    let n: u64 = common::read_input_u64();

    println!("Input number: {}", n);

    for _i in 0..=n/2 {
            println!("{}", 2 * _i);
    }

}