use common;

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type each data: ");
    let mut data = Vec::with_capacity(n);
    data.resize(n, 0);
    for i in 0..n {data[i] = common::read_input_u64();}

    println!("Type target data: ");
    let mut find_id = -1;
    let v: u64 = common::read_input_u64();

    // Check input data
    println!("Input data:");
    for val in data.iter() {
        println!("{}", val);
    }

    // Find target data
    for val in data.iter().enumerate() {
        if val.1 == &v {
            find_id = val.0 as i64;
            break;
        }
    }

    println!("{}", find_id);
}