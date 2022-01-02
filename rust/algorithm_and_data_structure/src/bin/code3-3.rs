use common;

fn main() {

    // Get input
    println!("Type a number of data: ");
    let n: usize = common::read_input_usize();

    println!("Type each data: ");
    let mut data = Vec::with_capacity(n);
    data.resize(n, 0);
    for i in 0..n {data[i] = common::read_input_u64();}

    // Check input data
    println!("Input data:");
    for val in data.iter() {
        println!("{}", val);
    }

    // Find minimum
    // Linear search
    let mut min_value = std::u64::MAX;
    for val in data.iter().enumerate() {
        if val.1 < &min_value {
            min_value = *val.1
        }
    }

    println!("{}", min_value);
}