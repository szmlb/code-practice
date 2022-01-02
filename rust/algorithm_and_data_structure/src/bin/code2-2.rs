use common;

fn main() {

    println!("Type loop number: ");
    let n: u64 = common::read_input_u64();

    println!("Input loop number: {}", n);

    let mut count = 0;
    print!("Double loop start...");
    for _i in 0..n {
        for _j in 0..n {
            count = count + 1;
        }
    }
    println!("end.");

}